# Repros, and more...
A few of my configuration files, and some that are for a future project in the works, if you want them for some reason...

My goal is to make a NixOS setup that is fully modular and truly easy to reproduce, more that it already is... this is far from that, as it would require some kind of frontend that creates a nix configuration based on user options, but I can dream can't I?

Again, it's all stupidly organized for my sanity's sake because i am this way :P

# Using
Simply use build.nix as the main nix configuratio.
For a first rebuild, you can do the following commands:

```shell
cd $HOME
git clone https://www.github.com/airesdesktop/nixos "@nixos"
sudo nixos-rebuild switch -I nixos-config=./build.nix
```

All your NixOS configuration will be saved on "/home/(username)/@nixos/..."

# To do
Specialization, concept for the frontend mentioned previowsly, and more that i'll keep a surprise... for no reason.