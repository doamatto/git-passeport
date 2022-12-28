#!/bin/bash

if ! [[ "$SSH_ORIGINAL_COMMAND" == git-upload-pack\ * || "$SSH_ORIGINAL_COMMAND" == git-upload-archive\ * || "$SSH_ORIGINAL_COMMAND" == git-receive-pack\ * ]]; then
    echo "gitsh: SSH and other commands not pertaining to Git are prohibited." >&2
    exit 1
fi

ARGS="${SSH_ORIGINAL_COMMAND#git-* }"
echo "Authenticating as $USER..."
eval "USER=$USER REPO=$ARGS ./applet" # $ARGS is the REPO_PATH

if [ $? == 0 ];
    break;
elif [ $? == 2 ];
    echo "gitsh: You don't have permission to use this server."
    exit 2
else;
    echo "gitsh: Your SSH key does not have permission to access this repository," >&2
    echo "gitsh: or you are trying to access a repository that does not exist." >&2
    exit 1
fi;

eval "$SSH_ORIGINAL_COMMAND"
