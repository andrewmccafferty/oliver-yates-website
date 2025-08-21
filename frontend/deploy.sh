#!/bin/bash

set -euo pipefail

if [ -z "${FRONTEND_BUCKET:-}" ]; then
  echo "Error: FRONTEND_BUCKET environment variable is not set."
  exit 1
fi

INDEX_PATH="index.html"
SCRIPT_PATH="dist/index.js"
IMAGE_PATH="img/man.png"

# 5. Upload index.html
echo "📰 Uploading $INDEX_PATH to s3://$FRONTEND_BUCKET/index.html"

aws s3api put-object \
  --bucket "$FRONTEND_BUCKET" \
  --key "dist/index.js" \
  --body "$SCRIPT_PATH" \
  --content-type "application/javascript" \
  --content-md5 "$(openssl md5 -binary "$SCRIPT_PATH" | base64)"

aws s3api put-object \
  --bucket "$FRONTEND_BUCKET" \
  --key "about.html" \
  --body "about.html" \
  --content-type "text/html" \
  --content-md5 "$(openssl md5 -binary "about.html" | base64)"

aws s3api put-object \
  --bucket "$FRONTEND_BUCKET" \
  --key "index.html" \
  --body "$INDEX_PATH" \
  --content-type "text/html" \
  --content-md5 "$(openssl md5 -binary "$INDEX_PATH" | base64)"

aws s3api put-object \
  --bucket "$FRONTEND_BUCKET" \
  --key "img/man.png" \
  --body "$IMAGE_PATH" \
  --content-type "image/png" \
  --content-md5 "$(openssl md5 -binary "$IMAGE_PATH" | base64)"