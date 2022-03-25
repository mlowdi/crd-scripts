#!/bin/bash

if ! hash curl; then
    if ! hash jq; then
        echo "You need cURL and jq installed to run this script!"
    fi
    echo "You need cURL installed to run this script!"
elif ! hash jq; then
    echo "You need jq installed to run this script!"
fi

if [ -z "$1" ]; then
    echo "Usage: bundle-lookup.sh <bundleID>"
else
    curl -sS "https://itunes.apple.com/lookup/?bundleId="$1 | jq '.results[] | {type: .kind, app: .trackName, by: .artistName, categories: .genres, lastUpdate: .currentVersionReleaseDate, url: .trackViewUrl}'
fi
