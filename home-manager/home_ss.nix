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
  home.packages = with pkgs; [
    kubectl
    kustomize
    stern
    yamllint
    nixfmt
    nil
    wget
    sops
    gnupg
    fly
    (google-cloud-sdk.withExtraComponents
      [ google-cloud-sdk.components.gke-gcloud-auth-plugin ])
  ];

  # Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    extraConfig = ''
      set number
      colorscheme codedark
    '';
    plugins = [
      pkgs.vimPlugins.vim-code-dark
      (pkgs.vimPlugins.nvim-treesitter.withPlugins
        (p: [ p.tree-sitter-nix p.tree-sitter-terraform ]))
    ];
  };

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
    initExtraBeforeCompInit = ''
      fpath+=("${config.home.profileDirectory}"/share/zsh/site-functions "${config.home.profileDirectory}"/share/zsh/$ZSH_VERSION/functions "${config.home.profileDirectory}"/share/zsh/vendor-completions)
    '';
    envExtra = ''
      # Krew plugins
      export PATH=$PATH:$HOME/.krew/bin
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

      # Manually source autocompletion for packages not working being on $fpath
      source $(dirname $(dirname $(readlink -f $(which fly))))/share/zsh/site-functions/_fly
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
      reload-iboss =
        "sudo /Applications/Utilities/iboss.app/gen4agent/reconfigure.sh unload && sudo /Applications/Utilities/iboss.app/gen4agent/reconfigure.sh load";
      k = "kubectl";
    };
    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [ "kubectl" ];
    };
  };
}
