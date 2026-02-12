{
  config,
  lib,
  nixosVista,
  ...
}: let
  cfg = nixosVista.hyprland.style.animation;

  animationLines =
    lib.concatStringsSep "\n    " cfg.config;
in {
  config = lib.mkIf nixosVista.enable {
    #warnings = [ ">>> HYPRLAND Animations MODULE ACTIVE <<<" ];

    nixosVista.hyprland.fragments.animation = ''

      ############################################################
      # Animations
      ############################################################
      animations {
        enabled = ${lib.boolToString cfg.enabled}

        ${animationLines}
      }
    '';
  };
}
