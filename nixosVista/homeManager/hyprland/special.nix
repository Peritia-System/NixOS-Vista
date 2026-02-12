{
  config,
  lib,
  nixosVista,
  ...
}: let
  cfg = nixosVista.hyprland.special;
in {
  config = lib.mkIf (nixosVista.enable && cfg.noHardwareCursor) {
    nixosVista.hyprland.fragments.special = ''

      ############################################################
      # Special Settings
      ############################################################
      cursor {
        no_hardware_cursors = true
      }





      ############################################################
      # Ill make an option for this later:
      ############################################################
      # We have our own wallpapers :) So I'll disable default things.
      misc {
          force_default_wallpaper = 0
          disable_hyprland_logo = true
      }



      # No need for gestures unless you have a touch display.
      # gestures {
      #     workspace_swipe = false
      # }
    '';
  };
}
