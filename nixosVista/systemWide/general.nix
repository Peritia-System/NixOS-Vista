{
  config,
  lib,
  pkgs,
  ...
}: let
  diinki-aero-gtk-theme =
    pkgs.callPackage
    ../../Ressources/package/gtk-theme
    {};

  crystalRemixIconTheme =
    pkgs.callPackage
    ../../Ressources/package/icon-theme
    {};
  cfg = config.nixosVista;
in {
  config = lib.mkIf cfg.enable {
    security.rtkit.enable = true;
    programs.hyprland.enable = true;

    environment.systemPackages = with pkgs; [
      # What is 100% still missing is some more default applications
      # All further applications should only be Imported/Used if enabled

      # might make it possible to use custom bar (waybar alternative) or custom Application launcher but to be honest i am not sure why
      # at that point make your own config ? just a thought

      hyprland

      waybar
      wofi
      eww
      networkmanagerapplet
      hyprpaper

      diinki-aero-gtk-theme
      crystalRemixIconTheme
    ];
  };
}
