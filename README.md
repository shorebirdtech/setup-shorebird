# Setup Shorebird

[![ci](https://github.com/shorebirdtech/setup-shorebird/actions/workflows/main.yaml/badge.svg)](https://github.com/shorebirdtech/setup-shorebird/actions/workflows/main.yaml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE)

Installs and sets up [Shorebird](https://github.com/shorebirdtech/shorebird) for use in GitHub Actions.

## Features

✅ Downloads the Shorebird CLI

✅ Adds `shorebird` to the system path

✅ Optionally installs Shorebird's Flutter and adds `flutter` and `dart` to the system path

✅ Optionally cache the Shorebird installation

## Inputs

- `cache`: Cache the Shorebird installation and artifacts. Default: false
- `shorebird-version`: **Not recommended.** Pins the Shorebird CLI release to
  install (the version `shorebird --version` prints, e.g. `1.6.125`; this is
  not a Flutter version). Defaults to the latest stable release.
  - Pinning is likely to break over time: Shorebird's servers require newer
    CLI versions as they evolve, so an old pinned version will eventually be
    rejected. It exists for those who need it.
  - To build with a specific Flutter version, pass `--flutter-version` to
    `shorebird release` instead. That is supported and doesn't require pinning
    the CLI.
- `flutter-version`: Also install Shorebird's Flutter, precache its build
  artifacts, and add its `bin` and the pub cache's `bin` to the path, so later
  steps can run `flutter` and `dart`. Takes a Flutter version (e.g. `3.38.5`),
  a commit, or `latest` for the Flutter this Shorebird CLI builds with, as
  `shorebird release --flutter-version` does (but not `system` or `fvm`).
  Default: none, so Flutter isn't put on the path. Needs Shorebird CLI 1.6.148
  or later. Use `shorebird flutter versions list` to see what's available.
  With `cache: true`, the cache covers Flutter too (on macOS that includes its
  iOS artifacts, a few GB).

## Usage

```yaml
steps:
  - uses: shorebirdtech/setup-shorebird@v1
    with:
      cache: true # Optionally cache the Shorebird installation
  - run: shorebird --version
```

To also use Shorebird's Flutter (instead of a separate Flutter setup action):

```yaml
steps:
  - uses: shorebirdtech/setup-shorebird@v1
    with:
      cache: true
      flutter-version: latest # The CLI's own Flutter, or e.g. 3.38.5
  - run: flutter pub get
  - run: flutter test
```
