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
- `flutter-version`: The Flutter version your build passes to
  `shorebird release --flutter-version` (e.g. `3.38.5`). The action installs
  and precaches it, and with `cache: true` keys the cache on its revision.
  Defaults to the Flutter the Shorebird CLI builds with.
- `shorebird-version`: **Not recommended.** Pins the Shorebird CLI release to
  install (the version `shorebird --version` prints, e.g. `1.6.125`; this is
  not a Flutter version). Defaults to the latest stable release.
  - Pinning is likely to break over time: Shorebird's servers require newer
    CLI versions as they evolve, so an old pinned version will eventually be
    rejected. It exists for those who need it.
  - To build with a specific Flutter version, pass `--flutter-version` to
    `shorebird release` instead. That is supported and doesn't require pinning
    the CLI.

## Usage

```yaml
steps:
  - uses: shorebirdtech/setup-shorebird@v1
    with:
      cache: true # Optionally cache the Shorebird installation
  - run: shorebird --version
```

### Caching

With `cache: true`, the cache is keyed on the Flutter revision the build uses:
the one `flutter-version` names, or the CLI's own when it's unset. A build with
another Flutter version is a cache miss and installs it; a later build with a
version cached before (a patch to an older release, say) restores that cache.
A cache hit upgrades the Shorebird CLI to the latest stable release.

If you build with one Flutter version, set it so the cache holds it:

```yaml
steps:
  - uses: shorebirdtech/setup-shorebird@v1
    with:
      cache: true
      flutter-version: 3.38.5
  - run: shorebird release android --flutter-version 3.38.5
```

Android builds also download Flutter's engine libraries into the Gradle cache
(`~/.gradle`), which this action doesn't keep. To keep them between runs, cache
Gradle too, for example with
[`gradle/actions/setup-gradle`](https://github.com/gradle/actions).
