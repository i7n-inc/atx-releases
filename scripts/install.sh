#!/bin/sh
# ATX installer.
#
# Usage:
#   curl -fsSL https://github.com/i7n-inc/atx-releases/raw/main/scripts/install.sh | sh
#
# Environment overrides:
#   ATX_DEST     Installation directory (default: $HOME/.local/bin)
#   ATX_VERSION  Pin a specific version (default: resolves latest via version.json)

set -eu

RELEASES_REPO="i7n-inc/atx-releases"
RELEASES_URL="https://github.com/${RELEASES_REPO}/releases"
DEST="${ATX_DEST:-$HOME/.local/bin}"

log()  { printf '%s\n' "$*" >&2; }
die()  { log "error: $*"; exit 1; }

command -v curl >/dev/null 2>&1 || die "curl is required"

os=$(uname -s | tr '[:upper:]' '[:lower:]')
case "$os" in
  darwin|linux) ;;
  *) die "unsupported OS: $os (ATX ships darwin and linux only)";;
esac

arch=$(uname -m)
case "$arch" in
  x86_64|amd64)   arch=amd64 ;;
  aarch64|arm64)  arch=arm64 ;;
  *) die "unsupported architecture: $arch";;
esac

version="${ATX_VERSION:-}"
if [ -z "$version" ]; then
  log "Resolving latest version..."
  version=$(curl -fsSL "${RELEASES_URL}/latest/download/version.json" \
    | sed -n 's/.*"version": *"\([^"]*\)".*/\1/p')
  [ -n "$version" ] || die "could not parse version from manifest"
fi

asset="atx-${version}-${os}-${arch}"
url="${RELEASES_URL}/download/${version}/${asset}"
checksums_url="${RELEASES_URL}/download/${version}/checksums.txt"

mkdir -p "$DEST"
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT

log "Downloading ATX ${version} (${os}-${arch})..."
curl -fSL --progress-bar -o "$tmp/$asset" "$url" \
  || die "download failed: $url"

if curl -fsSL -o "$tmp/checksums.txt" "$checksums_url" 2>/dev/null; then
  if command -v sha256sum >/dev/null 2>&1; then
    hasher="sha256sum"
  elif command -v shasum >/dev/null 2>&1; then
    hasher="shasum -a 256"
  else
    hasher=""
  fi
  if [ -n "$hasher" ]; then
    log "Verifying checksum..."
    expected=$(grep " ${asset}\$" "$tmp/checksums.txt" | awk '{print $1}')
    [ -n "$expected" ] || die "no checksum entry for ${asset}"
    actual=$($hasher "$tmp/$asset" | awk '{print $1}')
    [ "$expected" = "$actual" ] || die "checksum mismatch (expected $expected, got $actual)"
  else
    log "warn: neither sha256sum nor shasum found; skipping checksum verification"
  fi
else
  log "warn: could not fetch checksums.txt; skipping verification"
fi

chmod +x "$tmp/$asset"
mv "$tmp/$asset" "$DEST/atx"

log "Installed ATX ${version} to ${DEST}/atx"

case ":$PATH:" in
  *":$DEST:"*) ;;
  *) log ""
     log "warn: ${DEST} is not on your PATH."
     log "      add it to your shell profile, e.g.:"
     log "        echo 'export PATH=\"${DEST}:\$PATH\"' >> ~/.profile"
     ;;
esac
