{ pkgs, ... }:

{
  home.packages = with pkgs; [
    rust-analyzer
    rustc
    cargo
    clippy
    rustfmt
    sqlx-cli
  ];
}
