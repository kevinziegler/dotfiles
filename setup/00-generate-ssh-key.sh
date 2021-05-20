set -euf -o pipefail;

echo "[$(basename $0)] Generating an $SSH_KEY_TYPE SSH key at $SSH_KEY";
# TODO Backup an existing SSH key at this location
ssh-keygen -t "$SSH_KEY_TYPE" -f "$SSH_KEY" -N "";

exit 0;
