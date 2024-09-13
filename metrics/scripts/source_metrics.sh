#!/bin/bash

metricfile=$PWD/metrics/metrics.yaml
files=0
words=0
mean=0
readabilityWords=0
readabilitySentences=0
readabilitySyllables=0
readabilityAverage=0
readable=true

if [ $# -eq 0 ]; then 
    # number of files
    files=$(find . \( -name '*.md' -o -name '*.rst' \) | wc -l)
    # number of words
    words=$(find . \( -name '*.md' -o -name '*.rst' \) -exec cat {} + | wc -w)
    # calculate mean 
    meanval=$(( words / files))
    # calculate readability
    
    for file in *.md # TODO: need to handle .rst also
    do
	readabilityWords=`vale ls-metrics $file  | jq ".words"`
	readabilitySentences=`vale ls-metrics $file  | jq ".sentences"`
	readabilitySyllables=`vale ls-metrics $file  | jq ".syllables"`
    done

    readabilityAverage=$(echo "scale=2; 0.39 * ($readabilityWords / $readabilitySentences) + (11.8 * ($readabilitySyllables / $readabilityWords)) - 15.59" | bc)

    # cast average to int for comparison
    readabilityAverageInt=$(echo "$readabilityAverage / 1" | bc)

    # value below 8 is considered readable
    if [ "$readabilityAverageInt" -lt 8 ]; then
	readable=true
    else 
	readable=false
    fi

fi

# summarise latest metrics
echo "Summarising metrics data calculated..."
echo "files: $files"
echo "total: $words"
echo "average: $meanval"
echo "readability: $readabilityAverage"
echo "readable: $readable"

# update metrics file
echo "Updating metrics.yaml with calculated data..."
yq eval ".metrics .filecount = $files" -i  $metricfile
#yq eval ".metrics .wordcounttotal = $words" -i  $metricfile
#yq eval ".metrics .wordcountaverage = $meanval" -i  $metricfile
yq eval ".metrics .readability = $readability" -i  $metricfile
yq eval ".tests .readable = $readable" -i  $metricfile