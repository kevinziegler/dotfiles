set -euf -o pipefail;

ONEPASSWORD_ADDRESS="my.1password.com";

echo "Setting up 1Password...";
open -a "$(brew info --cask --json=v2 "1password" | jq -r '.casks[0].artifacts[0][0]')";
echo "Waiting for you to sign into the 1Password Application...press <ENTER> to continue";
read;
read -p "\tPlease enter your OnePassword Email:" ONEPASSWORD_EMAIL;
eval "$(op signin "$ONEPASSWORD_ADDRESS" "$ONEPASSWORD_EMAIL")";
echo "Signed into 1Password via the command line!"

exit 0;
