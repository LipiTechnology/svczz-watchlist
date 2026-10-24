#!/bin/sh
# Builds the upload ZIP for one platform folder: scripts/zip.sh chatgpt
# Output: dist/svczz-<platform>-plugin.zip, with the platform folder's files and
# the shared skills/ at the ZIP root, as the portals expect.
set -eu

platform="${1:?usage: scripts/zip.sh <platform>}"
root="$(cd "$(dirname "$0")/.." && pwd)"
src="$root/$platform"
out="$root/dist/svczz-$platform-plugin.zip"

[ -d "$src" ] || { echo "No folder $platform/" >&2; exit 1; }
[ -f "$src/plugin.json" ] && python3 -m json.tool "$src/plugin.json" >/dev/null

stage="$(mktemp -d)"
trap 'rm -rf "$stage"' EXIT
cp -R "$src/." "$stage/"
cp -R "$root/skills" "$stage/skills"

mkdir -p "$root/dist"
rm -f "$out"
(cd "$stage" && zip -qrX "$out" . -x '.*' -x '*/.*')
echo "$out"
