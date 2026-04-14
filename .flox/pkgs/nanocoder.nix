# Nanocoder - custom local derivation (decoupled from numtide upstream)
# Repo moved from Mote-Software to Nano-Collective
{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  pnpmConfigHook,
  fetchPnpmDeps,
  pnpm,
}:

buildNpmPackage rec {
  pname = "nanocoder";
  version = "1.25.2";

  src = fetchFromGitHub {
    owner = "Nano-Collective";
    repo = "nanocoder";
    rev = "v${version}";
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    postFetch = ''
      rm -f $out/pnpm-workspace.yaml
    '';
  };

  npmConfigHook = pnpmConfigHook;
  npmDeps = pnpmDeps;
  pnpmDeps = fetchPnpmDeps {
    inherit pname version src;
    fetcherVersion = 2;
    hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
  };

  nativeBuildInputs = [ pnpm ];

  dontNpmPrune = true; # hangs forever on both Linux/darwin

  meta = with lib; {
    description = "A beautiful local-first coding agent running in your terminal - built by the community for the community";
    homepage = "https://github.com/Nano-Collective/nanocoder";
    changelog = "https://github.com/Nano-Collective/nanocoder/releases";
    sourceProvenance = with lib.sourceTypes; [ fromSource ];
    license = licenses.mit;
    platforms = platforms.all;
    mainProgram = "nanocoder";
  };
}
