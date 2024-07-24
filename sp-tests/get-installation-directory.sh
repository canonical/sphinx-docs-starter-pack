#!/bin/bash
set -e

# Determine installation directory
while getopts d: flag
do
    case "${flag}" in
        d) install_directory=${OPTARG};;
    esac
done

if [ ! -n "$install_directory" ]; then
    install_directory="."
fi
