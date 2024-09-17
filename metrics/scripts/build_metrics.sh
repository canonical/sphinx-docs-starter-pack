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
yq eval ".metrics .linkcount = $links" -i  $METRICSFILE
yq eval ".metrics .imagecount = $images" -i  $METRICSFILE
