#!/bin/bash

# Credits to https://github.com/bltavares/actions/ !

_requires_token() {
	if [[ -z $GITHUB_TOKEN ]]; then
		echo "Set the GITHUB_TOKEN env variable."
		exit 1
	fi
}

_git_is_dirty() {
	[[ -n "$(git status -s)" ]]
}

_local_commit() {
	git config --global user.name "github-actions[bot]"
	git config --global user.email "github-actions[bot]@users.noreply.github.com"
	git add .
	git commit -m "${GITHUB_ACTION}: optimize images"
}

_commit_and_push_if_needed() {
	if _git_is_dirty; then
		_local_commit
    git push origin ${GITHUB_REF}
	fi
}
