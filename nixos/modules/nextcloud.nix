{ config, pkgs, ... }:
{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud32;
    hostName = "bethel";
    database.createLocally = true;
    config = {
      adminuser = "sam";
      adminpassFile = "/home/sam/nextcloud_file/nxcl_psswd";
      dbtype = "pgsql";
    };
  };
}
