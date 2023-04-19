{ config, pkgs, ... }:

{
  home.username = "oscar.izquierdo";
  home.homeDirectory = "/Users/oscar.izquierdo";
  home.stateVersion = "22.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bat.enable = true;
  programs.direnv.enable = true;
  programs.htop.enable = true;
  home.packages = [ pkgs.nixfmt pkgs.nil pkgs.wget pkgs.sops ];

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
    userEmail = "25722135+oscar-izval@users.noreply.github.com";
    userName = "Oscar Izquierdo";
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    envExtra = ''
      # Kustomize env variables
      export XDG_CONFIG_HOME=$HOME/.config
      export GPG_TTY=$(tty)
      source <(/usr/local/bin/kustomize completion zsh)

      # Kustomize autocompletion
      if [[ ! -f /usr/local/share/zsh/site-functions/_kustomize ]]; then
        completion="$(kustomize completion zsh)"
        cat > /usr/local/share/zsh/site-functions/_kustomize <<EOF
      ''${completion}
      compdef _kustomize kustomize
      EOF

      autoload -Uz compinit && compinit
      fi
    '';
    initExtra = ''
      . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh

      if [ -e "/opt/homebrew/bin/brew" ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi

      # Git helper function
      function git_main_branch() {
        command git rev-parse --git-dir &>/dev/null || return
        local ref
        for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default}; do
          if command git show-ref -q --verify $ref; then
            echo ''${ref:t}
            return
          fi
        done
        echo master
      }
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
      gpf = "git push --force-with-lease";
      gst = "git status";
      glo = "git log --oneline --decorate";
    };
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "kubectl" ];
    };
  };
}
