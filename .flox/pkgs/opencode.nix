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
  fzf,
  ripgrep,
}:

let
  version = "1.2.10";

  # Platform-specific sources
  sources = {
    x86_64-linux = {
      url = "https://github.com/sst/opencode/releases/download/v${version}/opencode-linux-x64.tar.gz";
      hash = "sha256-68wkAS6PBnsQ10FkMMiOnEKRFez7zPjanrWds7Ypo1g=";
    };
    aarch64-linux = {
      url = "https://github.com/sst/opencode/releases/download/v${version}/opencode-linux-arm64.tar.gz";
      hash = "sha256-2anU8Lwe0kYljA6IRugFk3Vacr9K/TlAxAcdbwt7d3U=";
    };
    x86_64-darwin = {
      url = "https://github.com/sst/opencode/releases/download/v${version}/opencode-darwin-x64.zip";
      hash = "sha256-HZQZbvEZ6WXVcZLc4hJJCoGaSNY8+JyQxoFZ15Ct4Gc=";
    };
    aarch64-darwin = {
      url = "https://github.com/sst/opencode/releases/download/v${version}/opencode-darwin-arm64.zip";
      hash = "sha256-rYgGZLawEs2u/E0XWpav7zlcSBuTKMjrXbFDqGRK0dk=";
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
