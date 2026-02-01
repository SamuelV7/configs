{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    fish
    rofi
    mkcert
    ripgrep
    htop
    uv
    wakeonlan
    unzip
    ncdu
    yazi
    git
    btop
    jujutsu
    just
    gh
    python314
    ghostty
    gcc
    distrobox
    pavucontrol
    fastfetch
    tailscale
  ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      mplus-outline-fonts.githubRelease
      dina-font
      proggyfonts
    ];
  };

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  nix.gc.automatic = true;

  environment.variables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  services.tailscale.enable = true;
  services.tailscale.useRoutingFeatures = "both";
}
