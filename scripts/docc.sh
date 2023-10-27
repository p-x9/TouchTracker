#!/bin/bash

SCHEME='TouchTracker'
REPO_NAME='TouchTracker'

build_clean() {
  destination="$1"

  xcodebuild clean \
    -destination "generic/platform=$destination" \
    -scheme "$SCHEME"
}

generate_docc() {
  destination="$1"

  mkdir -p docs

  xcodebuild docbuild \
    -scheme "$SCHEME" \
    -destination "generic/platform=$destination" \
    OTHER_DOCC_FLAGS="--transform-for-static-hosting --hosting-base-path {REPO_NAME} --output-path docs" \
    OTHER_SWIFT_FLAGS="-emit-extension-block-symbols"
  # OTHER_SWIFT_FLAGS -symbol-graph-minimum-access-level private
}

build_clean ios
generate_docc ios
