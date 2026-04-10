{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        libation
    ];
}
