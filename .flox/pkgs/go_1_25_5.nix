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
  version = "1.25.5";
  platform = stdenv.hostPlatform;

  # Platform-specific download URLs and hashes
  sources = {
    "x86_64-linux" = {
      url = "https://go.dev/dl/go${version}.linux-amd64.tar.gz";
      hash = "sha256-npt1XWOzas8wwSqaP8N5JDcUwcbT3XKGHaY38zbrs1s=";
    };
    "aarch64-linux" = {
      url = "https://go.dev/dl/go${version}.linux-arm64.tar.gz";
      # Would need to fetch this hash if supporting ARM
      hash = "";
    };
    "x86_64-darwin" = {
      url = "https://go.dev/dl/go${version}.darwin-amd64.tar.gz";
      # Would need to fetch this hash if supporting macOS
      hash = "";
    };
    "aarch64-darwin" = {
      url = "https://go.dev/dl/go${version}.darwin-arm64.tar.gz";
      # Would need to fetch this hash if supporting macOS ARM
      hash = "";
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

    # Create necessary symlinks
    ln -s $out/bin/go $out/bin/gofmt

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
    GOARCH = platform.parsed.cpu.name;
  };

  meta = with lib; {
    description = "The Go Programming Language (version ${version})";
    homepage = "https://go.dev/";
    license = licenses.bsd3;
    platforms = platforms.unix;
    mainProgram = "go";
  };
}