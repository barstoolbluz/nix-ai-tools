{
  stdenv,
  fetchurl,
  lib,
  tzdata,
  iana-etc,
  libucontext ? null,
  installShellFiles,
  coreutils,
  security ? null,
  xcbuild ? null,
  mailcap,
  buildPackages,
}:

let
  version = "1.26.0";
  platform = stdenv.hostPlatform;

  # Platform-specific download URLs and hashes
  sources = {
    "x86_64-linux" = {
      url = "https://go.dev/dl/go${version}.linux-amd64.tar.gz";
      hash = "sha256-qsGwig+wxOCnwVVb63tZGAsF38Wj1i5A6d6QzUL4gjU=";
    };
    "aarch64-linux" = {
      url = "https://go.dev/dl/go${version}.linux-arm64.tar.gz";
      hash = "sha256-vQO3Q+tutBk+o8P9OVZUa/DjyltwdsgiYzSv5rdXBM0=";
    };
    "x86_64-darwin" = {
      url = "https://go.dev/dl/go${version}.darwin-amd64.tar.gz";
      hash = "sha256-HKKLdwPL6gWmWyodktazCGEO+S+IJFeKCHTy5gydWiI=";
    };
    "aarch64-darwin" = {
      url = "https://go.dev/dl/go${version}.darwin-arm64.tar.gz";
      hash = "sha256-sWQFJd/mjwZtVvIAvve/Tc6VWhqJO9Bh3mdUwhFDECM=";
    };
  };

  source = sources."${platform.system}" or (throw "Unsupported platform: ${platform.system}");

in
stdenv.mkDerivation {
  pname = "go";
  inherit version;

  src = fetchurl {
    inherit (source) url hash;
  };

  # The prebuilt Go binary is already complete
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall

    # Create output directory structure
    mkdir -p $out

    # Extract the tarball directly to $out
    tar -xzf $src -C $out --strip-components=1

    # Ensure binaries are executable
    chmod +x $out/bin/*

    # gofmt already exists in the extracted tarball, no need to symlink

    runHook postInstall
  '';

  # Set up the environment
  setupHook = ./setup-hook.sh;

  # Required for Go to function properly
  propagatedBuildInputs = [ tzdata iana-etc ];

  # Go needs these for CGO support
  CGO_ENABLED = 1;

  passthru = {
    # These attributes are expected by buildGoModule
    inherit version;
    CGO_ENABLED = 1;
    GOOS = platform.parsed.kernel.name;
    GOARCH = if platform.parsed.cpu.name == "x86_64" then "amd64"
            else if platform.parsed.cpu.name == "aarch64" then "arm64"
            else platform.parsed.cpu.name;
  };

  meta = with lib; {
    description = "The Go Programming Language (version ${version})";
    homepage = "https://go.dev/";
    license = licenses.bsd3;
    platforms = platforms.unix;
    mainProgram = "go";
  };
}
