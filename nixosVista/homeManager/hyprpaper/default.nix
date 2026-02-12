{
  config,
  lib,
  nixosVista,
  ...
}: let
  cfg = nixosVista.hyprpaper;
in {
  config = lib.mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;

      # Direct passthrough to official Home Manager option
      settings = cfg.settings;
    };
  };
}
