#!/usr/bin/env bash

file=/tmp/PROTECTAgentInstaller.sh

wget https://eset.trifork.com/PROTECTAgentInstallerLinux.sh --output-document $file
chmod +x $file
sudo $file

rm $file