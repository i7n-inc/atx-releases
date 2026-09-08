# ATX Releases

This repository is the **release-only host** for ATX binaries. It contains no application source, issues, or pull requests; issues live in [i7n-inc/atx](https://github.com/i7n-inc/atx).

## URL contract

| Purpose | URL |
|---|---|
| Latest binary | https://github.com/i7n-inc/atx-releases/releases/latest/download/atx-<os>-<arch> |
| Pinned binary | https://github.com/i7n-inc/atx-releases/releases/download/<TAG>/atx-<os>-<arch> |
| Latest manifest | https://github.com/i7n-inc/atx-releases/releases/latest/download/version.json |
| Latest checksums | https://github.com/i7n-inc/atx-releases/releases/latest/download/checksums.txt |

`<os>` ∈ {darwin, linux}. `<arch>` ∈ {amd64, arm64}.

## Releases

Every release cut in [i7n-inc/atx](https://github.com/i7n-inc/atx) mirrors artifacts here at the same tag. The `atx` self-updater reads `version.json` from this repository.

All release assets are public and downloadable without authentication.

See the parent repository's [CHANGELOG](https://github.com/i7n-inc/atx/blob/main/CHANGELOG.md) for release notes.
