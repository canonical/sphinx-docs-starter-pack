#!/bin/bash
mf="$2/metrics.yaml"
links=0
images=0

if [ $# -eq 0 ]; then 
    # number of links
    links=$(find . -name '*.html' -exec cat {} + | grep "<a " | wc -l)
    # number of images
    images=$(find . -name '*.html' -exec cat {} + | grep "<img " | wc -l)
fi

# summarise latest metrics
echo "Summarising metrics data calculated..."
echo "links: $links"
echo "images: $images"

# update metrics file
echo "Updating $mf with calculated data..."
yq eval ".metrics .linkcount = $links" -i  $mf
yq eval ".metrics .imagecount = $images" -i  $mf
