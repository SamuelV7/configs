{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    opencode.url = "github:anomalyco/opencode";
  };

  # outputs = { self, nixpkgs, zen-browser, ... }: let 
  outputs = { self, nixpkgs, opencode, ... }@inputs: let 
    system = "x86_64-linux";
  in {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        # Make this configurable for different architectures
        inherit system;
        # specialArgs = { inherit zen-browser; };
        specialArgs = { inherit inputs; };

        modules = [
          ./hosts/desktop/configuration.nix
          ./modules/common.nix
          ./modules/steam.nix
          ./modules/discord.nix
          ./modules/vscodium.nix
          ./modules/browsers.nix
          ./modules/opencode.nix
        ];
      };
      server =  nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          ./hosts/server/configuration.nix
          ./modules/common.nix
          ./modules/jellyfn.nix
          # ./modules/n8n.nix
          ./modules/forgejo.nix
          # ./modules/nextcloud.nix
          ./modules/immich.nix
          #note this contains caddy and pihole
          ./modules/caddy.nix
        ];
      };

    };
  };
}
