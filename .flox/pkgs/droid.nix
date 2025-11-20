{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  gcc-unwrapped,
  makeWrapper,
}:
let
  version = "0.26.2";

  # Map Nix platforms to Factory AI platform naming
  platformMap = {
    "x86_64-linux" = {
      platform = "linux";
      arch = "x64";
    };
    "aarch64-linux" = {
      platform = "linux";
      arch = "arm64";
    };
    "x86_64-darwin" = {
      platform = "darwin";
      arch = "x64";
    };
    "aarch64-darwin" = {
      platform = "darwin";
      arch = "arm64";
    };
  };

  # Get platform/arch for current system
  currentPlatform = platformMap.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  # Source hashes for each platform
  sources = {
    "x86_64-linux" = {
      droid = "sha256-jxRpCLi6pNPk7sVdF4fQlkr2qfR5h3Nh+FglpN8FGPY=";
      rg = "sha256-xILKlqc+d5rOUqE0+/W/E+Qtu1hMqKUlIqGOYQs7+qg=";
    };
    "aarch64-linux" = {
      droid = "sha256-dSPTQxYhv2SjuKAXZsDHXx9q28T2HdDGfkPGMpGsXJo=";
      rg = "sha256-xm3Se8x35MEoSULcSfBJDQd7hKeywCnUj5T2Ks6sJLI=";
    };
    "x86_64-darwin" = {
      droid = "sha256-c50V1Ll/lfBYZKe1Qp12x6EzVEcX4tWSnclvl7vBnF0=";
      rg = "sha256-bkoPyeA+/spqoOFUO6uytDNzhZRnn3cdWkcfGH5w7qY=";
    };
    "aarch64-darwin" = {
      droid = "sha256-mA98pAMB0RnJw9fWI9PdHSO6Jok4hJVuoXdZj7DL5YQ=";
      rg = "sha256-PU+YdZZvjf5J6d5MdqKtzj+5i7mEHs/f9xO1p9h9S/Q=";
    };
  };

  # Get hashes for current platform
  currentHashes = sources.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");

  # Construct download URLs
  baseUrl = "https://downloads.factory.ai";
  droidUrl = "${baseUrl}/factory-cli/releases/${version}/${currentPlatform.platform}/${currentPlatform.arch}/droid";
  rgUrl = "${baseUrl}/ripgrep/${currentPlatform.platform}/${currentPlatform.arch}/rg";

  droidSrc = fetchurl {
    url = droidUrl;
    hash = currentHashes.droid;
  };

  rgSrc = fetchurl {
    url = rgUrl;
    hash = currentHashes.rg;
  };
in
stdenv.mkDerivation {
  pname = "droid";
  inherit version;

  dontUnpack = true;

  nativeBuildInputs =
    [ makeWrapper ]
    ++ lib.optionals stdenv.isLinux [
      autoPatchelfHook
    ];

  buildInputs = lib.optionals stdenv.isLinux [
    gcc-unwrapped.lib
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin $out/lib/factory

    # Install droid binary
    install -m755 ${droidSrc} $out/bin/droid

    # Install ripgrep
    install -m755 ${rgSrc} $out/lib/factory/rg

    # Wrap droid to include ripgrep in PATH
    wrapProgram $out/bin/droid \
      --prefix PATH : $out/lib/factory

    runHook postInstall
  '';

  meta = with lib; {
    description = "Factory AI's Droid - AI-powered development agent for your terminal";
    homepage = "https://factory.ai";
    license = licenses.unfree;
    sourceProvenance = with sourceTypes; [ binaryNativeCode ];
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
      "x86_64-darwin"
      "aarch64-darwin"
    ];
    mainProgram = "droid";
  };
}
