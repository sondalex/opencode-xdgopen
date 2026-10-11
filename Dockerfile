# Two variants, selected with --target:
#   alpine (default): built on the upstream musl image, which already ships opencode
#   debian: glibc image; the official glibc opencode binary is downloaded from upstream releases

ARG BASE_IMAGE=ghcr.io/anomalyco/opencode:latest
ARG DEBIAN_IMAGE=debian:bookworm-slim

FROM ${DEBIAN_IMAGE} AS debian
ARG TARGETARCH
ARG OPENCODE_VERSION=latest
RUN set -eu; \
  apt-get update; \
  apt-get install -y --no-install-recommends git bash curl wget ca-certificates openssh-client xdg-utils linux-perf ripgrep tar; \
  rm -rf /var/lib/apt/lists/*; \
  case "${TARGETARCH:-$(dpkg --print-architecture)}" in \
    amd64|x64) asset=opencode-linux-x64 ;; \
    arm64) asset=opencode-linux-arm64 ;; \
    *) echo "Unsupported architecture: ${TARGETARCH}" >&2; exit 1 ;; \
  esac; \
  if [ "$OPENCODE_VERSION" = latest ]; then \
    url="https://github.com/anomalyco/opencode/releases/latest/download/${asset}.tar.gz"; \
  else \
    url="https://github.com/anomalyco/opencode/releases/download/v${OPENCODE_VERSION#v}/${asset}.tar.gz"; \
  fi; \
  curl -fsSL "$url" | tar -xz -C /usr/local/bin opencode; \
  chmod +x /usr/local/bin/opencode; \
  opencode --version
ENTRYPOINT ["opencode"]

FROM ${BASE_IMAGE} AS alpine
RUN apk add --no-cache git bash curl wget ca-certificates openssh xdg-utils perf ripgrep
