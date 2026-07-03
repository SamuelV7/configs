{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nodejs
    pi-coding-agent
  ];
}
