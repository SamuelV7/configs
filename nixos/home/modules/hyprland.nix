{ pkgs, ... }:

{
  home.packages = with pkgs; [
    hyprlock
    hyprpaper
    waybar
    rofi
    wofi
    wl-clipboard
    grim
    slurp
  ];

  xdg.configFile."hypr/hyprland.conf" = {
    source = ../config/hypr/hyprland.conf;
    force = true;
  };

  xdg.configFile."hypr/hyprpaper.conf" = {
    source = ../config/hypr/hyprpaper.conf;
    force = true;
  };

  xdg.configFile."hypr/hyprlock.conf" = {
    source = ../config/hypr/hyprlock.conf;
    force = true;
  };
}
