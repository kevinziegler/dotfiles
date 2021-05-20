#!/bin/bash

if [ -z $SSH_KEY ]; then
    echo "SSH_KEY not specified!  Aborting!";
    exit 1;
fi

GITLAB_OP_ITEM="gitlab";
GITLAB_API_ADD_SSH_KEY="https://gitlab.com/api/v4/user/keys";
GITLAB_TOKEN=$(op get item "$GITLAB_OP_ITEM" --fields "Setup Token");

curl -X POST \
	--header "Authorization: Bearer $GITLAB_TOKEN" \
	--data-urlencode "key=$(ssh-keygen -y -f "$SSH_KEY")" \
	--data-urlencode "title=$(hostname)" \
	$GITLAB_API_ADD_SSH_KEY;
