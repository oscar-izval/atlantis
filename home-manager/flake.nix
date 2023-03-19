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

# {
#   inputs = {
#     nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
#     darwin.url = "github:lnl7/nix-darwin";
#     darwin.inputs.nixpkgs.follows = "nixpkgs";
#     home-manager.url = "github:nix-community/home-manager";
#     home-manager.inputs.nixpkgs.follows = "nixpkgs";
#   };

#   outputs = inputs@{ nixpkgs, home-manager, darwin, ... }: {
#     darwinConfigurations = {
#       hostname = darwin.lib.darwinSystem {
#         system = "x86_64-darwin";
#         modules = [
#           ./configuration.nix
#           home-manager.darwinModules.home-manager
#           {
#             home-manager.backupFileExtension = "bak";
#             # home-manager.useGlobalPkgs = true;
#             # home-manager.useUserPackages = true;
#             home-manager.users.oizquierdo = import ./home.nix;

#             # Optionally, use home-manager.extraSpecialArgs to pass
#             # arguments to home.nix
#           }
#         ];
#       };
#     };
#   };
# }
