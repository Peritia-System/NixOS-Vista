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

    ./gtk-theme
  ];
}
