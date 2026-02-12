{
  config,
  lib,
  nixosVista,
  ...
}: let
  cfg = nixosVista.hyprland;

  ############################################################
  # Generate $variables
  ############################################################

  variables =
    lib.mapAttrsToList
    (name: value: "\$${name} = ${value}")
    cfg.variables;
in {
  config = lib.mkIf nixosVista.enable {
    nixosVista.hyprland.fragments.variables = ''

      ############################################################
      # Hyprland Variables
      ############################################################
      # $terminal = kitty
      # $fileManager = caja
      # $menu = wofi --show drun

      ${lib.concatStringsSep "\n" variables}

    '';
  };
}
