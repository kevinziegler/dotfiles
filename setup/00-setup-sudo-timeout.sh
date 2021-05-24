set -euf -o pipefail;

sudo sed -i.bak -E 's/(Defaults[[:space:]]+timestamp_timeout=).+/\110/' /etc/sudoers;

exit 0;
