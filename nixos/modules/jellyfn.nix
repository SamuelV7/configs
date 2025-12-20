{ config, pkgs, ... }:

{
  services.jellyfin.enable = true;
  users.users.jellyfin.extraGroups = [ "users" ];
  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];
  fileSystems."/media/beechers_hope" = {
    device = "/home/sam/beechers_hope";
    fsType = "none";
    options = [ "bind" ];
  };
}

