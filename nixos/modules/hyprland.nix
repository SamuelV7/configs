{ pkgs, ... }:

{
  programs.hyprland.enable = true;
  programs.waybar.enable = true;

  # Automatically log sam into Hyprland on boot. Force the hyprlang config
  # so a leftover hyprland.lua cannot take priority again.
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "Hyprland --config /home/sam/.config/hypr/hyprland.conf";
        user = "sam";
      };
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd 'Hyprland --config /home/sam/.config/hypr/hyprland.conf'";
        user = "greeter";
      };
    };
  };
}
