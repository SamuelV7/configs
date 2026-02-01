{ pkgs, inputs, ... }:
{
  environment.systemPackages = [
    inputs.opencode.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
