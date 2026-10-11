#!/usr/bin/env bash
set -Eeu

readonly IMAGE=plantuml/plantuml:latest

show_help()
{
  cat <<EOF
Usage: $(basename "$0") [OPTIONS] <file.puml>

Renders a PlantUML file to a png alongside it (file.puml -> file.png),
using the ${IMAGE} docker image.

Options:
  -h    Show this help

Example:
  $(basename "$0") dev/domain_model.puml
EOF
}

if [ "${1:-}" == '-h' ]; then
  show_help
  exit 0
fi

if [ $# -ne 1 ] || [ ! -f "$1" ]; then
  show_help >&2
  exit 1
fi

readonly DIR="$(cd "$(dirname "$1")" && pwd)"
readonly FILE="$(basename "$1")"

docker run --rm \
  --volume "${DIR}:/data" \
  --user "$(id -u):$(id -g)" \
  "${IMAGE}" \
  -tpng "/data/${FILE}"
