# Claude Code - fetched directly from Anthropic's distribution
# Update version and hashes when new releases are available at:
# https://github.com/anthropics/claude-code/releases
{
  lib,
  stdenv,
  fetchurl,
  makeWrapper,
  autoPatchelfHook,
  bubblewrap,
  socat,
}:

let
  version = "2.1.100";

  # Platform-specific hashes for the pre-built binaries
  hashes = {
    x86_64-linux = "sha256-dLNyzz5KYVtLFowfQxM4p52OQPqBMFUzmKQ4+STYHGY=";
    aarch64-linux = "sha256-3kQjfvW/G3c0L0t49NHQKwMnZ98USseYrVDYSi45rHM=";
    x86_64-darwin = "sha256-hnXwQ6nEEC5GDkhRZ9ELoEtGP1r5GTJ2XUXCe/JfJbo=";
    aarch64-darwin = "sha256-DE1Yv97jONpHNT6v2fDbd+x8SjDmxb6mKcU1+RzrpiQ=";
  };

  platformMap = {
    x86_64-linux = "linux-x64";
    aarch64-linux = "linux-arm64";
    x86_64-darwin = "darwin-x64";
    aarch64-darwin = "darwin-arm64";
  };

  platform = stdenv.hostPlatform.system;
  platformSuffix = platformMap.${platform} or (throw "Unsupported system: ${platform}");
in
stdenv.mkDerivation {
  pname = "claude-code";
  inherit version;

  src = fetchurl {
    url = "https://storage.googleapis.com/claude-code-dist-86c565f3-f756-42ad-8dfa-d59b1c096819/claude-code-releases/${version}/${platformSuffix}/claude";
    hash = hashes.${platform} or (throw "Unsupported platform: ${platform}");
  };

  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper ];

  dontStrip = true; # do not mess with the bun runtime

  installPhase = ''
    runHook preInstall

    install -Dm755 $src $out/bin/claude

    runHook postInstall
  '';

  # Disable auto-updates, telemetry, and installation method warnings
  postFixup = ''
    wrapProgram $out/bin/claude \
      --argv0 claude \
      --set DISABLE_AUTOUPDATER 1 \
      --set CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC 1 \
      --set DISABLE_NON_ESSENTIAL_MODEL_CALLS 1 \
      --set DISABLE_TELEMETRY 1 \
      --set DISABLE_INSTALLATION_CHECKS 1 ${lib.optionalString stdenv.hostPlatform.isLinux "--prefix PATH : ${
        lib.makeBinPath [
          bubblewrap
          socat
        ]
      }"}
  '';

  # Bun links against /usr/lib/libicucore.A.dylib which needs ICU data from
  # /usr/share/icu/ at runtime for Intl.Segmenter. The Nix macOS sandbox
  # blocks access to /usr/share/icu/, causing "failed to initialize Segmenter".
  __noChroot = stdenv.hostPlatform.isDarwin;

  meta = {
    description = "Agentic coding tool that lives in your terminal, understands your codebase, and helps you code faster";
    homepage = "https://claude.ai/code";
    changelog = "https://github.com/anthropics/claude-code/releases";
    license = lib.licenses.unfree;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    mainProgram = "claude";
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  };
}
