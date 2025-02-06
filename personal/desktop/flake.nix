{
  description = "Personal Desktop";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";

    # Home Manager
    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: { 
    nixosConfigurations = {
      luna = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        modules = [
          # Load general configuration
          ./configuration.nix

          # Load Home Manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.exiquio = import ./home.nix;
          }
        ];
      };
    };
  };
}
