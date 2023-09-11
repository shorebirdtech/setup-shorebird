# Releasing Setup Shorebird

These are the steps needed to create a new release:

1. Create a new release in GitHub
   - Click on `Releases -> Draft a new release`
1. Make sure to name the release `v<VERSION>` (e.g. v1.2.3)
1. Update the current major version tag to point to the latest release. For example, if we just released v0.1.2, we'll need to make sure the `v0` tag points to the same commit as `v0.1.2`
   ```sh
   # checkout the release
   git checkout v0.1.2
   # force update the latest release tag
   git tag -f v0
   # push the tag
   git push origin :refs/tags/v0
   ```
