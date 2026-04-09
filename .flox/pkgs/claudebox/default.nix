{
  pkgs,
  lib,
  stdenv,
  callPackage,
  makeWrapper,
  nodejs,
  bashInteractive,
  bubblewrap,
  git,
  ripgrep,
  fd,
  coreutils,
  gnugrep,
  gnused,
  gawk,
  findutils,
  which,
  tree,
  curl,
  wget,
  jq,
  less,
  zsh,
  nix,
}:
let
  inherit (stdenv) isLinux isDarwin;

  # Build our local claude-code package
  claude-code = callPackage ../claude-code.nix { };

  # Bundle all the tools Claude needs into a single environment
  claudeTools = pkgs.buildEnv {
    name = "claude-tools";
    paths = [
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

  # Platform-specific sandbox tools
  sandboxTools = if isLinux then [ bubblewrap ] else [ ];

  sourceDir = ./src;
in
pkgs.runCommand "claudebox"
  {
    buildInputs = [ makeWrapper ];
    meta = with lib; {
      mainProgram = "claudebox";
      description = "Sandboxed environment for Claude Code";
      homepage = "https://github.com/numtide/claudebox";
      sourceProvenance = with sourceTypes; [ fromSource ];
      platforms = platforms.linux ++ platforms.darwin;
    };
  }
  ''
    mkdir -p $out/bin $out/share/claudebox $out/libexec/claudebox

    # Install claudebox launcher script
    cp ${sourceDir}/claudebox.js $out/libexec/claudebox/claudebox.js

    # Install seatbelt profile for macOS
    cp ${sourceDir}/seatbelt.sbpl $out/share/claudebox/seatbelt.sbpl

    # Create claudebox executable with platform-specific configuration
    makeWrapper ${nodejs}/bin/node $out/bin/claudebox \
      --add-flags $out/libexec/claudebox/claudebox.js \
      --prefix PATH : ${
        lib.makeBinPath (
          [
            bashInteractive
            claudeTools
          ]
          ++ sandboxTools
        )
      } \
      ${if isDarwin then "--set CLAUDEBOX_SEATBELT_PROFILE $out/share/claudebox/seatbelt.sbpl" else ""}

    # Create claude wrapper
    makeWrapper ${claude-code}/bin/.claude-wrapped $out/libexec/claudebox/claude \
      --set DISABLE_AUTOUPDATER 1 \
      --inherit-argv0
  ''
