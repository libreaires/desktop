#!/bin/bash

alias generate-hardware='export LC_ALL=C.UTF-8 && mkdir -p "$HOME/@nixos/nix/hosts/current" && sudo nixos-generate-config --dir /tmp/generated-config && sed -e "/^[[:space:]]*#/d" -e "/^[[:space:]]*$/d" /tmp/generated-config/hardware-configuration.nix > "$HOME/@nixos/nix/hosts/current/generated.nix" && sudo rm -rf /tmp/generated-config'

alias nixos-build="sudo nixos-rebuild switch -I nixos-config=\"\$HOME/@nixos/build.nix\" --show-trace"

alias home-update="HOME_MANAGER_CONFIG=$HOME/@nixos/nix/users/jellybean/home.nix home-manager switch"
