{ pkgs, callPackage, fetchFromGitHub }:
let
  upstream = import ./fetch-upstream.nix { inherit fetchFromGitHub; };

  # Get claude-code from upstream
  claude-code = callPackage "${upstream}/packages/claude-code/package.nix" { };

  # Bundle essential tools
  claudeTools = pkgs.buildEnv {
    name = "claude-tools";
    paths = with pkgs; [
      git
      ripgrep
      fd
      coreutils
      gnugrep
      gnused
      gawk
      findutils
      which
      tree
      curl
      wget
      jq
      less
      zsh
      nix
    ];
  };
in
pkgs.stdenv.mkDerivation rec {
  pname = "claudebox";
  version = "0.1.0";

  src = ./claudebox-files;

  dontBuild = true;

  nativeBuildInputs = [ pkgs.makeWrapper ];

  meta = with pkgs.lib; {
    description = "Sandboxed environment for Claude Code";
    homepage = "https://github.com/barstoolbluz/nix-ai-tools";
    license = licenses.mit;
    sourceProvenance = with sourceTypes; [ fromSource ];
    platforms = platforms.linux;
    mainProgram = "claudebox";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin

    # Install the wrapper script
    cp $src/claudebox.sh $out/bin/claudebox
    chmod +x $out/bin/claudebox

    # Patch shebang
    patchShebangs $out/bin/claudebox

    # Wrap with required tools
    wrapProgram $out/bin/claudebox \
      --prefix PATH : ${
        pkgs.lib.makeBinPath [
          claude-code
          pkgs.bashInteractive
          claudeTools
        ]
      }

    runHook postInstall
  '';
}