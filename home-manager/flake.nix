{
  inputs = {
    nixpkgs.url = "nixpkgs/nixpkgs-unstable";
    darwin.url = "github:lnl7/nix-darwin";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, darwin, home-manager, nixpkgs }: {
    darwinConfigurations = let
      mkDarwinSystem = system:
        darwin.lib.darwinSystem {
          inherit system;
          modules = [
            ./configuration.nix
            home-manager.darwinModules.home-manager
            {
              home-manager = {
                backupFileExtension = "bak";
                users.oizquierdo = import ./home.nix;
              };
            }
          ];
        };
    in {
      "mbp.home" = mkDarwinSystem "aarch64-darwin";
      "ghactions" = mkDarwinSystem "x86_64-darwin";
    };
  };
}
