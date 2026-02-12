{
  config,
  lib,
  nixosVista,
  ...
}: let
  cfg = nixosVista.hyprland.input;

  optionalLine = name: value:
    lib.optional (value != null && value != "")
    "${name} = ${value}";

  lines =
    [
      "kb_layout = ${cfg.kb_layout}"
      "follow_mouse = ${toString cfg.follow_mouse}"
      "sensitivity = ${toString cfg.sensitivity}"
    ]
    ++ optionalLine "kb_options" cfg.kb_options
    ++ optionalLine "kb_rules" cfg.kb_rules
    ++ optionalLine "kb_variant" cfg.kb_variant
    ++ optionalLine "kb_model" cfg.kb_model;
in {
  config = lib.mkIf nixosVista.enable {
    nixosVista.hyprland.fragments.input = ''
        ############################################################
        # Input
        ############################################################
        input {
          ${lib.concatStringsSep "\n  " lines}

        touchpad {
          natural_scroll = ${lib.boolToString cfg.touchpad.natural_scroll}
        }
      }
    '';
  };
}
