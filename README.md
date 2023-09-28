# Ubuntu on Trifork Dell Machines
How to install Ubuntu Linux on a Trifork Dell Computer.

You should probably clone this repo in order to easier run scripts etc.:
```
sudo apt install --yes git
git clone git@github.com:hcnp/trifork-dell-ubuntu.git
cd trifork-dell-ubuntu
```

> ⚠️ **DISCLAIMER**:
> 
> I will only document the cli (command-line interface) way of installing and configuring, as this is easier to document and repeat, and leave it up to the reader to use the GUI (Graphical User Interface) to do the same.

# Download Dell Recovery Image for USB Drive
- Download the image for your system (ISO): [Dell OS Recovery image](https://www.dell.com/support/home/en-us/drivers/osiso/recoverytool)
- And create a bootable USB media as described on [How to Download and Use the Dell Operating System Recovery Image in Ubuntu or Linux](https://www.dell.com/support/kbdoc/en-us/000132294/how-to-use-the-dell-hosted-recovery-image-of-linux) under "Creating a USB recovery media"
  - Follow the "Install Ubuntu or linux"
  - When booted choose "Customize installation"
  - Choose "Erase disk and install Ubuntu"
  - Under advanced features enable disk encryption (Use LVM -> Encrypt the new...)
  - Create a recoverey key (and file)
    - To save it on the current usb disk, open a terminal with ctrl+alt+t, open Disks with `gnome-disks &`, create a FAT partition on the empty space and mount it
    - Open the file manager and copy it to the mounted disk: `nautilus &`
  - When the installation has finished a dialog wants you to restart the system. You can do that now

# Package managers
Ubuntu has [Apt](https://wiki.debian.org/Apt) and [Snap](https://snapcraft.io/) baked in. In order to install all the tools needed, we almost certaintly need extras.

## Install GUI for Apt and Snap
```
sudo apt install gnome-software
snap install snap-store
```

## Flatpak
Primarily to be able to install the latest version of Evolution for e-mail. See below.

### Install
- [Ubuntu Quick Setup](https://flatpak.org/setup/Ubuntu)
  - Check the documentation if the script is out of date
- Run: `./package-managers/ubuntu-flatpak.sh`
- You can logout now and back in again for Flatpak to work now if you want: `gnome-session-quit`
- Now you can install packages with the `flatpak` command or `gnome-software`

## Homebrew
Some development tools are only available with this manager. Examples are k9s and other container tools, cosign, glab for GitLab, etc.

### Install
- [Homebrew on Linux](https://docs.brew.sh/Homebrew-on-Linux)
- Run: `./package-managers/brew.sh`
- You can now install software like kubernetes-cli with `brew install kubernetes-cli`

# Trifork setup checklist
[4: Den første dag - tjekliste til opsætning for nye medarbejdere](https://docs.trifork.com/pages/viewpage.action?pageId=92572195)

## E-mail
- The best e-mail client with Exchange e-mail and calendar support for Gnome in Ubuntu is [Evolution](https://wiki.gnome.org/Apps/Evolution)
- Install with Flatpak: `flatpak install --assumeyes org.gnome.Evolution`
- When configuring Evolution in "Receiving Email" choose "Exchange Web Services" as "Server Type" <username>@trifork.com in "Username" and use the "Fetch URL" button
- Only NTLM works for me. Kerberos would be perferrable though
- My recommendation for further options:
  - Check every 5 minutes
  - Check all folders
  - Check for junk
  - Sync locally
  - Do not sync older than 1 years (use https://webmail.trifork.com for older)
  - Default for everything else
- Configuring "Microsoft Exchange" under "Online Accounts" in Gnome/System settings creates the settings in Evolution, but does not work for me. What works is configuring it directly in Evolution
