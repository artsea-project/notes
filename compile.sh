#!/usr/bin/env bash

OUT='docs'
FILE_NAME='main.typ'

mapfile -t FILES < <(find . -name "$FILE_NAME")

if ! command -v typst >/dev/null 2>&1; then
    echo "Error: 'typst' command not found." >&2
    exit 1
fi

mkdir -p "$OUT"

for file in "${FILES[@]}"; do
    echo "Processing $file"
    DIR_NAME=$(dirname "$file")
    DIR_NAME=${DIR_NAME#./}
    DIR_NAME=${DIR_NAME//\//-}
    OUT_NAME="${OUT}/${DIR_NAME}.pdf"
    echo "Output name: $OUT_NAME"
    typst compile "$file" "$OUT_NAME"
done
