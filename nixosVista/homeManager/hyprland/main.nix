{
  config,
  lib,
  nixosVista,
  ...
}: let
  ############################################################
  # Correct Fragment Source (IMPORTANT)
  ############################################################
  fragments =
    config.nixosVista.hyprland.fragments or {};

  get = name:
    fragments.${name} or "";

  ordered = [
    (get "header")
    (get "customTop")
    (get "monitors")
    (get "startup")
    (get "variables")
    (get "environment")
    (get "special")
    (get "input")
    (get "style")
    (get "animation")
    (get "keybinds")
    (get "windowRules")
    (get "customBottom")
  ];

  filteredOrdered =
    lib.filter (x: x != "") ordered;

  finalConfig = lib.concatStringsSep "\n\n" (
    [
      ''
        # IF YOU SEE THIS IT LOADED
        # Not needed anymore
        #exec-once = hyprctl notify 5 3000 "rgb(ff0000)" "HM HYPRLAND ACTIVE"
      ''
    ]
    ++ filteredOrdered
  );
in {
  ############################################################
  # Root Options
  ############################################################

  options.nixosVista.hyprland = {
    enable =
      lib.mkEnableOption "NixOS-Vista Hyprland configuration";

    fragments = lib.mkOption {
      type = lib.types.attrsOf lib.types.lines;
      default = {};
      internal = true;
      description = "Internal fragment registry for deterministic assembly.";
    };
  };

  ############################################################
  # Config
  ############################################################
  # Uncomment this and it will error:
  #warnings = [">>> HYPRLAND main.nix gets imported <<<"];

  config = lib.mkIf nixosVista.enable {
    ##########################################################
    # Warnings
    ##########################################################

    # Not needed anymore:
    # warnings = let
    #   fragmentNames =
    #     builtins.attrNames fragments;
    # in [
    #   ">>> HYPRLAND HM MODULE IS LOADED <<<"
    #   ">>> ENABLE = ${toString config.nixosVista.hyprland.enable}"
    #   ">>> REGISTERED FRAGMENTS: ${toString fragmentNames}"
    #   ">>> ORDERED COUNT (non-empty): ${toString (builtins.length filteredOrdered)}"
    #   ">>> FINAL CONFIG LENGTH: ${toString (builtins.stringLength finalConfig)}"
    # ];

    ##########################################################

    wayland.windowManager.hyprland = {
      enable = true;
      extraConfig = finalConfig;
    };
  };
}
