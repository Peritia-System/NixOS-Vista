{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./cliphist
    ./hyprland
    ./waybar
    ./wofi
    ./hyprpaper
    ./eww
    ./hyprlock
    ./gtk-theme
  ];
}
