#!/usr/bin/env bash
# Resizes the five captured shots to 2100px wide with the thin top bar the
# README snapshots carry, writes them over shared/snapshots/cyber-dojo-N-*.png,
# and stacks them into shared/home_page_snapshot.png.
# Reads home.png, creator.png, edit.png, dashboard.png and review.png from
# <shots_dir>; any that is missing keeps its existing finished PNG.
# The crop geometries suit captures from shot_home.mjs and shots.mjs; recheck
# them by eye if the pages' layouts change.
set -o errexit -o nounset -o pipefail

if [ "${1:-}" = "-h" ]; then
  echo "Usage: merge.sh <shots_dir> <cyber-dojo_repo_dir>"
  echo "Example: merge.sh /private/tmp/shots ~/repos/cyber-dojo/cyber-dojo"
  exit 0
fi

readonly SRC="${1}"
readonly SHARED="${2}/shared"
readonly BAR_COLOUR='rgb(249,249,250)'

finish()
{
  # Crops src (optional geometry), scales it to 2100px wide, puts an 8px
  # near-white bar on top, writes dst.
  local -r src="${1}" dst="${2}" crop="${3:-}"
  # A missing capture keeps its existing finished PNG, so one page can be retaken alone.
  if [ ! -f "${src}" ]; then
    echo "keeping ${dst} (no ${src})"
    return 0
  fi
  magick "${src}" ${crop:+-crop "${crop}" +repage} -resize 2100x \
    -background "${BAR_COLOUR}" -gravity north -splice 0x8 \
    -strip "${dst}"
}

# The home page's content is centred in a wide animal background; crop the
# sides so the content fills the frame.
finish "${SRC}/home.png"      "${SHARED}/snapshots/cyber-dojo-1-home.png" 2000x1240+512+0
# The creator page's panel sits where the home page's content does.
finish "${SRC}/creator.png"   "${SHARED}/snapshots/cyber-dojo-2-creator.png" 2000x1240+512+0
# The edit and review pages leave an empty strip on the right; crop to their content.
finish "${SRC}/edit.png"      "${SHARED}/snapshots/cyber-dojo-3-edit.png" 2450x1590+0+0
# The dashboard's rows fill only the top of the viewport; keep the first part
# of the session (cut between two light columns) so the lights stay large.
finish "${SRC}/dashboard.png" "${SHARED}/snapshots/cyber-dojo-4-dashboard.png" 2000x850+0+0
finish "${SRC}/review.png"    "${SHARED}/snapshots/cyber-dojo-5-review.png" 2220x1590+0+0

magick \
  "${SHARED}/snapshots/cyber-dojo-1-home.png" \
  "${SHARED}/snapshots/cyber-dojo-2-creator.png" \
  "${SHARED}/snapshots/cyber-dojo-3-edit.png" \
  "${SHARED}/snapshots/cyber-dojo-4-dashboard.png" \
  "${SHARED}/snapshots/cyber-dojo-5-review.png" \
  -append -strip "${SHARED}/home_page_snapshot.png"
