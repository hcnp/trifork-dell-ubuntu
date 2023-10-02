# Ubuntu on Trifork Dell Machines
How to install Ubuntu Linux on a Trifork Dell Computer.

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
- Submit the recovery key to Trifork IT: https://docs.trifork.com/display/TITSERV/Trifork+IT+Forms
  

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

You should probably clone this repo in order to easier run scripts etc.:
```
sudo apt install --yes git
git clone git@github.com:hcnp/trifork-dell-ubuntu.git
cd trifork-dell-ubuntu
```

> ⚠️ **DISCLAIMER**:
> 
> I will only document the cli (command-line interface) way of installing and configuring, as this is easier to document and repeat, and leave it up to the reader to use the GUI (Graphical User Interface) to do the same.
> I prefer Apt and Snap over Flatpak and Homebrew as they are baked into Ubuntu. Maybe you can change my opinion if you don't agree.

## E-mail
- The best e-mail client with Exchange e-mail and calendar support for Gnome in Ubuntu is [Evolution](https://wiki.gnome.org/Apps/Evolution)
- Install with Flatpak: `flatpak install --assumeyes org.gnome.Evolution`
- When configuring Evolution in "Receiving Email" choose "Exchange Web Services" as "Server Type" &lt;username&gt;@trifork.com in "Username" and use the "Fetch URL" button
- Only NTLM works for me. Kerberos would be perferrable though
- My recommendation for further options:
  - Check every 5 minutes
  - Check all folders
  - Check for junk
  - Sync locally
  - Do not sync older than 1 years (use https://webmail.trifork.com for older)
  - Default for everything else
- Configuring "Microsoft Exchange" under "Online Accounts" in Gnome/System settings creates the settings in Evolution, but does not work for me. What works is configuring it directly in Evolution

## Chat
### Rocket Chat
- Install: `snap install rocketchat-desktop`
- [How to use Trifork Chat](https://docs.trifork.com/display/TITSERV/How+to+use+Trifork+Chat)

### Slack
`snap install slack`

## Antivirus
[How to install ESET Endpoint Security](https://docs.trifork.com/display/TITSERV/How+to+install+ESET+Endpoint+Security)
`./apps/eset.sh`

## Video meetings
### Zoom
`flatpak install --assumeyes us.zoom.Zoom`

### Teams
Install in Google Chrome by clicking the icon in the address bar when logged in via https://teams.microsoft.com/

## VPN
- Cisco Anyconnect: Follow the guide on [VPN Access](https://wall.trifork.com/display/TRILOGIN/VPN+Access)
- `sudo bash ~/Downloads/cisco-secure-client-linux64-*.sh`

## Visual Studio Code
`snap install code`

## GitG
[GUI for Git from Gnome](https://wiki.gnome.org/Apps/Gitg/), which is perfect for Ubuntu, as it runs Gnome.
`sudo apt install gitg`

## GitHub CLI
It can be handy if you often create PRs on GitHub or other tasks to do full or semiautomated tasks with the GitHub CLI.
`sudo apt install gh`

## Gitlab CLI
`brew install glab`

## Docker
### Without a license
There are multiple choices for running containers without a license for Docker Desktop - even where you still can use the classic docker commands such as `docker build` and `docker run`:

#### [Docker Engine](https://docs.docker.com/engine/install/ubuntu/)
This is the open source version of Docker and enables you to run the deamon, build containers etc.
```
./apps/docker-engine.sh
```

#### [Rancher Desktop](https://rancherdesktop.io/)
Besides enabling you to run docker commands, you will also be able to run a Kubernetes cluster. In fact all containers you run will be in a local Kubernetes cluster. This is great if you want to test containers that are going to run in a cluster hosted at [Netic](https://netic.dk), as they are using [RKE2](https://docs.rke2.io/) which is a server distribution of Kubernetes from SUSE and is very similar to Rancher Desktop. You can even choose the version of k8s and run containerd as in RKE2 instead of dockerd
```
./apps/rancher-desktop.sh
```

See also: https://docs.trifork.com/display/TRIAAL/Rancher+Desktop+as+Docker-Desktop+alternative

#### [podman](https://podman.io/get-started) - Deamonless container engine

### Docker Desktop - Requires a license
- See [Install Docker Desktop on Linux](https://docs.docker.com/desktop/install/linux-install/)
- License at Trifork:
  - Create account at https://hub.docker.com. Preferrably <initials>trifork
  - Send an email to apk@trifork.com with your account name and BU name
  - Tell your IT first liner to add you to the Trifork organization
  - Check that Docker Desktop reports a "Team Tier" license

# Tips
## Management of dot files
On Linux and other Unix-like systems much configuration are stored in [dotfiles](https://en.wikipedia.org/wiki/Dot_file). You can manage these to easily migrate to a new computer or to share configuration on multiple computers with Git and GNU Stow. See this article: [Managing Dotfiles With Stow](https://apiumhub.com/tech-blog-barcelona/managing-dotfiles-with-stow/)

## Gnome Extentions
Different extenstions to the desktop UI or functionality.

### Install
https://wiki.gnome.org/action/show/Projects/GnomeShellIntegration/Installation#Ubuntu_Linux

### My recommendations
- [Notifications Alert](https://extensions.gnome.org/extension/258/notifications-alert-on-user-menu/)
- [Clipboard History](https://extensions.gnome.org/extension/4839/clipboard-history/)
- [Internet Radio](https://extensions.gnome.org/extension/836/internet-radio/)
