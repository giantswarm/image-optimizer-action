#!/bin/sh

set -e

echo
echo "-- Environment variables ----------------------------------------------"
env
echo "-----------------------------------------------------------------------"

echo
echo "-- Event JSON ---------------------------------------------------------"
cat "$GITHUB_EVENT_PATH" | jq -M .
echo "-----------------------------------------------------------------------"
echo

echo "\nCurrent directory:"
pwd

echo "\nDirectory content:"
find .
