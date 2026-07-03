{ config, lib, pkgs, ... }:

{
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/ForgeLab/configs/nvim";
    force = true;
  };

  home.packages = with pkgs; [
    # Keep this as plain Neovim. Using `neovim.override { configure = ...; }`
    # creates a wrapper that exports VIMINIT, and VIMINIT makes Neovim skip
    # ~/.config/nvim/init.lua entirely.
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
}
