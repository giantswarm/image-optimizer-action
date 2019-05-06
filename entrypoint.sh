#!/bin/bash

set -e

source /lib.sh

echo
echo "-- Environment variables ----------------------------------------------"
env
echo "-----------------------------------------------------------------------"

_requires_token

if [[ "${GITHUB_REF}" == "refs/heads/master" ]]; then
  echo
  echo "This action is meant to perform on pull requests (branches)."
  echo "It does not perform any optimizations on pushes to master,"
  echo "to avoid optimizing images twice."
  exit 0
fi

echo
echo "Details on event"
cat "$GITHUB_EVENT_PATH" | jq -M .
echo

files=$(cat "$GITHUB_EVENT_PATH" | jq -r '[.commits[].added] | flatten | unique | .[]' | grep -i ".JPG$" || true)
#echo
#echo $files
#echo

if [[ -z $files ]]; then
  echo
  echo "No JPEG files found to optimize."
  exit 0
fi

for f in $files; do
  if [[ -f ${f} ]]; then
    echo
    echo "Optimizing file ${f}"
    ls -la ${f}
    file ${f}
    /usr/bin/guetzli --quality 90 ${f} ${f}.new && rm ${f} && mv ${f}.new ${f}
    echo "After optimization:"
    ls -la ${f}
  fi
done


echo
git remote set-url origin https://${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git

_commit_and_push_if_needed
