# trifork-dell-ubuntu
How to install Ubuntu Linux on a Trifork Dell Computer

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
