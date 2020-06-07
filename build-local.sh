#!/bin/bash

VER="5"

docker build \
  --target builder \
  --build-arg BUILDKIT_INLINE_CACHE=1 \
  --build-arg BUILD_NUMBER="sl-custom:$VER" \
  --cache-from "sl-custom-builder:$VER" \
  --tag "sl-custom-builder:$VER" \
  .

docker build \
  --target api \
  --build-arg BUILDKIT_INLINE_CACHE=1 \
  --build-arg BUILD_NUMBER="sl-custom:$VER" \
  --cache-from "sl-custom-builder:$VER" \
  --cache-from "sl-custom-api:$VER" \
  --tag "sl-custom-api:$VER" \
  .

docker build \
  --target poller \
  --build-arg BUILDKIT_INLINE_CACHE=1 \
  --build-arg BUILD_NUMBER="sl-custom:$VER" \
  --cache-from "sl-custom-builder:$VER" \
  --cache-from "sl-custom-api:$VER" \
  --cache-from "sl-custom-poller:$VER" \
  --tag "sl-custom-poller:$VER" \
  .