#!/usr/bin/env bash

export GO15VENDOREXPERIMENT=1

# Create a temp dir and clean it up on exit
TEMPDIR=`mktemp -d -t nomad-test.XXX`
trap "rm -rf $TEMPDIR" EXIT HUP INT QUIT TERM

# Build the Nomad binary for the API tests
echo "--> Building nomad"
go build -o $TEMPDIR/nomad || exit 1

# Run the tests
echo "--> Running tests"
go list ./... | sudo -E PATH=$TEMPDIR:$PATH xargs -n1 go test -cover -timeout=180s
