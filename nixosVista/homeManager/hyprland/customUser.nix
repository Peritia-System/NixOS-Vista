{
  config,
  lib,
  nixosVista,
  ...
}: let
  cfg = config.nixosVista.hyprland;
in {
  ############################################################
  # Inject into fragment system
  ############################################################

  config = lib.mkIf (config.nixosVista.enable or false) {
    nixosVista.hyprland.fragments.customTop = lib.mkIf (cfg.customTop != "") ''
      ############################################################
      # Your Custom User / nixosVista.hyprland.customTop
      ############################################################

      ${cfg.customTop}
    '';

    nixosVista.hyprland.fragments.customBottom = lib.mkIf (cfg.customBottom != "") ''
      ############################################################
      # Custom User Bottom Config / nixosVista.hyprland.customBottom
      ############################################################

      ${cfg.customBottom}
    '';
  };
}
