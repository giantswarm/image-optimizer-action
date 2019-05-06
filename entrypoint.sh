#!/bin/bash

set -e

source /lib.sh

echo
echo "-- Environment variables ----------------------------------------------"
env
echo "-----------------------------------------------------------------------"

_requires_token

#echo
#echo "Details on commits"
#cat "$GITHUB_EVENT_PATH" | jq -r .commits
#echo

files=$(cat "$GITHUB_EVENT_PATH" | jq -r '[.commits[].added] | flatten | unique | .[]' | grep -i ".JPG$")
#echo
#echo $files
#echo

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
echo "git status:"
git status

echo "git remote url:"
git remote get-url

git config --global credential.helper store
echo https://${GITHUB_TOKEN}:x-oauth-basic@github.com > ${HOME}/.git-credentials

_local_commit

git push origin ${GITHUB_REF}
