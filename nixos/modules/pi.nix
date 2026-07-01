{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
      pi-coding-agent
    ];
}

# { config, pkgs, ... }:
# {
#   services.caddy = {
#     enable = true;
#     virtualHosts = {
#       "localhost".extraConfig = ''
#         respond "Hello, world!"
#       '';
#       "photos.nas.home".extraConfig = ''
#         reverse_proxy localhost:2283
#       '';
#       "git.nas.home".extraConfig = ''
#         reverse_proxy localhost:3000
#       '';
#       "jellyfin.nas.home".extraConfig = ''
#         reverse_proxy localhost:8096
#       '';
#     };
#   };
# }
