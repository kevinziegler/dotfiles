#!/usr/bin/env bash

set -euf -o pipefail;
source "$OP_SESSION";

export GH_OP_ITEM="github";
export GH_HUB_CONFIG="$HOME/.config/hub";
export GH_SSHKEY_NAME="dotfiles-bootstrap-hostname";
export GH_SSHKEY="$(ssh-keygen -y -f "$SSH_KEY")";
export GITHUB_TOKEN=$(op get item "$GH_OP_ITEM" --fields "Hub Access Token");
export GITHUB_USER=$(op get item "$GH_OP_ITEM" --fields "username");

echo "Setting up hub client for Github...";

touch $GH_HUB_CONFIG;
yq eval -i '."github.com"[0].username = strenv(GITHUB_USER)' $GH_HUB_CONFIG;
yq eval -i '."github.com"[0].oauth_token = strenv(GITHUB_TOKEN)' $GH_HUB_CONFIG;
yq eval -i '."github.com"[0].protocol = "https"' $GH_HUB_CONFIG;

echo "Adding Github SSH key...";
hub api user/keys --field title="$GH_SSHKEY_NAME" --field key="$GH_SSHKEY";

exit 0;
