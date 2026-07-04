{ config, pkgs, ... }:

let
  treesitterParsers = pkgs.symlinkJoin {
    name = "nvim-treesitter-parsers";
    paths =
      (pkgs.vimPlugins.nvim-treesitter.withPlugins (
        p: with p; [
          bash
          c
          cpp
          css
          html
          javascript
          json
          lua
          markdown
          markdown_inline
          nix
          query
          rust
          toml
          tsx
          typescript
          vim
          vimdoc
          yaml
        ]
      )).dependencies;
  };

  vscodeLldb = pkgs.vscode-extensions.vadimcn.vscode-lldb;
  codelldbPath = "${vscodeLldb}/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb";
in
{
  xdg.configFile."nvim" = {
    source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/ForgeLab/configs/nvim";
    force = true;
  };

  # Keep native parsers/query files Nix-managed while the Lua plugin itself is
  # still managed by lazy.nvim. Neovim reads these from stdpath('data')/site.
  xdg.dataFile."nvim/site/parser" = {
    source = "${treesitterParsers}/parser";
    force = true;
  };

  xdg.dataFile."nvim/site/queries" = {
    source = "${treesitterParsers}/queries";
    force = true;
  };

  home.sessionVariables = {
    CODELLDB_PATH = codelldbPath;
    DEBUGPY_ADAPTER_PATH = "${pkgs.python3Packages.debugpy}/bin/debugpy-adapter";
    DLV_PATH = "${pkgs.delve}/bin/dlv";
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
    tree-sitter
    lua-language-server
    vtsls
    stylua
    nil
    nixfmt

    # Nix-packaged debug adapters used by nvim-dap/rustaceanvim.
    delve
    python3Packages.debugpy
    vscodeLldb
  ];
}
