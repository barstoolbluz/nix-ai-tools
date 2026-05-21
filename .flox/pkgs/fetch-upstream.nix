# Shared helper to fetch upstream llm-agents.nix repository
# (formerly numtide/nix-ai-tools, renamed 2026-04)
# Update rev and hash when syncing with upstream
{ fetchFromGitHub }:
fetchFromGitHub {
  owner = "numtide";
  repo = "llm-agents.nix";
  rev = "339239b8e071b0294cc5b49b555d724761a68bf0";
  hash = "sha256-RC3GaOxJ/fQtXTw+km1fPAGso09+Jn/LCfiESZ/fxy0=";
}
