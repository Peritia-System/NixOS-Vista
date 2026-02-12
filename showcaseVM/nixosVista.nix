{
  config,
  pkgs,
  ...
}: {
  ############################################################
  # Enable NixOS Vista Core
  ############################################################

  nixosVista = {
    enable = true;

    ##########################################################
    # Core
    ##########################################################

    theme.enable = true;
    displayManager.enable = false;

    ##########################################################
    # Monitors
    ##########################################################

    monitor.list = {
      #   "DP-1" = "1920x1080@144, 0x0, 1";
      #   "HDMI-A-1" = "2560x1440@60, 1920x0, 1";
    };

    monitor.defaultMonitor = "preferred, auto, 1";

    ##########################################################
    # Wallpaper
    ##########################################################

    hyprpaper = {
      enable = true;

      settings = {
        splash = false;

        preload = [
          "/home/icarus/Pictures/wallpapers/main.png"
        ];

        wallpaper = [
          {
            monitor = "Virtual-1";
            path = "/home/icarus/Pictures/wallpapers/main.png";
          }
        ];
      };
    };

    ##########################################################
    # Hyprland
    ##########################################################

    hyprland = {
      special.noHardwareCursor = true;

      style.animation.enabled = true;

      input = {
        kb_layout = "us";
        follow_mouse = 1;
        sensitivity = 0.0;

        touchpad.natural_scroll = true;
      };

      variables = {
        #terminal = "kitty";
        terminal = "alacritty";
        fileManager = "caja";
        menu = "wofi --show drun";
        mainMod = "SUPER";
      };

      env = {
        XCURSOR_SIZE = "24";
        HYPRCURSOR_SIZE = "24";
      };

      keybindings = {
        preset = "default";
        extra = [
          #  "bind = SUPER, RETURN, exec, kitty"
        ];
      };

      startup = {
        preset = "default";

        extraExecOnce = [
        ];

        extraExec = [
        ];
      };

      windowRules = {
        preset = "default";
        extra = [];
      };
    };

    ##########################################################
    # Waybar
    ##########################################################

    waybar = {
      enable = true;
      style.preset = "translucent";
      settings.extra = {};
    };

    ##########################################################
    # Wofi
    ##########################################################

    wofi = {
      enable = true;
      style.preset = "translucent";
      settings.extra = {};
    };

    ##########################################################
    # Terminal
    ##########################################################

    terminal = {
      package = pkgs.kitty;
      command = "kitty";
    };

    ##########################################################
    # EWW
    ##########################################################

    eww = {
      enable = true;

      widgets = {
        daybox.enable = true;

        menu.enable = true;

        gif1.enable = true;
        gif2.enable = true;
        gif3.enable = true;

        diinkitemperature = {
          enable = true;
          apiKey = "abc123"; # Replace with real key
          cityID = "2643743"; # London
          unit = "metric"; # or "imperial"
        };
      };
    };
  };
}
