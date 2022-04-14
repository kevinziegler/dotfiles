#!/usr/bin/env bash

set -euf -o pipefail;

ONEPASSWORD_ADDRESS="my.1password.com";

open -a "$(brew info --json=v2 "1password" | jq -r '.casks[0].artifacts[0][0]')";
echo "Waiting for you to sign into the 1Password Application...press <ENTER> to continue";
read;

read -p "\tPlease enter your OnePassword Email:" ONEPASSWORD_EMAIL;
op account add --address "$ONEPASSWORD_ADDRESS" --email "$ONEPASSWORD_EMAIL";
echo "Added 1Password Account to via command line";

exit 0;
