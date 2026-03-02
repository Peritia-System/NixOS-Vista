{
  config,
  lib,
  nixosVista,
  ...
}: let
  cfg = nixosVista.hyprland;
in {
  ############################################################
  # Inject into fragment system
  ############################################################

  config = lib.mkIf nixosVista.enable {
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
