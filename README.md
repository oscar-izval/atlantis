# Atlantis - My user configuration w/ Home Manager

# Requirements
Install Nix and enable Flakes.

# Usage
1. Clone the repo
2. Create symlink -> `ln -s ~/atlantis/home-manager ~/.config/home-manager`
3. Run `nix run home-manager/master -- switch` to build and activate the configuration for the first time. Then you can use `home-manager switch`.
