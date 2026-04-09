{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  gcc-unwrapped,
  makeWrapper,
  postgresql,
}:
let
  version = "0.24.0";

  platformMap = {
    "x86_64-linux" = "x86_64-unknown-linux-gnu";
    "aarch64-linux" = "aarch64-unknown-linux-gnu";
    "x86_64-darwin" = "x86_64-apple-darwin";
    "aarch64-darwin" = "aarch64-apple-darwin";
  };

  currentPlatform = platformMap.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  sources = {
    "x86_64-linux" = "sha256-q4b1bZGXB0m/2505Ve9XH82M8iJR1t1aiRKrN6GtMzI=";
    "aarch64-linux" = "sha256-KbmN13edYUZGoRhPKYMiADMN0sUUmTxL8qJjZgk60+w=";
    "x86_64-darwin" = "sha256-EIn74VJsFNr1CW9VYIbcwVMUPr6DEUMqjnvo1hxFRa4=";
    "aarch64-darwin" = "sha256-wvd/1LwjfnYeI9Zkbtv9GR5GhOKDQhgu1ozk8GnSk9Q=";
  };
in
stdenv.mkDerivation {
  pname = "ironclaw";
  inherit version;

  src = fetchurl {
    url = "https://github.com/nearai/ironclaw/releases/download/ironclaw-v${version}/ironclaw-${currentPlatform}.tar.gz";
    hash = sources.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
  };

  sourceRoot = "ironclaw-${currentPlatform}";

  nativeBuildInputs = [ makeWrapper ] ++ lib.optionals stdenv.isLinux [
    autoPatchelfHook
  ];

  buildInputs = lib.optionals stdenv.isLinux [
    gcc-unwrapped.lib
  ];

  dontBuild = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin

    # Install the ironclaw binary
    install -m755 ironclaw $out/bin/ironclaw

    # --- Helper scripts bundled from the Flox runtime environment ---

    # ironclaw-pg-init: Initialize PostgreSQL data directory for ironclaw
    cat > $out/bin/ironclaw-pg-init << 'SCRIPT'
    #!/usr/bin/env bash
    set -euo pipefail
    PGDATA="''${PGDATA:?Set PGDATA before running ironclaw-pg-init}"
    PGPORT="''${PGPORT:-15432}"
    PGHOST="''${PGHOST:?Set PGHOST before running ironclaw-pg-init}"

    if [ -d "$PGDATA" ]; then
      echo "PostgreSQL data directory already exists: $PGDATA"
      exit 0
    fi

    echo "Initializing PostgreSQL data directory..."
    initdb --no-locale --encoding=UTF8 -D "$PGDATA" >/dev/null 2>&1
    echo "unix_socket_directories = '$PGHOST'" >> "$PGDATA/postgresql.conf"
    echo "port = $PGPORT" >> "$PGDATA/postgresql.conf"
    echo "listen_addresses = ''''" >> "$PGDATA/postgresql.conf"
    echo "PostgreSQL initialized at $PGDATA (port $PGPORT)"
    SCRIPT
    chmod +x $out/bin/ironclaw-pg-init

    # ironclaw-pg-start: Start PostgreSQL and configure pgvector for ironclaw
    cat > $out/bin/ironclaw-pg-start << 'SCRIPT'
    #!/usr/bin/env bash
    set -euo pipefail
    PGDATA="''${PGDATA:?Set PGDATA before running ironclaw-pg-start}"
    PGPORT="''${PGPORT:-15432}"
    PGHOST="''${PGHOST:?Set PGHOST before running ironclaw-pg-start}"
    PGDATABASE="''${PGDATABASE:-ironclaw}"

    # Initialize if needed
    if [ ! -d "$PGDATA" ]; then
      ironclaw-pg-init
    fi

    # Start PostgreSQL
    postgres -D "$PGDATA" -k "$PGHOST" -p "$PGPORT" &
    PG_PID=$!

    # Wait for readiness
    for i in $(seq 1 30); do
      pg_isready -h "$PGHOST" -p "$PGPORT" >/dev/null 2>&1 && break
      sleep 1
    done

    # Create database and pgvector extension
    if pg_isready -h "$PGHOST" -p "$PGPORT" >/dev/null 2>&1; then
      if ! psql -h "$PGHOST" -p "$PGPORT" -lqt 2>/dev/null | grep -qw "$PGDATABASE"; then
        createdb -h "$PGHOST" -p "$PGPORT" "$PGDATABASE" 2>/dev/null
      fi
      psql -h "$PGHOST" -p "$PGPORT" -d "$PGDATABASE" -c "CREATE EXTENSION IF NOT EXISTS vector;" >/dev/null 2>&1
      echo "PostgreSQL ready: $PGDATABASE on port $PGPORT (pgvector enabled)"
    fi

    wait $PG_PID
    SCRIPT
    chmod +x $out/bin/ironclaw-pg-start

    # ironclaw-pg-detect: Detect running PostgreSQL and print DATABASE_URL
    cat > $out/bin/ironclaw-pg-detect << 'SCRIPT'
    #!/usr/bin/env bash
    set -euo pipefail
    PGPORT="''${PGPORT:-15432}"
    PGHOST="''${PGHOST:-/tmp}"
    PGDATABASE="''${PGDATABASE:-ironclaw}"

    if pg_isready -h "$PGHOST" -p "$PGPORT" >/dev/null 2>&1; then
      echo "postgres://$PGHOST:$PGPORT/$PGDATABASE"
    else
      echo ""
    fi
    SCRIPT
    chmod +x $out/bin/ironclaw-pg-detect

    # ironclaw-port-check: Find an available port near the requested one
    cat > $out/bin/ironclaw-port-check << 'SCRIPT'
    #!/usr/bin/env bash
    set -euo pipefail
    PORT="''${1:-8080}"
    KILL="''${KILL:-0}"

    _port_in_use() {
      lsof -iTCP:"$1" -sTCP:LISTEN >/dev/null 2>&1 || \
        ss -tlnH 2>/dev/null | awk '{print $4}' | grep -qE "[:.]$1$"
    }

    if _port_in_use "$PORT"; then
      if [ "$KILL" = "1" ]; then
        _pid=$(lsof -iTCP:"$PORT" -sTCP:LISTEN -t 2>/dev/null | head -1)
        if [ -n "$_pid" ]; then
          kill "$_pid" 2>/dev/null
          sleep 1
        fi
        echo "$PORT"
      else
        _port=$((PORT + 1))
        while _port_in_use "$_port"; do
          _port=$((_port + 1))
          [ "$_port" -gt "$((PORT + 100))" ] && { echo "$PORT"; exit 1; }
        done
        echo "$_port"
      fi
    else
      echo "$PORT"
    fi
    SCRIPT
    chmod +x $out/bin/ironclaw-port-check

    # ironclaw-info: Display configuration summary
    cat > $out/bin/ironclaw-info << 'SCRIPT'
    #!/usr/bin/env bash
    echo "IronClaw Environment Configuration"
    echo ""
    echo "IRONCLAW_HOME: ''${IRONCLAW_HOME:-not set}"
    echo ""
    echo "API Keys:"
    [ -n "''${ANTHROPIC_API_KEY:-}" ] && echo "  Anthropic: set" || echo "  Anthropic: not set"
    [ -n "''${OPENAI_API_KEY:-}" ] && echo "  OpenAI: set" || echo "  OpenAI: not set"
    [ -n "''${LLM_BACKEND:-}" ] && echo "  LLM backend: $LLM_BACKEND"
    echo ""
    echo "Commands:"
    echo "  ironclaw                     Start interactive REPL"
    echo "  ironclaw onboard             First-time setup wizard"
    echo "  ironclaw-pg-init             Initialize PostgreSQL for pgvector"
    echo "  ironclaw-pg-start            Start PostgreSQL service"
    echo "  ironclaw-pg-detect           Print DATABASE_URL if PostgreSQL running"
    echo "  ironclaw-port-check [PORT]   Find available port"
    echo ""
    echo "LLM backend examples:"
    echo "  LLM_BACKEND=anthropic ironclaw"
    echo "  LLM_BACKEND=openai ironclaw"
    echo "  LLM_BACKEND=ollama ironclaw"
    echo ""
    SCRIPT
    chmod +x $out/bin/ironclaw-info

    runHook postInstall
  '';

  postFixup = ''
    # Wrap helper scripts to include postgresql tools in PATH
    for f in ironclaw-pg-init ironclaw-pg-start ironclaw-pg-detect ironclaw-port-check ironclaw-info; do
      wrapProgram $out/bin/$f \
        --prefix PATH : $out/bin:${lib.makeBinPath [ postgresql ]}
    done
  '';

  meta = with lib; {
    description = "IronClaw - Secure, open-source personal AI assistant built in Rust";
    homepage = "https://github.com/nearai/ironclaw";
    license = with licenses; [ mit asl20 ];
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    mainProgram = "ironclaw";
  };
}
