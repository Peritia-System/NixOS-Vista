{
  cfg,
  lib,
  nixosVista,
  ...
}: let
  enabled = nixosVista.enable && nixosVista.theme.enable;
in {
  config = lib.mkIf enabled {
    #warnings = [">>> HYPRLAND STYLE MODULE ACTIVE <<<"];
    nixosVista.hyprland.fragments.style = ''

      # ========
      # Credit goes alot to diinki
      # Inspiration: https://github.com/diinki/diinki-aero/
      # ========



        #                                    !!DESIGN!!                                     #
        # --------------------------------------------------------------------------------- #
        #                                    !!DESIGN!!                                     #



        # The gaps between windows, as well as border colors.
        # proportional to the taskbar values.
        general {
            # Inner and Outer gaps between windows.
            gaps_in = 5
            gaps_out = 10

            # I prefer a thin border
            border_size = 1

            # Border colors.
            col.active_border = rgb(18,18,18)
            col.inactive_border = rgb(18,18,18)

            # Set to true enable resizing windows by clicking and dragging on borders and gaps
            resize_on_border = true

            layout = dwindle

            # READ https://wiki.hyprland.org/Configuring/Tearing/ BEFORE TURNING ON!
            allow_tearing = false
        }

        # Window Decorations! Shadow, Blur, etc.
        decoration {
            # 8px same as taskbar, change if wanted.
            rounding = 12

            # I want transparancy to not change, since we have the colored border.
            active_opacity = 1.0
            inactive_opacity = 1

            # Window Shadow
            shadow:enabled = true
            shadow:range = 16
            shadow:render_power = 5
            shadow:color = rgba(0,0,0,0.35)

            # Transparent Window Blur
            blur:enabled = true
            blur:new_optimizations = true
            blur:size = 2
            blur:passes = 3
            blur:vibrancy = 0.1696
        }

        # Read https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more info on dwindle layout.
        dwindle {
            pseudotile = true
            preserve_split = true
        }

        # Read https://wiki.hyprland.org/Configuring/Master-Layout/ for more info on master layout.
        master {
            new_status = master
        }

    '';
  };
}
