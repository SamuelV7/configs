{ pkgs, inputs, ... }:
{
  environment.systemPackages = [
    inputs.opencode.packages.${pkgs.system}.default
  ];
}
