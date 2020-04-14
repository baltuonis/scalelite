#!/bin/bash

docker build \
  --target builder \
  --build-arg BUILDKIT_INLINE_CACHE=1 \
  --build-arg BUILD_NUMBER="sl-custom:1" \
  --cache-from "sl-custom-builder:1" \
  --tag "sl-custom-builder:1"

exit 1

docker build \
  --target api
  --build-arg BUILDKIT_INLINE_CACHE=1 \
  --build-arg BUILD_NUMBER="sl-custom:1" \
  --cache-from "sl-custom-builder:1" \
  --cache-from "sl-custom-api:1" \
  --tag "sl-custom-api:1"

docker build \
  --target poller
  --build-arg BUILDKIT_INLINE_CACHE=1
  --build-arg BUILD_NUMBER="sl-custom:1" \
  --cache-from "sl-custom-builder:1" \
  --cache-from "sl-custom-api:1" \
  --cache-from "sl-custom-poller:1" \
  --tag "sl-custom-poller:1"