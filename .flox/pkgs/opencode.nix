{
  lib,
  stdenv,
  stdenvNoCC,
  fetchFromGitHub,
  fetchurl,
  bun,
  fzf,
  makeBinaryWrapper,
  ripgrep,
  writableTmpDirAsHomeHook,
  models-dev,
  autoPatchelfHook,
}:

let
  # Inline fetchBunDeps function for node_modules FOD
  fetchOpencodeNodeModules =
    { src, hash, ... }@args:
    stdenvNoCC.mkDerivation {
      pname = "opencode-node_modules";
      version = args.version or "1.0.168";
      inherit src;

      impureEnvVars = lib.fetchers.proxyImpureEnvVars ++ [
        "GIT_PROXY_COMMAND"
        "SOCKS_SERVER"
      ];

      nativeBuildInputs = [
        bun
        writableTmpDirAsHomeHook
      ];

      dontConfigure = true;

      buildPhase = ''
        runHook preBuild

        export BUN_INSTALL_CACHE_DIR=$(mktemp -d)

        bun install \
          --cpu="*" \
          --filter=./packages/opencode \
          --force \
          --frozen-lockfile \
          --ignore-scripts \
          --no-progress \
          --os="*" \
          --production

        runHook postBuild
      '';

      installPhase = ''
        runHook preInstall

        mkdir -p $out
        while IFS= read -r dir; do
          rel="''${dir#./}"
          dest="$out/$rel"
          mkdir -p "$(dirname "$dest")"
          cp -R "$dir" "$dest"
        done < <(find . -type d -name node_modules -prune | sort)

        runHook postInstall
      '';

      dontFixup = true;

      outputHash = hash;
      outputHashAlgo = "sha256";
      outputHashMode = "recursive";
    };

  version = "1.0.202";

  src = fetchFromGitHub {
    owner = "sst";
    repo = "opencode";
    tag = "v${version}";
    hash = "sha256-SEq8Dcv4R4t9faEfGFb0dPYAFdkhq0e+rPNk7jqhvkU=";
  };

  # Platform-specific hashes for node_modules (due to native dependencies)
  # Need new hash since we're adding packages
  nodeModulesHashes = {
    x86_64-linux = "sha256-nZsubzk/iXLLzSfUCaDMUce30WW0yZi2k4MJsuEbYuc=";
    aarch64-linux = "sha256-nZsubzk/iXLLzSfUCaDMUce30WW0yZi2k4MJsuEbYuc=";
    x86_64-darwin = "sha256-nZsubzk/iXLLzSfUCaDMUce30WW0yZi2k4MJsuEbYuc=";
    aarch64-darwin = "sha256-nZsubzk/iXLLzSfUCaDMUce30WW0yZi2k4MJsuEbYuc=";
  };

  node_modules = fetchOpencodeNodeModules {
    inherit version src;
    hash = nodeModulesHashes.${stdenv.hostPlatform.system} or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
  };

