# Setup Shorebird

[![ci](https://github.com/shorebirdtech/setup-shorebird/actions/workflows/main.yaml/badge.svg)](https://github.com/shorebirdtech/setup-shorebird/actions/workflows/main.yaml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE)

Installs and sets up [Shorebird](https://github.com/shorebirdtech/shorebird) for use in GitHub Actions.

## Features

✅ Downloads the Shorebird CLI

✅ Adds `shorebird` to the system path

✅ Configures the specified version of Flutter

✅ Optionally cache the Shorebird installation

## Inputs

- `cache`: Cache the Shorebird installation and artifacts. Default: false
- `version`: The Shorebird CLI version to install (e.g. `1.6.125`). Defaults to
  the latest stable release.
  - Pinning is discouraged and is likely to break over time: Shorebird's
    servers require newer CLI versions as they evolve, so an old pinned version
    will eventually be rejected. It exists for those who need it.
  - To pin the Flutter version your app builds with, pass `--flutter-version`
    to `shorebird release` instead. That is supported and doesn't require
    pinning the CLI.

## Usage

```yaml
steps:
  - uses: shorebirdtech/setup-shorebird@v1
    with:
      cache: true # Optionally cache the Shorebird installation
  - run: shorebird --version
```
