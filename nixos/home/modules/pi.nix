{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs
    pi-coding-agent
  ];

  # Ensure `pi` keeps working even when ~/.local/bin is earlier in PATH.
  # The npm/installer version uses `#!/usr/bin/env node`, which fails on
  # NixOS unless node is already on PATH.
  home.file.".local/bin/pi" = {
    force = true;
    executable = true;
    text = ''#!${pkgs.bash}/bin/bash
export PATH="${pkgs.nodejs}/bin:${pkgs.pi-coding-agent}/bin:$PATH"
exec ${pkgs.pi-coding-agent}/bin/pi "$@"
    '';
  };
}
