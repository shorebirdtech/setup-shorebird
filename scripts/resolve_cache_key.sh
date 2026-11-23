#!/usr/bin/env bash
# Writes the cache key's parts to $GITHUB_OUTPUT:
#   cli       the Shorebird CLI release: the stable branch's commit, or the
#             pinned version's tag
#   revision  the Flutter revision the build uses: FLUTTER_VERSION's, or the
#             CLI's own Flutter when it is unset or `latest`
#
# A version resolves to the current commit of its flutter_release/<version>
# branch, as `shorebird release --flutter-version` resolves it. Those branches
# take fixes after they're cut, so the key is the commit, never the version:
# a moved branch is a cache miss that installs its new commit.
#
# Env: FLUTTER_VERSION, SHOREBIRD_VERSION (either may be empty), GITHUB_OUTPUT.
set -euo pipefail

if [ -n "$SHOREBIRD_VERSION" ]; then
  ref="v${SHOREBIRD_VERSION#v}"
else
  ref=$(git ls-remote https://github.com/shorebirdtech/shorebird.git refs/heads/stable | cut -f1)
  if [ -z "$ref" ]; then
    echo "Could not resolve the Shorebird stable branch." >&2
    exit 1
  fi
fi
echo "cli=$ref" >> "$GITHUB_OUTPUT"
if [ -z "$FLUTTER_VERSION" ] || [ "$FLUTTER_VERSION" = latest ]; then
  # The Flutter the CLI builds with by default, as pinned in the CLI
  # this action installs.
  revision=$(curl --proto '=https' --tlsv1.2 -sSf "https://raw.githubusercontent.com/shorebirdtech/shorebird/${ref}/bin/internal/flutter.version" | tr -d '[:space:]') || revision=""
elif printf %s "$FLUTTER_VERSION" | grep -Eq '^[0-9a-fA-F]{4,40}$'; then
  # A commit hash, as `shorebird release --flutter-version` takes it.
  revision=$(printf %s "$FLUTTER_VERSION" | tr 'A-F' 'a-f')
else
  # What `shorebird release --flutter-version` resolves a version to.
  revision=$(git ls-remote https://github.com/shorebirdtech/flutter.git "refs/heads/flutter_release/${FLUTTER_VERSION}" | cut -f1)
fi
if [ -z "$revision" ]; then
  echo "Could not resolve the Flutter revision for '${FLUTTER_VERSION:-the Shorebird CLI}'. Run: shorebird flutter versions list" >&2
  exit 1
fi
echo "revision=$revision" >> "$GITHUB_OUTPUT"
