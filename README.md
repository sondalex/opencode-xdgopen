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

The base image and package manager are configurable with build args.
Default is the musl (alpine) based image. For a glibc (Debian/Ubuntu) based image:

```bash
podman build \
  --build-arg BASE_IMAGE=<glibc-based-opencode-image> \
  --build-arg PKG_MANAGER=apt \
  -t ghcr.io/sondalex/opencode-xdgopen:<tag> .
```

`PKG_MANAGER` supports `apk` (default) and `apt`. Use a tag naming scheme such as
`<version>-alpine` / `<version>-debian` to distinguish variants.

Publish

```bash
echo $GH_TOKEN| podman login  ghcr.io -u <user> --password-stdin
```

```bash
podman push ghcr.io/sondalex/opencode-xdgopen:<tag>
```
