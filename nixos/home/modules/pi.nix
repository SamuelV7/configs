{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs
    pi-coding-agent
  ];
}
