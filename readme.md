# Current desktop of mine, and more...
A few of my configuration files, and some that are for a future project in the works, if you want them for some reason...

My goal is to make a NixOS setup that is fully modular and truly easy to reproduce, more that it already is... this is far from that, as it would require some kind of frontend that creates a nix configuration based on user options, but I can dream can't I?

Again, it's all stupidly organized for my sanity's sake because i am this way :P


# Using
Simply use build.nix as your nix configuration.


# Through alias setup (easier)

It's the easiest way of setting this up, but there's a little catch...

(Not that it's unrecommended tho.)

1. First, you must clone the repository at the right location:

```shell
cd $HOME
git clone https://www.github.com/libreaires/desktop "@nixos"
```

2. Now, you can run `setup.sh`

- Here's how to run it through terminal:

```shell
bash $HOME/@nixos/setup.sh
```

3. Now you can simply use these commands to manage you nixos configuration:

| command | description |
| ------- | ----------- |
| `generate-hardware` | generates the @nixos hardware configuration |
| `nixos-build` | rebuilds the @nixos configuration |
| `home-update` | updates home-manager's @nixos configuration |


# Manual (recommended, but kinda verbose)
1. For a first rebuild, you can do the following commands:

```shell
cd $HOME
git clone https://www.github.com/libreaires/desktop "@nixos"
```

2. After the repository has been successfully cloned, you can generate a new hardware configuration file doing the following:

```shell
export LC_ALL=C.UTF-8 && \
mkdir -p "$HOME/@nixos/nix/hosts/current" && \
sudo nixos-generate-config --dir /tmp/generated-config && \
sed -e "/^[[:space:]]*#/d" -e "/^[[:space:]]*$/d" /tmp/generated-config/hardware-configuration.nix > "$HOME/@nixos/nix/hosts/current/generated.nix" && \
sudo rm -rf /tmp/generated-config
```

3. Then, finally rebuild the nix configuration:

```shell
cd $HOME/"@nixos"
sudo nixos-rebuild switch -I nixos-config=./build.nix
```

All of the configuration will be saved under "/home/(username)/@nixos/...", so have fun i guess...


# It doesn't matter anyways...

It doesn't really matter if you choose to use the manual setup, `home.nix` already has the aliases configured for you, so you can still have the useful commands from the `setup.sh`


# To do
In the future, this project will be forked for a future project, which i'll not talk about because it currently sounds stupid...

I also need to work on specialization, not sure how to implement that yet...