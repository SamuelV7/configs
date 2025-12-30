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
{ config, pkgs, ... }:
let
  bethelIP = "100.86.56.79";
in
{
  # Host dnsmasq handles local DNS + forwards to Pi-hole
  services.dnsmasq = {
    enable = true;
    settings = {
      address = "/bethel.home/${bethelIP}";
      server = [ "127.0.0.1#5353" ];  # Forward to Pi-hole
    };
  };

  services.caddy = {
    enable = true;
    virtualHosts = {
      "localhost".extraConfig = ''
        respond "Hello, world!"
      '';
      "photos.bethel.home".extraConfig = ''
        tls internal
        reverse_proxy localhost:2283
      '';
      "git.bethel.home".extraConfig = ''
        tls internal
        reverse_proxy localhost:3000
      '';
      "jellyfin.bethel.home".extraConfig = ''
        tls internal
        reverse_proxy localhost:8096
      '';
      "pihole.bethel.home".extraConfig = ''
        tls internal
        reverse_proxy localhost:8053
      '';
    };
  };

  virtualisation.oci-containers = {
    backend = "podman";
    containers.pihole = {
      image = "pihole/pihole:latest";
      ports = [
        "5353:53/tcp"   # Changed to 5353
        "5353:53/udp"
        "8053:80/tcp"
      ];
      volumes = [
        "/var/lib/pihole:/etc/pihole"
      ];
      environment = {
        TZ = "America/New_York";
        WEBPASSWORD = "changeme";
      };
    };
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/pihole 0755 root root -"
  ];
}
