# Setup Shorebird

Installs and sets up [Shorebird](https://github.com/shorebirdtech/shorebird) for use in GitHub Actions.

## Features

✅ Downloads the Shorebird CLI

✅ Adds `shorebird` to the system path

## Usage

```yaml
steps:
  - uses: shorebirdtech/setup-shorebird@v0
  - run: shorebird --version
```