in
stdenv.mkDerivation {
  pname = "opencode";
  inherit version src;

  nativeBuildInputs = [
    bun
    makeBinaryWrapper
    models-dev
  ] ++ lib.optionals stdenv.isLinux [
    autoPatchelfHook
  ];

  buildInputs = lib.optionals stdenv.isLinux [
    stdenv.cc.cc.lib
  ];


  # Inline patches as strings
  patches = [
    # Patch: Relax Bun version check
    (builtins.toFile "relax-bun-version-check.patch" ''
      diff --git a/packages/script/src/index.ts b/packages/script/src/index.ts
      index 141d2b75..de06d0dc 100644
      --- a/packages/script/src/index.ts
      +++ b/packages/script/src/index.ts
      @@ -10,7 +10,7 @@ if (!expectedBunVersion) {
       }

       if (process.versions.bun !== expectedBunVersion) {
      -  throw new Error(`This script requires bun@''${expectedBunVersion}, but you are using bun@''${process.versions.bun}`)
      +  console.warn(`Warning: This script expects bun@''${expectedBunVersion}, but you are using bun@''${process.versions.bun}`)
       }

       const CHANNEL = process.env["OPENCODE_CHANNEL"] ?? (await $`git branch --show-current`.text().then((x) => x.trim()))
    '')
  ];

  dontConfigure = true;

  env.MODELS_DEV_API_JSON = "${models-dev}/dist/_api.json";
  env.OPENCODE_VERSION = version;
  env.OPENCODE_CHANNEL = "stable";

  buildPhase = ''
    runHook preBuild

    # Copy all node_modules including the .bun directory with actual packages
    cp -r ${node_modules}/source/node_modules .
    cp -r ${node_modules}/source/packages .

    cd packages/opencode

    # Fix permissions first
    chmod -R u+w ./node_modules

    # Comment out the missing provider imports
    sed -i 's/^import { createGroq }/\/\/ import { createGroq }/' src/provider/provider.ts
    sed -i 's/^import { createDeepInfra }/\/\/ import { createDeepInfra }/' src/provider/provider.ts
    sed -i 's/^import { createCerebras }/\/\/ import { createCerebras }/' src/provider/provider.ts
    sed -i 's/^import { createCohere }/\/\/ import { createCohere }/' src/provider/provider.ts
    sed -i 's/^import { createGateway }/\/\/ import { createGateway }/' src/provider/provider.ts
    sed -i 's/^import { createTogetherAI }/\/\/ import { createTogetherAI }/' src/provider/provider.ts
    sed -i 's/^import { createPerplexity }/\/\/ import { createPerplexity }/' src/provider/provider.ts

    # Define stub functions for the missing providers
    cat >> src/provider/provider.ts << 'EOF'

// Stub functions for missing providers
const createGroq = () => { throw new Error("@ai-sdk/groq not available in this build"); };
const createDeepInfra = () => { throw new Error("@ai-sdk/deepinfra not available in this build"); };
const createCerebras = () => { throw new Error("@ai-sdk/cerebras not available in this build"); };
const createCohere = () => { throw new Error("@ai-sdk/cohere not available in this build"); };
const createGateway = () => { throw new Error("@ai-sdk/gateway not available in this build"); };
const createTogetherAI = () => { throw new Error("@ai-sdk/togetherai not available in this build"); };
const createPerplexity = () => { throw new Error("@ai-sdk/perplexity not available in this build"); };
EOF
    mkdir -p ./node_modules/@opencode-ai
    rm -f ./node_modules/@opencode-ai/{script,sdk,plugin}
    ln -s $(pwd)/../../packages/script ./node_modules/@opencode-ai/script
    ln -s $(pwd)/../../packages/sdk/js ./node_modules/@opencode-ai/sdk
    ln -s $(pwd)/../../packages/plugin ./node_modules/@opencode-ai/plugin

    ${lib.optionalString stdenv.isLinux ''
      # Patch native modules for Linux
      echo "Patching native modules with autoPatchelf..."
      autoPatchelf ./node_modules
    ''}

    # Bundle the application with version defines - inline the bundle script
    cat > ./bundle.ts << 'BUNDLE_EOF'
#!/usr/bin/env bun
import solidPlugin from "./node_modules/@opentui/solid/scripts/solid-plugin"
import fs from "fs"

const version = process.env.OPENCODE_VERSION!
const channel = process.env.OPENCODE_CHANNEL!

const result = await Bun.build({
  target: "bun",
  outdir: "./dist",
  entrypoints: [
    "./src/index.ts",
    "./src/cli/cmd/tui/worker.ts"
  ],
  plugins: [solidPlugin],
  naming: {
    entry: "[dir]/[name].js"
  },
  define: {
    OPENCODE_VERSION: JSON.stringify(version),
    OPENCODE_CHANNEL: JSON.stringify(channel),
  },
  external: [
    "@opentui/core-*",
  ],
})

if (!result.success) {
  console.error("Bundle failed:", result.logs)
  process.exit(1)
}

// Move worker file to worker.ts at the dist root so the code can find it
if (fs.existsSync("./dist/cli/cmd/tui/worker.js")) {
  fs.renameSync("./dist/cli/cmd/tui/worker.js", "./dist/worker.ts")
  fs.rmdirSync("./dist/cli/cmd/tui", { recursive: true })
}
BUNDLE_EOF

    chmod +x ./bundle.ts
    bun run ./bundle.ts

    # Fix WASM paths in worker.ts - use absolute paths to the installed location
    substituteInPlace ./dist/worker.ts \
      --replace-fail 'module2.exports = "../../../tree-sitter-' 'module2.exports = "'"$out"'/lib/opencode/dist/tree-sitter-'

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib/opencode
    # Copy the bundled dist directory
    cp -r dist $out/lib/opencode/

    # Copy only the native modules we need (marked as external in bundle.ts)
    mkdir -p $out/lib/opencode/node_modules/.bun
    mkdir -p $out/lib/opencode/node_modules/@opentui

    # Copy @opentui/core platform-specific packages
    for pkg in ../../node_modules/.bun/@opentui+core-*; do
      if [ -d "$pkg" ]; then
        cp -r "$pkg" $out/lib/opencode/node_modules/.bun/$(basename "$pkg")
      fi
    done

    mkdir -p $out/bin
    makeWrapper ${bun}/bin/bun $out/bin/opencode \
      --add-flags "run" \
      --add-flags "$out/lib/opencode/dist/index.js" \
      --prefix PATH : ${
        lib.makeBinPath [
          fzf
          ripgrep
        ]
      } \
      --argv0 opencode

    runHook postInstall
  '';

  postInstall = ''
    # Add symlinks for platform-specific native modules
    for pkg in $out/lib/opencode/node_modules/.bun/@opentui+core-*; do
      if [ -d "$pkg" ]; then
        pkgName=$(basename "$pkg" | sed 's/@opentui+\(core-[^@]*\)@.*/\1/')
        ln -sf ../.bun/$(basename "$pkg")/node_modules/@opentui/$pkgName \
               $out/lib/opencode/node_modules/@opentui/$pkgName
      fi
    done
  '';

  meta = {
    description = "AI coding agent built for the terminal";
    longDescription = ''
      OpenCode is a terminal-based agent that can build anything.
      It combines a TypeScript/JavaScript core with a Go-based TUI
      to provide an interactive AI coding experience.
    '';
    homepage = "https://github.com/sst/opencode";
    license = lib.licenses.mit;
    platforms = lib.platforms.unix;
    mainProgram = "opencode";
  };
}
