#!/bin/bash

# Fetch the current branch name
CURRENT_BRANCH=$(git branch --show-current)

# Ensure we are in a git repository
if [ -z "$CURRENT_BRANCH" ]; then
	  echo "Error: Not in a git repository or detached HEAD state."
	    exit 1
fi

echo "Current branch detected: $CURRENT_BRANCH"

# Fetch the latest changes from the remote repository
echo "Fetching the latest changes from the remote repository..."
git fetch origin

# Reset the current branch to match the remote branch
echo "Resetting branch '$CURRENT_BRANCH' to match 'origin/$CURRENT_BRANCH'..."
git reset --hard origin/"$CURRENT_BRANCH"

echo "Forced pull complete. Branch '$CURRENT_BRANCH' is now up-to-date with 'origin/$CURRENT_BRANCH'."

find ~/remoteblocks/remote/modules/ -type f -name "commit-id" -exec rm -f {} +
echo "removed redundant remote blocks env files"
