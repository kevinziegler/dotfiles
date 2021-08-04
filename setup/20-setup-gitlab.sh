#!/usr/bin/env bash

set -euf -o pipefail;
source "$OP_SESSION";

GITLAB_OP_ITEM="gitlab";
GITLAB_API_ADD_SSH_KEY="https://gitlab.com/api/v4/user/keys";
GITLAB_TOKEN=$(op get item "$GITLAB_OP_ITEM" --fields "Setup Token");

curl -X POST \
	--header "Authorization: Bearer $GITLAB_TOKEN" \
	--data-urlencode "key=$(ssh-keygen -y -f "$SSH_KEY")" \
	--data-urlencode "title=$(hostname)" \
	$GITLAB_API_ADD_SSH_KEY;

exit 0;
