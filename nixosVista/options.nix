{lib, ...}:
with lib; {
  # i wanna migrate all the options to the respective file but write in here a list of files that define options

  options.nixosVista = {
    ############################################################
    # Core
    ############################################################

    enable = mkEnableOption "Enable NixOS Vista";

    theme.enable = mkEnableOption "Enable Vista styling";

    displayManager.enable = mkOption {
      type = types.bool;
      default = true;
      description = "Enable SDDM login manager.";
    };

    ############################################################
    # Monitors
    ############################################################

    monitor.list = mkOption {
      type = types.attrsOf types.str;
      default = {};
      example = {
        "DP-1" = "1920x1080@144, 0x0, 1";
        "HDMI-A-1" = "2560x1440@60, 1920x0, 1";
      };
      description = "Explicit Hyprland monitor definitions.";
    };

    monitor.defaultMonitor = mkOption {
      type = types.nullOr types.str;
      default = null;
      example = "preferred, auto, 1";
      description = "Fallback monitor rule when no monitor name is specified.";
    };

    # additionally:
    # nixosVista/homeManager/eww/

    eww = {
      enable = mkEnableOption "Modular EWW system";

      widgets = {
        daybox.enable = mkEnableOption "Daybox";
        menu.enable = mkEnableOption "Menu";
        gif1.enable = mkEnableOption "Gif1";
        gif2.enable = mkEnableOption "Gif2";
        gif3.enable = mkEnableOption "Gif3";

        diinkitemperature = {
          enable = mkEnableOption "Temperature widget";

          apiKey = mkOption {
            type = types.nullOr types.str;
            default = null;
          };

          cityID = mkOption {
            type = types.nullOr types.str;
            default = null;
          };

          unit = mkOption {
            type = types.enum ["metric" "imperial"];
            default = "metric";
          };
        };
      };
    };

    ############################################################
    # Wallpaper
    ############################################################

    hyprpaper = {
      enable = mkEnableOption "Enable hyprpaper wallpaper management";

      settings = mkOption {
        type = types.attrs;
        default = {};
        description = ''
          Direct passthrough to services.hyprpaper.settings.
          See: https://wiki.hypr.land/Hypr-Ecosystem/hyprpaper/
        '';
      };
    };

    ############################################################
    # Hyprland
    ############################################################

    hyprland.special = {
      noHardwareCursor = mkOption {
        type = types.bool;
        default = true;
        description = "Disable hardware cursors in Hyprland.";
      };
    };

    hyprland.style.animation.enabled = mkOption {
      type = types.bool;
      default = true;
      description = "Enable Hyprland animations.";
    };

    hyprland.style.animation.config = mkOption {
      type = types.listOf types.str;
      default = [
        "bezier = myBezier, 0, 1, 0.18, 1.0"
        "animation = windows, 1, 1.5, myBezier"
        "animation = windowsOut, 1, 2, myBezier, popin 95%"
        "animation = border, 1, 12, myBezier"
        "animation = borderangle, 1, 5, default"
        "animation = fade, 1, 6, default"
        "animation = workspaces, 1, 6, default"
      ];
      description = "Hyprland animation configuration lines.";
    };

    hyprland.input = {
      kb_layout = mkOption {
        type = types.str;
        default = "us";
        description = "Keyboard layout(s). Comma separated.";
      };

      kb_options = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Keyboard options (e.g. grp:alt_shift_toggle).";
      };

      kb_rules = mkOption {
        type = types.nullOr types.str;
        default = null;
      };

      kb_variant = mkOption {
        type = types.nullOr types.str;
        default = null;
      };

      kb_model = mkOption {
        type = types.nullOr types.str;
        default = null;
      };

      follow_mouse = mkOption {
        type = types.int;
        default = 1;
      };

      sensitivity = mkOption {
        type = types.float;
        default = 0.0;
      };

      touchpad.natural_scroll = mkOption {
        type = types.bool;
        default = false;
      };
    };

    hyprland.variables = mkOption {
      type = types.attrsOf types.str;
      default = {
        terminal = "kitty";
        fileManager = "caja";
        menu = "wofi --show drun";
      };
      description = "Hyprland $variables.";
    };

    hyprland.env = mkOption {
      type = types.attrsOf types.str;
      default = {
        XCURSOR_SIZE = "24";
        HYPRCURSOR_SIZE = "24";
      };
      description = "Hyprland environment variables.";
    };

    hyprland.keybindings = {
      preset = mkOption {
        type = types.enum ["default" "minimal" "none"];
        default = "default";
        description = "Keybinding preset to use.";
      };

      extra = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "Additional raw Hyprland bind lines.";
      };
    };

    hyprland.windowRules = {
      preset = mkOption {
        type = types.enum ["default" "minimal" "none"];
        default = "default";
        description = "Window rule preset to use.";
      };

      extra = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "Additional raw Hyprland window rules.";
      };
    };

    ############################################################
    # Hyprland user injection
    ############################################################

    hyprland.customTop = mkOption {
      type = types.lines;
      default = "";
      description = ''
        Custom Hyprland configuration injected near the top
        of the generated config.
      '';
    };

    hyprland.customBottom = mkOption {
      type = types.lines;
      default = "";
      description = ''
        Custom Hyprland configuration injected at the very bottom
        of the generated config.
      '';
    };

    hyprland.startup = {
      preset = mkOption {
        type = types.enum ["default" "minimal" "none"];
        default = "default";
        description = "Startup preset.";
      };

      extraExecOnce = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "Additional commands rendered as 'exec-once = ...'.";
      };

      extraExec = mkOption {
        type = types.listOf types.str;
        default = [];
        description = "Additional commands rendered as 'exec = ...'.";
      };
    };

    waybar = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable Waybar.";
      };

      style.preset = mkOption {
        type = types.enum ["default" "translucent" "opaque" "none"];
        default = "default";
        description = "Waybar visual preset.";
      };

      settings.extra = mkOption {
        type = types.attrs;
        default = {};
        description = "Extra Waybar JSON settings merged into preset.";
      };
    };

    wofi = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = "Enable Wofi launcher.";
      };

      style.preset = mkOption {
        type = types.enum ["default" "translucent" "opaque" "none"];
        default = "default";
        description = "Wofi style preset.";
      };

      settings.extra = mkOption {
        type = types.attrs;
        default = {};
        description = "Extra Wofi settings merged into preset.";
      };
    };

    terminal = {
      package = mkOption {
        type = types.package;
        default = null;
        example = lib.literalExpression "pkgs.kitty";
        description = "Terminal package to install.";
      };

      command = mkOption {
        type = types.str;
        default = "kitty";
        description = "Command used to launch the terminal.";
      };
    };
  };
}
