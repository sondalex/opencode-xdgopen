# BASE_IMAGE: any image based on ghcr.io/anomalyco/opencode (e.g. latest for alpine/musl, or a glibc variant)
ARG BASE_IMAGE=ghcr.io/anomalyco/opencode:latest
FROM ${BASE_IMAGE}

# PKG_MANAGER: apk (alpine/musl) or apt (debian/ubuntu, glibc)
ARG PKG_MANAGER=apk

RUN set -eu; \
  case "$PKG_MANAGER" in \
    apk) \
      apk add --no-cache git bash curl wget ca-certificates openssh xdg-utils perf ripgrep ;; \
    apt) \
      apt-get update && \
      apt-get install -y --no-install-recommends git bash curl wget ca-certificates openssh-client xdg-utils linux-perf ripgrep && \
      rm -rf /var/lib/apt/lists/* ;; \
    *) echo "Unsupported PKG_MANAGER: $PKG_MANAGER (use apk or apt)" >&2; exit 1 ;; \
  esac
