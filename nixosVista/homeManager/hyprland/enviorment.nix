{
  config,
  lib,
  nixosVista,
  ...
}: let
  cfg = nixosVista.hyprland;

  ############################################################
  # Environment variables (Hyprland env = ...)
  ############################################################

  envLines =
    lib.mapAttrsToList
    (name: value: "env = ${name},${value}")
    cfg.env;
in {
  config = lib.mkIf nixosVista.enable {
    nixosVista.hyprland.fragments.environment = ''

      ############################################################
      # Environment
      ############################################################
      # env = XCURSOR_SIZE,24
      # env = HYPRCURSOR_SIZE,24

      ${lib.concatStringsSep "\n" envLines}

    '';
  };
}
