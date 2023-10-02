#!/usr/bin/env bash

sudo apt install --yes flatpak
sudo apt install --yes gnome-software-plugin-flatpak
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo