{
  config,
  lib,
  nixosVista,
  ...
}: let
  cfg = nixosVista.hyprland;
in {
  ############################################################
  # Options exposed to the user
  ############################################################

  options.nixosVista.hyprland = {
    customTop = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = ''
        Custom Hyprland configuration injected near the top
        of the generated config.
      '';
    };

    customBottom = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = ''
        Custom Hyprland configuration injected at the very bottom
        of the generated config.
      '';
    };
  };

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
