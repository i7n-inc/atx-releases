# ATX Releases

Public download host for ATX binaries.

Documentation: [docs.iteration.sh](https://docs.iteration.sh) · Changelog: [docs.iteration.sh/changelog](https://docs.iteration.sh/changelog)

Also note the versioned filenames — the `latest/download/atx-<os>-<arch>` shape is NOT used; use the manifest to discover the current version, then the pinned URL.

## URL contract

| Purpose | URL |
|---|---|
| Install script | `https://github.com/i7n-inc/atx-releases/raw/main/scripts/install.sh` |
| Latest manifest | `https://github.com/i7n-inc/atx-releases/releases/latest/download/version.json` |
| Pinned binary | `https://github.com/i7n-inc/atx-releases/releases/download/<VERSION>/atx-<VERSION>-<os>-<arch>` |
| Pinned checksums | `https://github.com/i7n-inc/atx-releases/releases/download/<VERSION>/checksums.txt` |
| Pinned manifest | `https://github.com/i7n-inc/atx-releases/releases/download/<VERSION>/version.json` |

`<os>` ∈ `{darwin, linux}`. `<arch>` ∈ `{amd64, arm64}`.

All release assets are public and downloadable without authentication.
