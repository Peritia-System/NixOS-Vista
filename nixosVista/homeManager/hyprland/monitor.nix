{
  config,
  lib,
  nixosVista,
  ...
}: let
  cfg = nixosVista;

  ############################################################
  # Generate explicit monitor lines
  ############################################################

  explicitMonitors =
    lib.mapAttrsToList
    (
      name: settings: "monitor = ${name}, ${settings}"
    )
    cfg.monitor.list;

  ############################################################
  # Optional fallback monitor
  ############################################################

  fallbackMonitor =
    lib.optional
    (cfg.monitor.defaultMonitor != null)
    "monitor = , ${cfg.monitor.defaultMonitor}";

  ############################################################
  # Final monitor block
  ############################################################

  monitorConfig =
    explicitMonitors ++ fallbackMonitor;
in {
  config = lib.mkIf (nixosVista.enable && monitorConfig != []) {
    #warnings = [">>> HYPRLAND MONITOR MODULE ACTIVE <<<"];

    nixosVista.hyprland.fragments.monitors = ''
      ############################################################
      # Monitors
      ############################################################
      # Run `hyprctl monitors all` to see available monitor names
      #
      # Format:
      # monitor = NAME, RESOLUTION@REFRESH, POSITION, SCALE
      #
      # Example:
      # monitor = DP-1, 1920x1080@144, 0x0, 1
      # monitor = , preferred, auto, 1
      ############################################################

      ${lib.concatStringsSep "\n" monitorConfig}
    '';
  };
}
