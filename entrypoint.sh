#!/usr/bin/env bash
for md in $(find . -name "*.md"); do /render-md-mermaid.sh "$md" in-container; done
for md in $(find . -name "*.md"); do /demo-md-mermaid.sh "$md" in-container; done
