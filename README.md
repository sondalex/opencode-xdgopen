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

The default target is `alpine` (musl), built on the upstream opencode image.
The `debian` target is a real glibc image: it starts from `debian:bookworm-slim`
and installs the official glibc opencode release binary
(`opencode-linux-x64` / `opencode-linux-arm64`) from
https://github.com/anomalyco/opencode/releases.

```bash
podman build --target debian -t ghcr.io/sondalex/opencode-xdgopen:debian .
```

Build args: `BASE_IMAGE` (alpine target), `DEBIAN_IMAGE` and `OPENCODE_VERSION`
(debian target, default `latest`).

### Tags

Following Docker Hub convention (`<version>-<variant>`), tags are:

| Tag | Base | libc |
| --- | --- | --- |
| `latest`, `alpine`, `<version>`, `<version>-alpine` | alpine | musl |
| `debian`, `<version>-debian` | debian | glibc |

`latest` and the bare `<version>` point to the alpine variant.
Users select a variant by tag, e.g. `ghcr.io/sondalex/opencode-xdgopen:debian`.

Publish

```bash
echo $GH_TOKEN| podman login  ghcr.io -u <user> --password-stdin
```

```bash
podman push ghcr.io/sondalex/opencode-xdgopen:<tag>
```
