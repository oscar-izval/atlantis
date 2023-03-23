{ pkgs, ... }: {
  users.users.oizquierdo = { home = "/Users/oizquierdo"; };
  services.nix-daemon.enable = true;

  nix = {
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
