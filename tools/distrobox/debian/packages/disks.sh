#!/bin/bash

distrobox enter debian
sudo apt update && sudo apt install -y gnome-disk-utility
distrobox-export --app gnome-disks
