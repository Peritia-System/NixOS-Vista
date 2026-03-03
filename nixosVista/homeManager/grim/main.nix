{
  config,
  lib,
  pkgs,
  nixosVista,
  ...
}: {
  config = lib.mkIf nixosVista.enable {
    home.packages = with pkgs; [
      grim
      slurp
      wl-clipboard
      swappy
      jq
    ];

    ############################################################
    # Screenshot Script
    ############################################################

    home.file.".local/bin/hyprshot" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash

        DIR="$HOME/Pictures/Screenshots/$(date +%Y_%m_%b)"
        FILE="$(date +%d_%a__%H-%M-%S)-$(tr -dc a-z0-9 </dev/urandom | head -c6).png"

        mkdir -p "$DIR"

        case "$1" in
          monitor)
            MON=$(hyprctl monitors -j | jq -r ".[] | select(.focused==true).name")
            grim -o "$MON" "$DIR/$FILE"
            ;;
          region)
            grim -g "$(slurp)" "$DIR/$FILE"
            ;;
          *)
            grim "$DIR/$FILE"
            ;;
        esac

        wl-copy < "$DIR/$FILE"

        if [ "$2" = "edit" ]; then
          swappy -f "$DIR/$FILE"
        fi
      '';
    };

    ############################################################
    # Hyprland Binds
    ############################################################

    nixosVista.hyprland.fragments.internalScreenshot = ''
      ############################################################
      # Screenshot
      ############################################################

      # $mainMod+S → current monitor → copy
      bind = $mainMod, S, exec, ~/.local/bin/hyprshot monitor

      # $mainMod+SHIFT+S → region → copy
      bind = $mainMod SHIFT, S, exec, ~/.local/bin/hyprshot region

      # $mainMod+PRINT → monitor → edit in swappy
      bind = $mainMod, Print, exec, ~/.local/bin/hyprshot monitor edit
    '';
  };
}
