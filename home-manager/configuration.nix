{ pkgs, ... }: {
  users.users."oscar.izquierdo" = { home = "/Users/oscar.izquierdo"; };
  services.nix-daemon.enable = true;

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
