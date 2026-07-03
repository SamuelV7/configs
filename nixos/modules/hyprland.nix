{ pkgs, ... }:

{
  programs.hyprland.enable = true;
  programs.waybar.enable = true;

  # Automatically log sam into Hyprland on boot.
  services.greetd = {
    enable = true;
    settings = {
      initial_session = {
        command = "Hyprland";
        user = "sam";
      };
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };
    };
  };
}
