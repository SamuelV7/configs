{ config, lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    ripgrep
    fd
    gcc
    gnumake
    lua-language-server
    stylua
    nil
    nixfmt
  ];

  home.activation.linkNeovimConfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    rm -rf "${config.xdg.configHome}/nvim"
    ln -sfn "/home/sam/ForgeLab/configs-w1-alchemy/nvim" "${config.xdg.configHome}/nvim"
  '';
}
