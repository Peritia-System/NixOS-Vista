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
    ./grim
    ./hyprpaper
    ./eww
    ./hyprlock
    ./gtk-theme
  ];
}
