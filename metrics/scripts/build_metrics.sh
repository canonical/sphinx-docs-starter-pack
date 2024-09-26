#!/bin/bash

links=0
images=0

# count number of links
links=$(find . -type d -path './.sphinx' -prune -o -name '*.html' -exec cat {} + | grep "<a " | wc -l)
# count number of images
images=$(find . -type d -path './.sphinx' -prune -o -name '*.html' -exec cat {} + | grep "<img " | wc -l)

# summarise latest metrics
echo "Summarising metrics for build files (.html)..."
echo "links: $links"
echo "images: $images"
