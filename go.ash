#!/bin/ash

# from https://github.com/GoogleCloudPlatform/cloud-builders/blob/master/go/go.ash

. /builder/prepare_workspace.inc
prepare_workspace || exit
if [[ "$1" == install ]]; then
  # Give a hint about where binaries end up if we think they're using 'go install'.
  gp=$(go env GOPATH)
  binpath=${gp#$PWD/}/bin
  echo "Binaries built using 'go install' will go to \"$binpath\"."
fi

exec "$@"
