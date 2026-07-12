{ pkgs, ... }:

let
  zedLanguagePackages = p: with p; [
    # Rust: compiler, cargo tooling, formatter/linter, and LSP.
    rustc
    cargo
    rustfmt
    clippy
    rust-analyzer

    # JavaScript/TypeScript: runtime, package-manager shim, formatter/linter, and LSPs.
    nodejs
    corepack
    typescript
    typescript-language-server
    vscode-langservers-extracted
    eslint
    prettier

    # Python: interpreter plus Zed-friendly language server/linter/debugger.
    python314
    uv
    pyright
    ruff
    python314Packages.debugpy

    # Go: compiler/toolchain, LSP, formatter/import tools, linter, and debugger.
    go
    gopls
    gotools
    gofumpt
    golangci-lint
    delve

    # C/C++: compilers, clangd/clang-format, debugger, and common build tooling.
    clang
    clang-tools
    gcc
    gdb
    lldb
    cmake
    gnumake
    pkg-config
    bear
  ];
in
{
  environment.systemPackages = [
    # Use the FHS wrapper so Zed extensions/language servers that ship pre-built
    # binaries work reliably on NixOS.
    (pkgs.zed-editor.fhsWithPackages zedLanguagePackages)
  ] ++ zedLanguagePackages pkgs;
}
