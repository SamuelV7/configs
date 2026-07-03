{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprlock
    hyprpaper
    kdePackages.dolphin
    rofi
    wofi
    wl-clipboard
    grim
    slurp
    playerctl
    wlogout
    brightnessctl
    curl
  ];

  # Keep Hyprland itself/session startup in the NixOS module.
  # Home Manager should only restore the old repo-backed dotfile links;
  # do not render ~/.config/hypr/hyprland.conf from HM.
  xdg.configFile."hypr" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/ForgeLab/configs/hypr";
    force = true;
  };

  xdg.configFile."waybar" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/ForgeLab/configs/waybar";
    force = true;
  };
}
