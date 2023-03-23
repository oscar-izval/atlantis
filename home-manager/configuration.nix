{ pkgs, ... }: {
  users.users.oizquierdo = { home = "/Users/oizquierdo"; };
  services.nix-daemon.enable = true;
}
