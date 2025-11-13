{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "aarch64-linux"; # or "x86_64-linux" if that’s your machine

      modules = [
        ./configuration.nix

        ({pkgs,...}:{
          environment.systemPackages = with pkgs; [
            vim
            htop
            git
            jujutsu
            gh
            ghostty
            gcc
          ];

          fonts = {
            enableDefaultFonts = true;
            packages = with pkgs; [
              noto-fonts
              noto-fonts-cjk-sans
              noto-fonts-emoji
              liberation_ttf
              fira-code
              fira-code-symbols
              mplus-outline-fonts.githubRelease
              dina-font
              proggyfonts
	      jetbrains-mono
            ];
          };
        })
      ];
    };
  };
}
