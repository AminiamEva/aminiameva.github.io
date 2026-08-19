#!/usr/bin/env bash

set -e

FILE="$1"

if [ ! -f "$FILE" ]; then
    echo "File not found: $FILE"
    exit 1
fi

DATE=$(TZ=Asia/Shanghai date '+%Y-%m-%d %H:%M:%S%z')

sed -i -E \
    "s/^date:.*/date: $DATE/" \
    "$FILE"

echo "Updated date: $DATE"

code -r "$FILE"