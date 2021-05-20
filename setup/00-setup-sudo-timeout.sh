set -euf -o pipefail;

echo "Setting sudo timeout to 10 minutes";
sudo sed -i.bak -E 's/(Defaults[[:space:]]+timestamp_timeout=).+/\110/' /etc/sudoers;

exit 0;
