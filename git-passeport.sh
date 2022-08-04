#!/bin/bash

if ! [[ "$SSH_ORIGINAL_COMMAND" == git-upload-pack\ * || "$SSH_ORIGINAL_COMMAND" == git-upload-archive\ * || "$SSH_ORIGINAL_COMMAND" == git-receive-pack\ * ]]; then
    echo "gitsh: SSH and other commands not pertaining to Git are prohibited." >&2
    exit 1
fi

ARGS="${SSH_ORIGINAL_COMMAND#git-* }"
REPO_PATH="$(eval "echo $ARGS")" # TODO: replace unsafe eval
ALLOWED_REPOS="$@"

IS_ALLOWED=false
for repo in $ALLOWED_REPOS; do
    if [[ "$REPO_PATH" == "$repo" ]]; then
        IS_ALLOWED=true
    fi
done

if [[ $IS_ALLOWED == "false" ]]; then
    echo "gitsh: Your SSH key does not have permission to access this repository, or you are trying to access a repository that does not exist." >&2
    exit 1
fi

eval "$SSH_ORIGINAL_COMMAND"
