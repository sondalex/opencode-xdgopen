# opencode with xdg-open support

**This is an independent project and is not affiliated with or endorsed by OpenCode**.

For convenience, add this command to your `~/.zshrc`

```bash
opencode() {
    podman run -it --rm \
        -v "$(pwd)":/workspace:Z \
        -v "${XDG_CONFIG_HOME:-$HOME/.config}/opencode":/root/.config/opencode:Z \
        -v "${XDG_DATA_HOME:-$HOME/.local/share}/opencode":/root/.local/share/opencode:Z \
        -v "${XDG_STATE_HOME:-$HOME/.local/state}/opencode":/root/.local/state/opencode:Z \
        -w /workspace \
        ghcr.io/sondalex/opencode-xdgopen "$@"
}
```


## Development

Build

```bash
podman build -t ghcr.io/sondalex/opencode-xdgopen:<tag> .
```

Publish

```bash
echo $GH_TOKEN| podman login  ghcr.io -u <user> --password-stdin
```

```bash
podman push ghcr.io/sondalex/opencode-xdgopen:<tag>
```
