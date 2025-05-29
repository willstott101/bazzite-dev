#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# Sublime wants to use the /opt path at install time... at runtime this is a symlink. So i recreate the symlink here.
# Trying this to see if it works.
ln -s /var/opt /opt

# this installs a package from fedora repos
dnf config-manager addrepo --from-repofile=https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
dnf5 install -y tmux sublime-text sublime-merge

# Unoding install-time hack, image will recreate the symlink at runtime
rm /opt

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket

# Create an empty root /nix folder which is required to install and use Nix for development environments.

mkdir /nix
