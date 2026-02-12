{
  config,
  lib,
  nixosVista,
  ...
}: let
  cfg = nixosVista.hyprland.startup;
  root = nixosVista;

  ############################################################
  # Default Preset (Context Aware)
  ############################################################

  defaultExecOnce = [
    "nm-applet"
    "waybar"
    "hyprpaper"
    #  "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
    "$HOME/.config/eww/start.sh"
  ];

  defaultExec = [];

  minimalExecOnce = [];
  minimalExec = [];

  ############################################################
  # Select preset
  ############################################################

  presetExecOnce =
    if cfg.preset == "default"
    then defaultExecOnce
    else if cfg.preset == "minimal"
    then minimalExecOnce
    else [];

  presetExec =
    if cfg.preset == "default"
    then defaultExec
    else if cfg.preset == "minimal"
    then minimalExec
    else [];

  ############################################################
  # Merge user extras
  ############################################################

  finalExecOnce = presetExecOnce ++ cfg.extraExecOnce;
  finalExec = presetExec ++ cfg.extraExec;

  execOnceLines = map (cmd: "exec-once = ${cmd}") finalExecOnce;
  execLines = map (cmd: "exec = ${cmd}") finalExec;

  allLines = execOnceLines ++ execLines;
in {
  config = lib.mkIf (nixosVista.enable && allLines != []) {
    nixosVista.hyprland.fragments.startup = ''
      ############################################################
      # Startup Programs
      ############################################################

      ${lib.concatStringsSep "\n" allLines}
    '';
  };
}
