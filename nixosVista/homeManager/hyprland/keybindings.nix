{
  config,
  lib,
  nixosVista,
  ...
}: let
  cfg = nixosVista.hyprland.keybindings;

  ############################################################
  # Presets
  ############################################################

  # I wanna adjust the Main Keybinds still a lil but anyone can easily build their own
  defaultPreset = [
    # Main modifier
    #"$mainMod = SUPER"

    # Switch focus Arrow keys
    "bind = $mainMod, left, movefocus, l"
    "bind = $mainMod, right, movefocus, r"
    "bind = $mainMod, up, movefocus, u"
    "bind = $mainMod, down, movefocus, d"

    # Terminal
    "bind = $mainMod, Enter, exec, $terminal"
    "bind = $mainMod, Return, exec, $terminal"

    # Kill active
    "bind = $mainMod, Q, killactive"

    # Screenshot
    "bind = $mainMod SHIFT, S, exec, hyprshot --mode region --output-folder /tmp"

    # File manager
    "bind = $mainMod, E, exec, $fileManager"

    # Toggle floating
    "bind = $mainMod SHIFT, SPACE, togglefloating"

    # Fullscreen
    "bind = $mainMod, F, fullscreen"

    # Launcher
    "bind = $mainMod, D, exec, $menu"

    # Workspaces
    "bind = $mainMod, 1, workspace, 1"
    "bind = $mainMod, 2, workspace, 2"
    "bind = $mainMod, 3, workspace, 3"
    "bind = $mainMod, 4, workspace, 4"
    "bind = $mainMod, 5, workspace, 5"
    "bind = $mainMod, 6, workspace, 6"
    "bind = $mainMod, 7, workspace, 7"
    "bind = $mainMod, 8, workspace, 8"
    "bind = $mainMod, 9, workspace, 9"
    "bind = $mainMod, 0, workspace, 10"

    # Move to workspace
    "bind = $mainMod SHIFT, 1, movetoworkspace, 1"
    "bind = $mainMod SHIFT, 2, movetoworkspace, 2"
    "bind = $mainMod SHIFT, 3, movetoworkspace, 3"
    "bind = $mainMod SHIFT, 4, movetoworkspace, 4"
    "bind = $mainMod SHIFT, 5, movetoworkspace, 5"
    "bind = $mainMod SHIFT, 6, movetoworkspace, 6"
    "bind = $mainMod SHIFT, 7, movetoworkspace, 7"
    "bind = $mainMod SHIFT, 8, movetoworkspace, 8"
    "bind = $mainMod SHIFT, 9, movetoworkspace, 9"
    "bind = $mainMod SHIFT, 0, movetoworkspace, 10"

    # Mouse
    "bindm = $mainMod, mouse:272, movewindow"
    "bindm = $mainMod, mouse:273, resizewindow"

    # Volume / brightness
    "bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
    "bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    "bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    "bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    "bindel = ,XF86MonBrightnessUp, exec, brightnessctl s 10%+"
    "bindel = ,XF86MonBrightnessDown, exec, brightnessctl s 10%-"
  ];

  diinkii = [
    # Main modifier
    #"$mainMod = SUPER"

    # Terminal
    "bind = $mainMod, Return, exec, $terminal"

    # Kill active
    "bind = $mainMod, Q, killactive"

    # Screenshot
    "bind = $mainMod SHIFT, S, exec, hyprshot --mode region --output-folder /tmp"

    # File manager
    "bind = $mainMod, E, exec, $fileManager"

    # Toggle floating
    "bind = $mainMod SHIFT, SPACE, togglefloating"

    # Fullscreen
    "bind = $mainMod, F, fullscreen"

    # Launcher
    "bind = $mainMod, D, exec, $menu"

    # Workspaces
    "bind = $mainMod, 1, workspace, 1"
    "bind = $mainMod, 2, workspace, 2"
    "bind = $mainMod, 3, workspace, 3"
    "bind = $mainMod, 4, workspace, 4"
    "bind = $mainMod, 5, workspace, 5"
    "bind = $mainMod, 6, workspace, 6"
    "bind = $mainMod, 7, workspace, 7"
    "bind = $mainMod, 8, workspace, 8"
    "bind = $mainMod, 9, workspace, 9"
    "bind = $mainMod, 0, workspace, 10"

    # Move to workspace
    "bind = $mainMod SHIFT, 1, movetoworkspace, 1"
    "bind = $mainMod SHIFT, 2, movetoworkspace, 2"
    "bind = $mainMod SHIFT, 3, movetoworkspace, 3"
    "bind = $mainMod SHIFT, 4, movetoworkspace, 4"
    "bind = $mainMod SHIFT, 5, movetoworkspace, 5"
    "bind = $mainMod SHIFT, 6, movetoworkspace, 6"
    "bind = $mainMod SHIFT, 7, movetoworkspace, 7"
    "bind = $mainMod SHIFT, 8, movetoworkspace, 8"
    "bind = $mainMod SHIFT, 9, movetoworkspace, 9"
    "bind = $mainMod SHIFT, 0, movetoworkspace, 10"

    # Mouse
    "bindm = $mainMod, mouse:272, movewindow"
    "bindm = $mainMod, mouse:273, resizewindow"

    # Volume / brightness
    "bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
    "bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
    "bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
    "bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
    "bindel = ,XF86MonBrightnessUp, exec, brightnessctl s 10%+"
    "bindel = ,XF86MonBrightnessDown, exec, brightnessctl s 10%-"
  ];

  minimalPreset = [
    "$mainMod = SUPER"
    "bind = $mainMod, Return, exec, $terminal"
    "bind = $mainMod, Q, killactive"
  ];

  presetBinds =
    if cfg.preset == "default"
    then defaultPreset
    else if cfg.preset == "minimal"
    then minimalPreset
    else [];

  finalBinds = presetBinds ++ cfg.extra;
in {
  config = lib.mkIf (nixosVista.enable && finalBinds != []) {
    #warnings = [">>> HYPRLAND KEYBINDS MODULE ACTIVE <<<"];

    nixosVista.hyprland.fragments.keybinds = ''
      ############################################################
      # Keybindings
      ############################################################
      ${lib.concatStringsSep "\n" finalBinds}
    '';
  };
}
