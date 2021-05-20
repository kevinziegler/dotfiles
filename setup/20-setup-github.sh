set -euf -o pipefail;

echo "Setting up hub client for Github...";

GH_OP_ITEM="github";
GH_HUB_CONFIG="$HOME/.config/hub";
TOKEN=$(op get item "$GH_OP_ITEM" --fields "Hub Access Token");
USER=$(op get item "$GH_OP_ITEM" --fields "username");

yq write "$GH_HUB_CONFIG" "[github.com][0].username" "$GITHUB_USER";
yq write "$GH_HUB_CONFIG" "[github.com][0].oauth_token" "$GITHUB_TOKEN";
yq write "$GH_HUB_CONFIG" "[github.com][0].protocol" "https";

echo "Adding Github SSH key...";
GH_SSHKEY="$(ssh-keygen -y -f "$SSH_KEY")";
hub api user/keys --field title="$GH_SSHKEY_NAME" --field key="$GH_SSHKEY";

exit 0;
