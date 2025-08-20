#!/bin/bash

set -euo pipefail

if [ -z "${FRONTEND_BUCKET:-}" ]; then
  echo "Error: FRONTEND_BUCKET environment variable is not set."
  exit 1
fi

INDEX_PATH="index.html"
SCRIPT_PATH="dist/index.js"

# 5. Upload index.html
echo "📰 Uploading $INDEX_PATH to s3://$FRONTEND_BUCKET/index.html"

aws s3 cp "$INDEX_PATH" "s3://$FRONTEND_BUCKET/index.html" \
  --content-type "text/html"

  aws s3 cp "$SCRIPT_PATH" "s3://$FRONTEND_BUCKET/dist/index.js" \
  --content-type "text/javascript"

echo "Upload complete."
