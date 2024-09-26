#!/bin/bash

VENV=".sphinx/venv/bin/activate"

files=0
words=0
mean=0
readabilityWords=0
readabilitySentences=0
readabilitySyllables=0
readabilityAverage=0
# FIXME: get pre metrics working
#readabilityCode=0
readable=true

# measure number of files (.rst and .md), excluding those in .sphinx dir
files=$(find . -type d -path './.sphinx' -prune -o -type f \( -name '*.md' -o -name '*.rst' \) -print | wc -l)

# calculate metrics only if source files are present
if [ "$files" -eq 0 ]; then
    echo "There are no source files to calculate metrics"
else
    # measure raw total number of words, excluding those in .sphinx dir
    words=$(find . -type d -path './.sphinx' -prune -o \( -name '*.md' -o -name '*.rst' \) -exec cat {} + | wc -w)

    # calculate readability for markdown source files
    echo "Activating virtual environment to run vale..."
    source "${VENV}"

    # NOTE: other Vale metrics to consider: "heading_*", "list", "pre"
    for file in *.md *.rst; do
        if [ -f "$file" ]; then
                readabilityWords=$(vale ls-metrics $file | grep '"words"' | sed 's/[^0-9]*//g')
                readabilitySentences=$(vale ls-metrics $file | grep '"sentences"' | sed 's/[^0-9]*//g')
                readabilitySyllables=$(vale ls-metrics $file | grep '"syllables"' | sed 's/[^0-9]*//g')
                # FIXME: get pre metrics working
                # readabilityCode=$(vale ls-metrics $file | grep '"pre"' | sed 's/[^0-9]*//g')
        fi
    done

    echo "Deactivating virtual environment..."
    deactivate

    # calculate mean number of words
    if [ "$files" -ge 1 ]; then
        meanval=$(( readabilityWords / files))
    else meanval=$readabilityWords
    fi

    readabilityAverage=$(echo "scale=2; 0.39 * ($readabilityWords / $readabilitySentences) + (11.8 * ($readabilitySyllables / $readabilityWords)) - 15.59" | bc)

    # cast average to int for comparison
    readabilityAverageInt=$(echo "$readabilityAverage / 1" | bc)

    echo "$readabilityAverageInt"

    # value below 8 is considered readable
    if [ "$readabilityAverageInt" -lt 8 ]; then
        readable=true
    else 
        readable=false
    fi

    # summarise latest metrics
    echo "Summarising metrics for source files (.md, .rst)..."
    echo "total files: $files"
    echo "total words (raw): $words"
    echo "total words (prose): $readabilityWords"
    echo "average word count: $meanval"
    echo "readability: $readabilityAverage"
    echo "readable: $readable"
    # FIXME: get pre metrics working
    # echo "code blocks: $readabilityCode"
fi
