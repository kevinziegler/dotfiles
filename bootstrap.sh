set -euf -o pipefail;

# Export config variables needed by setup scripts
export SSH_KEY_TYPE="ed25519";
export SSH_KEY="$HOME/.ssh/id_$SSH_KEY_TYPE";
export DOTFILES="$HOME/.dotfiles";

# Add /usr/local/bin to the path so that anything installed via homebrew is
# available to setup scripts
export PATH=$PATH:/usr/local/bin;

# Config values only needed for bootstrapping
DOTFILES_REPO="kevinziegler/dotfiles.git";
DOTFILES_REPO_HTTPS="https://github.com/$DOTFILES_REPO";
DOTFILES_REPO_SSH="git@github.com:$DOTFILES_REPO";

# Clone repository into ~/.dotfiles via HTTPS
git clone "$DOTFILES_REPO_HTTPS" "$DOTFILES";

# Update remote for dotfiles repo to use SSH
git -C $DOTFILES remote remove origin;
git -C $DOTFILES remote add origin "$DOTFILES_REPO_SSH";

# Run setup scripts
echo "Bootstrapping complete.  Running setups scripts in $DOTFILES/setup";
for script in $(ls "$DOTFILES/setup/*.sh"); do
    echo "[$script] Starting";
    bash $script;
    echo "[$script] Finished";
done

echo "Setup is finished!";
exit 0;
