# Nanocoder - custom local derivation (decoupled from numtide upstream)
# Repo moved from Mote-Software to Nano-Collective
{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
  pnpm_9,
}:

buildNpmPackage rec {
  pname = "nanocoder";
  version = "1.24.1";

  src = fetchFromGitHub {
    owner = "Nano-Collective";
    repo = "nanocoder";
    rev = "v${version}";
    hash = "sha256-WdPkjrPhhskE2EcWi3vGP5JqwmSW9Fxhwd1gM8ZHcXY=";
    postFetch = ''
      rm -f $out/pnpm-workspace.yaml
    '';
  };

  npmConfigHook = pnpm_9.configHook;
  npmDeps = pnpmDeps;
  pnpmDeps = pnpm_9.fetchDeps {
    inherit pname version src;
    fetcherVersion = 2;
    hash = "sha256-yHr1A++f//J6HTs5gJT8lV0xacN0XbZLY0kBEdU6qas=";
  };

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
