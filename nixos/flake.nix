{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    opencode.url = "github:anomalyco/opencode";
    # ytdlp-ui.url = "git+ssh://forgejo@git.bethel.home:2222/sam07/ytdlp_ui.git";
  };

  # outputs = { self, nixpkgs, zen-browser, ... }: let 
  outputs = { self, nixpkgs, home-manager, opencode, ... }@inputs: let 
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
          ./modules/sound.nix
          ./modules/hyprland.nix
          ./modules/kanata.nix
          ./modules/discord.nix
          ./modules/vscodium.nix
          ./modules/zed.nix
          ./modules/browsers.nix
          ./modules/opencode.nix
          ./modules/pi.nix
          ./modules/bottles.nix
          # ./modules/opencode.nix
          ./modules/libation.nix
          ./modules/home-manager.nix
        ];
      };
      server =  nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs; };

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
          # inputs.ytdlp-ui.nixosModules.default
        ];
      };

    };
  };
}
