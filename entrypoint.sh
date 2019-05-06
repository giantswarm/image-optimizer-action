#!/bin/bash

set -e

source /lib.sh

echo
echo "-- Environment variables ----------------------------------------------"
env
echo "-----------------------------------------------------------------------"

_requires_token

echo
echo "Details on commits"
cat "$GITHUB_EVENT_PATH" | jq -r .commits
echo

echo
files=$(cat "$GITHUB_EVENT_PATH" | jq -r '[.commits[].added] | flatten | unique | .[]' | grep -i ".JPG$")
echo $files
echo

for f in $files; do
  if [[ -f ${f} ]]; then
    echo "Optimizing file ${f}"
    guetzli --quality 90 ${f} ${f}.new && rm ${f} && mv ${f}.new ${f}
  fi
done

echo
echo "git status:"
git status

_commit_if_needed

#git config --global credential.helper store
#echo https://${GITHUB_TOKEN}:x-oauth-basic@github.com >> ${HOME}/.git-credentials
#git commit -a -m "Optimizing image(s)"
