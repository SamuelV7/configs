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
    playerctl
    wlogout
    curl
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

  xdg.configFile."waybar/config.jsonc" = {
    source = ../config/waybar/config.jsonc;
    force = true;
  };

  xdg.configFile."waybar/style.css" = {
    source = ../config/waybar/style.css;
    force = true;
  };

  xdg.configFile."waybar/scripts/weather-stats" = {
    source = ../config/waybar/scripts/weather-stats;
    executable = true;
    force = true;
  };

  xdg.configFile."waybar/scripts/docker-stats" = {
    source = ../config/waybar/scripts/docker-stats;
    executable = true;
    force = true;
  };
}
