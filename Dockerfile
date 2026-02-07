FROM ghcr.io/anomalyco/opencode:latest

RUN apk add \
  git \
  bash \
  curl \
  wget \
  ca-certificates \
  openssh \
  xdg-utils 

