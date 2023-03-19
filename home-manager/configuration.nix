{ pkgs, ... }:

{

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  services.nix-daemon.enable = true;

  users.users.oizquierdo = {
    home = "/Users/oizquierdo";
    shell = pkgs.zsh;
  };
}
