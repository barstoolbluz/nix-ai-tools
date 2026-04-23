# OpenCode - pre-built binary from GitHub releases
# Upstream switched to Bun compile for self-contained binaries in v1.2.x
# Update version and hashes when new releases are available at:
# https://github.com/sst/opencode/releases
{
  lib,
  stdenv,
  fetchurl,
  makeWrapper,
  autoPatchelfHook,
  unzip,
  fzf,
  ripgrep,
}:

let
  version = "1.14.21";

  # Platform-specific sources
  sources = {
    x86_64-linux = {
      url = "https://github.com/sst/opencode/releases/download/v${version}/opencode-linux-x64.tar.gz";
      hash = "sha256-yEBCYHd9zdhtXGnUA7V3TRqsxrOXV5k1ZwAypdRl8VQ=";
    };
    aarch64-linux = {
      url = "https://github.com/sst/opencode/releases/download/v${version}/opencode-linux-arm64.tar.gz";
      hash = "sha256-exYk8q6OMJ1Xhmhy3oTMBxKG3lngASHwGvMVpGKLoxo=";
    };
    x86_64-darwin = {
      url = "https://github.com/sst/opencode/releases/download/v${version}/opencode-darwin-x64.zip";
      hash = "sha256-4gvTAcE76Gy4H70sjxtIDjOgkLKJg5ZYnAyF98or2gc=";
    };
    aarch64-darwin = {
      url = "https://github.com/sst/opencode/releases/download/v${version}/opencode-darwin-arm64.zip";
      hash = "sha256-MHyxmG3J7IGZXG5KnD4cAHDnsRN0gpWRBojWMQ8GFnw=";
    };
  };

  platform = stdenv.hostPlatform.system;
  source = sources.${platform} or (throw "Unsupported platform: ${platform}");
in
stdenv.mkDerivation {
  pname = "opencode";
  inherit version;

  src = fetchurl {
    inherit (source) url hash;
  };

  dontUnpack = true;

  nativeBuildInputs = [
    makeWrapper
  ] ++ lib.optionals stdenv.isLinux [
    autoPatchelfHook
  ] ++ lib.optionals stdenv.isDarwin [
    unzip
  ];

  buildInputs = lib.optionals stdenv.isLinux [
    stdenv.cc.cc.lib
  ];

  dontStrip = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin

    ${if stdenv.hostPlatform.isLinux then ''
      tar -xzf $src -C $out/bin
    '' else ''
      unzip $src -d $out/bin
    ''}

    chmod +x $out/bin/opencode

    runHook postInstall
  '';

  postFixup = ''
    wrapProgram $out/bin/opencode \
      --prefix PATH : ${lib.makeBinPath [ fzf ripgrep ]}
  '';

  meta = {
    description = "AI coding agent built for the terminal";
    homepage = "https://github.com/sst/opencode";
    changelog = "https://github.com/sst/opencode/releases";
    license = lib.licenses.mit;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    mainProgram = "opencode";
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
  };
}
