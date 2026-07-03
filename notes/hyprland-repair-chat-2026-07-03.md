# Hyprland repair chat notes — 2026-07-03

## User goals / preferences

- Hyprland became badly broken after moving Hyprland config into NixOS/Home Manager.
- Desired direction: go back to the setup from before the Hyprland-to-Home-Manager move.
- Important preference recorded: **Zen browser should not autostart with Hyprland**.
- Current next issue to fix after saving this note: wallpaper is not working.

## What happened so far

1. Inspected `jj` history and found the Home Manager Hyprland move around change `rumplumk` / commit `e28d46b5`.
2. Restored the old repo-root Hyprland config layout:
   - `hypr/hyprland.conf`
   - `hypr/hyprpaper.conf`
   - `hypr/hyprlock.conf`
3. Removed Home Manager-owned duplicate Hyprland configs under:
   - `nixos/home/config/hypr/*`
4. Changed `nixos/home/modules/hyprland.nix` so Home Manager links config directories instead of rendering Hyprland config:
   - `~/.config/hypr -> ~/ForgeLab/configs/hypr`
   - `~/.config/waybar -> ~/ForgeLab/configs/waybar`
5. Found that the live Hyprland session had started from `~/.config/hypr/hyprland.lua`, so deleting that file caused:
   - `cannot open /home/sam/.config/hypr/hyprland.lua: No such file or directory`
6. Added a compatibility `hypr/hyprland.lua` so the running session could reload without errors.
7. Updated `nixos/modules/hyprland.nix` to force future greetd launches to use the hyprlang config explicitly:
   - `Hyprland --config /home/sam/.config/hypr/hyprland.conf`

## Validation already done

- `Hyprland --verify-config --config hypr/hyprland.conf` returned `config ok`.
- `Hyprland --verify-config --config hypr/hyprland.lua` returned `config ok`.
- `hyprctl -i 0 configerrors` returned no config errors after reloading.
- Desktop NixOS config eval succeeded with `nix eval ./nixos#nixosConfigurations.desktop.config.system.build.toplevel.drvPath`.

## Known unrelated issue

- Full `nix flake check ./nixos --no-build` fails because the server config references missing `inputs.ytdlp-ui`; this is unrelated to Hyprland.

## Follow-up change after saving this note

- Removed Zen browser autostart from both `hypr/hyprland.conf` and `hypr/hyprland.lua`.
- Kept the browser variable/keybind available; only autostart was removed.

## Follow-up wallpaper fix

- Hyprpaper 0.8.4 no longer uses the old `preload = ...` / `wallpaper = MON,path` config style.
- Rewrote `hypr/hyprpaper.conf` to use `wallpaper { monitor = ... path = ... fit_mode = cover }` blocks.
- Restarted Hyprpaper live; no more `has no target` messages.

## Next tasks

1. Rebuild desktop when ready:
   ```bash
   sudo nixos-rebuild switch --flake /home/sam/ForgeLab/configs/nixos#desktop
   ```
