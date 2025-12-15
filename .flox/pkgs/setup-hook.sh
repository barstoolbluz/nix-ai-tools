goSetupHook() {
    export GOPATH="$HOME/go"
    export PATH="$PATH:$GOPATH/bin"
}

if [ -z "${dontUseGoSetupHook:-}" ]; then
    goSetupHook
fi