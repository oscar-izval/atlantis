{ pkgs, ... }: {
  users.users."oscar.izquierdo" = { home = "/Users/oscar.izquierdo"; };
  services.nix-daemon.enable = true;

  nix = {
    settings = {
      substituters =
        [ "https://simspace-portal-suite.cachix.org" "https://cache.iog.io" ];
      trusted-public-keys = [
        "simspace-portal-suite.cachix.org-1:hI0/DKl88P2FUuptKIi/GDswSwMyWnPQmAMvmwSEc8o="
        "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
      ];
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
}
