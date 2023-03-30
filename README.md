# setup-shorebird

Allows use of Shorebird in GitHub Actions.

## Usage

```yaml
steps:
- uses: actions/checkout@v3
- uses: setup-shorebird/install@v1
- run: shorebird -v
```
