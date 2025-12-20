# { lib, pkgs, config, ... }:
# let
#   cfg = config.services.forgejo;
#   srv = cfg.settings.server;
# in
# {
#   services.caddy.virtualHosts.${srv.DOMAIN}.extraConfig = ''
#     reverse_proxy localhost:${toString srv.HTTP_PORT}
#   '';
#
#   services.forgejo = {
#     enable = true;
#     database.type = "postgres";
#     lfs.enable = true;
#     settings = {
#       server = {
#         DOMAIN = "git.example.com";
#         ROOT_URL = "https://${srv.DOMAIN}/";
#         HTTP_PORT = 3000;
#       };
#       service.DISABLE_REGISTRATION = true;
#       actions = {
#         ENABLED = true;
#         DEFAULT_ACTIONS_URL = "github";
#       };
#     };
#   };
# }
{ config, pkgs, ... }:
{
  services.caddy.virtualHosts."home".extraConfig = ''
    reverse_proxy localhost:3000
  '';

  services.forgejo = {
    enable = true;
    database.type = "postgres";
    lfs.enable = true;
    settings = {
      server = {
        DOMAIN = "bethel";
        ROOT_URL = "https://bethel/";
        HTTP_PORT = 3000;
      };
      service.DISABLE_REGISTRATION = false;
    };
  };
}
