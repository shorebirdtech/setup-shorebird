# Setup Shorebird

[![ci](https://github.com/shorebirdtech/setup-shorebird/actions/workflows/main.yaml/badge.svg)](https://github.com/shorebirdtech/setup-shorebird/actions/workflows/main.yaml)
[![License: MIT](https://img.shields.io/badge/license-MIT-blue.svg)](./LICENSE)

Installs and sets up [Shorebird](https://github.com/shorebirdtech/shorebird) for use in GitHub Actions.

## Features

✅ Downloads the Shorebird CLI

✅ Adds `shorebird` to the system path

✅ Configures the specified version of Flutter

## Usage

```yaml
steps:
  - uses: shorebirdtech/setup-shorebird@v0    
  - run: shorebird --version
```

## Inputs

The action takes the following inputs:

- `flutter-version`: Which version of Flutter to install alongside Shorebird (e.g. 3.10.6)
