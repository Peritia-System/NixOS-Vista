{
  config,
  lib,
  nixosVista,
  ...
}: let
  cfg = nixosVista.hyprland.windowRules;

  ############################################################
  # Default Preset
  ############################################################

  defaultPreset = [
    # This adds a blur to the background of wofi (our app launcher)
    # The reason we can't do this within wofi itself, is because gtk3 doesn't
    # have a built-in background blur.
    "layerrule = blur none, match:namespace wofi"
    "layerrule = ignore_alpha 0.01, match:namespace wofi"

    # Add blur to waybar, for same reason as above. Since we have two versions
    # of the waybar design, one with translucency.
    "layerrule = blur none, match:namespace waybar"
    "layerrule = blur_popups on, match:namespace waybar"
    "layerrule = ignore_alpha 0.01, match:namespace waybar"

    # Add blur to eww widgets
    "layerrule = blur none, match:namespace eww"
    "layerrule = blur_popups on, match:namespace eww"
    "layerrule = ignore_alpha 0.01, match:namespace eww"

    # Fix dragging issues with XWayland
    "windowrule = no_focus on, match:class ^$, match:title ^$, match:xwayland true, match:float true, match:fullscreen false, match:pin false"
  ];

  minimalPreset = [];

  ############################################################
  # Select preset
  ############################################################

  presetRules =
    if cfg.preset == "default"
    then defaultPreset
    else if cfg.preset == "minimal"
    then minimalPreset
    else [];

  ############################################################
  # Merge preset + extra
  ############################################################

  finalRules = presetRules ++ cfg.extra;
in {
  config = lib.mkIf (nixosVista.enable && finalRules != []) {
    nixosVista.hyprland.fragments.windowRules = ''
      ############################################################
      # Window Rules
      ############################################################

      # Here should be the new lines:


      ${lib.concatStringsSep "\n" finalRules}
    '';
  };
}
