{ config, lib, ... }:
{
  services.forgejo = {
    enable = true;
    database.type = "postgres";
    lfs.enable = true;
    settings = {
      server = {
        DOMAIN = "git.bethel.home";
        ROOT_URL = "https://git.bethel.home/";
        HTTP_PORT = 3000;
        # SSH_PORT = lib.head config.services.openssh.ports;
        START_SSH_SERVER = true;
        SSH_PORT = 2222;
        SSH_LISTEN_PORT = 2222;
      };
      repository = {
        ENABLE_PUSH_CREATE_USER = true;
      };
      service.DISABLE_REGISTRATION = false;
    };
  };
  # services.openssh = {
  #   enable = true;
  #   ports = [ 2222 ];
  #   settings.AcceptEnv = ["GIT_PROTOCOL"];
  # };
  # networking.firewall.allowedTCPPorts = [ 2222 ];
  # services.openssh.settings.AcceptEnv = "GIT_PROTOCOL";
}
