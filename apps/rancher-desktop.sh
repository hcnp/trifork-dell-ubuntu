#!/usr/bin/env bash

curl -s https://download.opensuse.org/repositories/isv:/Rancher:/stable/deb/Release.key | gpg --dearmor | sudo dd status=none of=/usr/share/keyrings/isv-rancher-stable-archive-keyring.gpg
echo 'deb [signed-by=/usr/share/keyrings/isv-rancher-stable-archive-keyring.gpg] https://download.opensuse.org/repositories/isv:/Rancher:/stable/deb/ ./' | sudo dd status=none of=/etc/apt/sources.list.d/isv-rancher-stable.list

#gpg --generate-key
sudo apt update
sudo apt install --yes pass rancher-desktop

pass init "$(gpg -k | grep "pub " -A 1 | grep -v pub | sed 's/^ *//g')"