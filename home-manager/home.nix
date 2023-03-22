{ config, pkgs, ... }:

{
  home.username = "oizquierdo";
  home.homeDirectory = "/Users/oizquierdo";
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bat.enable = true;
  programs.direnv.enable = true;
  programs.htop.enable = true;
  home.packages = [ pkgs.nixfmt pkgs.nil pkgs.wget pkgs.jq pkgs.tmate ];

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

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    initExtra = ''
      . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

      if [ -e "/opt/homebrew/bin/brew" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi
    '';

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
      gpf = "git push --force";
      gst = "git status";
      glo = "git log --oneline --decorate";
    };
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
    };
  };
}
