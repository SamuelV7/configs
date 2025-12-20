{ config, pkgs, ... }:
{
    environment.systemPackages = with pkgs; [
        jetbrains.clion
        gdbgui
    ];
}
