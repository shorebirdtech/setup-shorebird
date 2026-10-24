# Releasing Setup Shorebird

Users reference this action as `@v1`, a tag we move to each new v1.x.y. Moving it ships the release to everyone, so push the exact version's tag first, verify it, publish its release, and move `v1` last.

## Maintenance

This action is in maintenance mode. It's a thin wrapper around the [Shorebird CLI](https://github.com/shorebirdtech/shorebird), which any workflow can also run directly, so it isn't getting new features or a v2. It is kept working: CI stays green and [zizmor](https://github.com/zizmorcore/zizmor)-clean, real bugs get fixed, and fixes get released rather than left on `main`.

A fix must not change behavior that existing `@v1` workflows rely on.

## Steps

`vX.Y.Z` below is the new version: the last release with its patch number bumped. Releases are patch bumps, since only fixes are released.

1. Confirm the `ci` workflow is green on the `main` commit you are releasing.
1. Push only the tag, not a release yet, so nothing marks it Latest or lists it on the Marketplace before it's verified:
   ```sh
   git fetch origin
   git tag vX.Y.Z <main sha>
   git push origin refs/tags/vX.Y.Z
   ```
1. Verify downstream against the new tag, before moving `v1`. shorebird-release and shorebird-patch use `shorebirdtech/setup-shorebird@v1` in their e2e jobs. In each, push a branch (in that repository, not a fork: e2e can't sign in from a fork) that changes `shorebirdtech/setup-shorebird@v1` to `shorebirdtech/setup-shorebird@vX.Y.Z` in `.github/workflows/main.yaml`, and only that line (shorebird-patch's workflow also uses `shorebirdtech/shorebird-release@v1`; leave it). Open a draft PR and confirm e2e passes. Then close the PR and delete the branch.

   If e2e fails, stop: don't move `v1`. Delete the tag (`git push origin --delete refs/tags/vX.Y.Z`), fix the problem on `main`, and release the fix as the next patch version.
1. Publish the release from the tag:
   ```sh
   gh release create vX.Y.Z --verify-tag --generate-notes
   ```
1. Move the major tag to it. Force-move `v1`; never delete it, since every workflow using `@v1` fails while it's missing:
   ```sh
   git fetch --tags --force
   git tag -f v1 vX.Y.Z
   git push -f origin refs/tags/v1
   ```
1. Confirm `v1` itself: re-run the latest `ci` run on `main` in shorebird-release and shorebird-patch and check it passes:
   ```sh
   for repo in shorebirdtech/shorebird-release shorebirdtech/shorebird-patch; do
     id=$(gh run list -R "$repo" --workflow main.yaml --branch main --limit 1 --json databaseId -q '.[0].databaseId')
     gh run rerun "$id" -R "$repo"
     gh run watch "$id" -R "$repo" --exit-status
   done
   ```

## A bad release

If a release turns out to be bad after `v1` moved, point `v1` back at the previous release and mark that release Latest again:

```sh
git tag -f v1 <previous vX.Y.Z>
git push -f origin refs/tags/v1
gh release edit <previous vX.Y.Z> --latest
```

Then release the fix as the next patch version. Leave the bad tag in place, since deleting it breaks any workflow pinned to it, and say in its release notes that it's superseded (`gh release edit vX.Y.Z --notes-file <file>`).

## Stale tags

`v1.1`, `v1.2`, and `v1.2.1` are stale tags from before v0.1.0 (March 2023), not releases. Versions continue from v1.3.0 so they sort above them; never roll back to them. The release before v1.3.0 is v1.0.2.
