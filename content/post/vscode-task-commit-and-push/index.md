---
title: VS Code Task: Commit and Push
description: 
slug: update-fork
date: 2026-08-18 20:31:10+0800
categories:
    - Document
tags:
    - VsCode
    - JSON
---

## Commands

Add in `{PROJECT_SOURCE_DIR}/.vscode/tasks.json`:

```json
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Commit & Push",
            "type": "shell",
            "command": "git add . && git commit -m \"$(date '+%Y-%m-%d %H:%M:%S')\" && git push",
            "problemMatcher": []
        }
    ]
}
```
