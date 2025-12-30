{ config, pkgs, ... }:

{
    # environment.systemPackages = with pkgs; [
    #     immich
    # ];
    # services.immich.enable = true;
    # services.immich.port = 2283;
    services.immich = {
        enable = true;
        port = 2283;
        host = "0.0.0.0";  # if accessing from other devices
  };

}
