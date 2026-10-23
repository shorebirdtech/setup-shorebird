# Releasing Setup Shorebird

Users reference this action as `@v1`, a tag we move to each new v1.x.y. Moving it ships the release to everyone, so tag the exact version first, verify it, and move `v1` last.

## Maintenance

This action is in maintenance mode. It's a thin wrapper around the [Shorebird CLI](https://github.com/shorebirdtech/shorebird), which any workflow can also run directly, so it isn't getting new features or a v2. It is kept working: CI stays green and [zizmor](https://github.com/zizmorcore/zizmor)-clean, real bugs get fixed, and fixes get released rather than left on `main`.

Prefer fixes that keep v1's behavior over behavior changes: existing workflows depend on it as it is.

## Steps

1. Confirm the `ci` workflow is green on the `main` commit you are releasing.
1. Create the release (patch bump for fixes, minor for new inputs; a breaking change needs a new major):
   ```sh
   gh release create v1.2.3 --target <main sha> --generate-notes
   ```
1. Verify downstream against the new version, before moving `v1`. shorebird-release and shorebird-patch use `shorebirdtech/setup-shorebird@v1` in their e2e jobs. In each, push a branch (in that repository, not a fork: e2e can't sign in from a fork) that changes `@v1` to `@v1.2.3` in `.github/workflows/main.yaml`, open a draft PR, and confirm e2e passes. Then close the PR and delete the branch.
1. Move the major tag to it. Force-move `v1`; never delete it, since every workflow using `@v1` fails while it's missing:
   ```sh
   git fetch --tags --force
   git tag -f v1 v1.2.3
   git push -f origin refs/tags/v1
   ```
1. Confirm `v1` itself: re-run the latest `ci` run on `main` in shorebird-release and shorebird-patch and check it passes.

To roll back, point `v1` at the previous release (`git tag -f v1 v1.2.2 && git push -f origin refs/tags/v1`).

`v1.1`, `v1.2`, and `v1.2.1` are stale tags from before v0.1.0 (March 2023), not releases. Versions continue from v1.3.0 so they sort above them; never roll back to them. The release before v1.3.0 is v1.0.2.
