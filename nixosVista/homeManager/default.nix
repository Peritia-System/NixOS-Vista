{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./hyprland
    ./waybar
    ./wofi
    ./hyprpaper
    ./eww
    ./hyprlock
    ./gtk-theme
  ];
}
