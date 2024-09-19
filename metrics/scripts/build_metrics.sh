#!/bin/bash

METRICSFILE="$2/metrics.yaml"
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

# update metrics file
echo "Updating $METRICSFILE with calculated data..."

sed -i "/linkcount/s/[0-9]\+/${links}/g" $METRICSFILE
sed -i "/imagecount/s/[0-9]\+/${images}/g" $METRICSFILE
