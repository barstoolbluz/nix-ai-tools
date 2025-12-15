{ callPackage, fetchFromGitHub }:
let
  # Temporarily use older upstream for v1.17.3
  upstream = fetchFromGitHub {
    owner = "numtide";
    repo = "nix-ai-tools";
    rev = "e2b2ff4cf805cda9a8c3b290e6c33f1a5bb47f60";
    hash = "sha256-FKWFpk937KfmCK3/qQBs1P5JRWIvSIc3xvhZ1mjhsck=";
  };
in
callPackage "${upstream}/packages/nanocoder/package.nix" { }
