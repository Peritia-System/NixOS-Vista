{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nixosVista;
in {
  config = lib.mkIf cfg.enable {
    programs.hyprland.enable = true;

    services.displayManager.sddm = lib.mkIf cfg.displayManager.enable {
      enable = true;
      wayland.enable = true;
    };
  };
}
