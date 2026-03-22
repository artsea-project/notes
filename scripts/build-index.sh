#!/usr/bin/env bash

OUT='docs/index.md'

mkdir -p docs

{
  echo "# Docs index"
  echo
  find docs -type f ! -name "index.md" | sort | sed 's|^docs/||' | while read -r f; do
    echo "- [$f](./$f)"
  done
} > "$OUT"
