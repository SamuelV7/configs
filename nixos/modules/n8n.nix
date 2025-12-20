{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        n8n
    ];
}
