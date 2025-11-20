{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  gcc-unwrapped,
  makeWrapper,
  ripgrep,
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
    "x86_64-linux" = "sha256-jxRpCLi6pNPk7sVdF4fQlkr2qfR5h3Nh+FglpN8FGPY=";
    "aarch64-linux" = "sha256-dSPTQxYhv2SjuKAXZsDHXx9q28T2HdDGfkPGMpGsXJo=";
    "x86_64-darwin" = "sha256-c50V1Ll/lfBYZKe1Qp12x6EzVEcX4tWSnclvl7vBnF0=";
    "aarch64-darwin" = "sha256-mA98pAMB0RnJw9fWI9PdHSO6Jok4hJVuoXdZj7DL5YQ=";
  };

  # Construct download URL
  baseUrl = "https://downloads.factory.ai";
  droidUrl = "${baseUrl}/factory-cli/releases/${version}/${currentPlatform.platform}/${currentPlatform.arch}/droid";

  droidSrc = fetchurl {
    url = droidUrl;
    hash = sources.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
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

    mkdir -p $out/bin

    # Install droid binary
    install -m755 ${droidSrc} $out/bin/droid

    # Wrap droid to include ripgrep from nixpkgs in PATH
    wrapProgram $out/bin/droid \
      --prefix PATH : ${lib.makeBinPath [ ripgrep ]}

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
