{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    # zen-browser.url = "github:0xc000022070/zen-browser-flake";
  };

  # outputs = { self, nixpkgs, zen-browser, ... }: let 
  outputs = { self, nixpkgs, ... }: let 
    system = "x86_64-linux";
    # pkgs = import nixpkgs {
    #   system = system;
    #   overlays = [ zen-browser.overlays.default ]; # Ensure this is correct
    # };
  in {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      # Make this configurable for different architectures
      inherit system;
      # specialArgs = { inherit zen-browser; };


      modules = [
        ./configuration.nix

        ({ pkgs, ... }: {
          environment.systemPackages = with pkgs; [
            fish
            rofi
            htop
            unzip
            kdePackages.dolphin
            kdePackages.kio-fuse #to mount remote filesystems via FUSE
            kdePackages.kio-extras
            kdePackages.qtsvg
            git
            btop
            jujutsu
            gh
            python314
	    bitwarden-desktop
            ghostty
            gcc
            distrobox
            docker
            pavucontrol
            fastfetch
	    # zen-browser.packages."${system}".default
          ];

          fonts = {
            enableDefaultFonts = true;
            packages = with pkgs; [
              nerd-fonts.jetbrains-mono
              jetbrains-mono
              noto-fonts
              noto-fonts-cjk-sans
              noto-fonts-color-emoji
              liberation_ttf
              fira-code
              fira-code-symbols
              mplus-outline-fonts.githubRelease
              dina-font
              proggyfonts
            ];
          };
        })
      ];
    };
  };
}
