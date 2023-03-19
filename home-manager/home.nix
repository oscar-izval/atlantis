{ config, pkgs, ... }:

{
  home.stateVersion = "22.11";

  home.sessionVariables = {
    # https://nix-community.github.io/home-manager/index.html#sec-install-standalone
    NIX_PATH =
      "$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels\${NIX_PATH:+:$NIX_PATH}";
  };

  # https://github.com/NixOS/nixpkgs/issues/196651
  manual.manpages.enable = false;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bat.enable = true;
  # home.packages = [ pkgs.bat ];

  # Git
  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "main";
      push = {
        autoSetupRemote = true;
        default = "simple";
      };
    };
    userEmail = "oizquierdo@stackbuilders.com";
    userName = "Oscar Izquierdo";
  };

  programs.direnv.enable = true;

  # Zsh
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    shellAliases = {
      gaa = "git add --all";
      gc = "git commit -v";
      gcmsg = "git commit --message";
      gcm = "git checkout $(git_main_branch)";
      gco = "git checkout";
      gcb = "git checkout -b";
      gd = "git diff";
      gdup = "git diff @{upstream}";
      gl = "git pull";
      gp = "git push";
      gst = "git status";
      glo = "git log --oneline --decorate";
    };
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
  };
}
