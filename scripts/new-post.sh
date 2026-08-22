#!/usr/bin/env bash

set -e

PROJECT_DIR="$(git rev-parse --show-toplevel)"

while true; do
    read -p "Post name: " A

    if [ -z "$A" ]; then
        echo "Error: post name cannot be empty."
        continue
    fi

    POST_DIR="$PROJECT_DIR/content/post/$A"
    INDEX_FILE="$POST_DIR/index.md"

    if [ -e "$POST_DIR" ]; then
        echo "Error: post '$A' already exists."
        echo "Please choose another name."
        continue
    fi

    break
done

mkdir -p "$POST_DIR"


DATE=$(TZ=Asia/Shanghai date '+%Y-%m-%d %H:%M:%S%z')

cat > "$INDEX_FILE" <<EOF
---
title: ""
description: ""
slug: $A
date: $DATE
image:
categories:
tags:
---
EOF

echo "Created: $INDEX_FILE"

code "$INDEX_FILE"