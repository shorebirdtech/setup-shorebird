# Releasing Setup Shorebird

Users reference this action as `@v1`, a tag we move to each new v1.x.y. Moving it ships the release to everyone, so tag the exact version first and move `v1` last.

1. Confirm the `ci` workflow is green on the `main` commit you are releasing.
1. Create the release (patch bump for fixes, minor for new inputs; a breaking change needs a new major):
   ```sh
   gh release create v1.2.3 --target <main sha> --generate-notes
   ```
1. Move the major tag to it:
   ```sh
   git fetch --tags --force
   git tag -f v1 v1.2.3
   git push -f origin refs/tags/v1
   ```
1. Verify downstream. shorebird-release and shorebird-patch both use `shorebirdtech/setup-shorebird@v1` in their e2e jobs. After moving `v1`, re-run the latest `ci` run on `main` in each and confirm it passes.

To roll back, point `v1` at the previous release (`git tag -f v1 v1.2.2 && git push -f origin refs/tags/v1`).
