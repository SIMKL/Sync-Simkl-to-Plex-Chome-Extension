#!/usr/bin/env bash

if [ -z "$SIMKL_CLIENT_ID" ]; then
  echo "ensure env vars SIMKL_CLIENT_ID and SIMKL_CLIENT_SECRET are set"
  exit 1
fi
./scripts/build.sh
$PUPPETEER_EXECUTABLE_PATH \
  --load-extension=./dist \
  --user-data-dir="$(mktemp -d -t chromium-with-ext-XXXXXXXX)"

# TODO integration tests
# a real test account
