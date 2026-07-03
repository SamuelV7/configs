{ ... }:

{
  imports = [
    ./modules/hyprland.nix
    ./modules/neovim.nix
    ./modules/pi.nix
    ./modules/rust.nix
  ];

  home.username = "sam";
  home.homeDirectory = "/home/sam";
  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
