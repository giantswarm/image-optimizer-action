#!/bin/sh

set -e

source /lib.sh

echo
echo "-- Environment variables ----------------------------------------------"
env
echo "-----------------------------------------------------------------------"

_requires_token()

for f in $(cat "$GITHUB_EVENT_PATH" | jq -r '[.commits[].added] | flatten | unique | .[]' | grep -i ".JPG$"); do
  echo "Optimizing file ${f}"
  guetzli --quality 90 ${f} ${f}.new && rm ${f} && mv ${f}.new ${f}
done

echo
echo "git status:"
git status


#git config --global credential.helper store
#echo https://${GITHUB_TOKEN}:x-oauth-basic@github.com >> ${HOME}/.git-credentials
#git commit -a -m "Optimizing image(s)"
