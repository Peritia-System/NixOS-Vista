{ config, lib, nixosVista, ... }:

let
  root = nixosVista;
  cfg = root.hyprlock;

  hyprlockConfig = ''
   
    general = {
      disable_loading_bar = true;
      grace = 0;
      hide_cursor = true;
    };

    # ===== Background (Glass Blur Style) =====
    background = [
      {
        path = "screenshot"; # Uses current blurred screen
        blur_passes = 3;
        blur_size = 6;
        noise = 0.01;
        contrast = 1.2;
        brightness = 0.85;
        vibrancy = 0.15;
      }
    ];

    # ===== Clock =====
    label = [
      {
        text = "$TIME";
        color = "rgba(255,255,255,0.85)";
        font_size = 90;
        font_family = "Noto Sans";
        position = "0, 180";
        halign = "center";
        valign = "center";
      }

      {
        text = "$DATE";
        color = "rgba(255,255,255,0.55)";
        font_size = 22;
        font_family = "Noto Sans";
        position = "0, 120";
        halign = "center";
        valign = "center";
      }

      {
        text = "cmd[echo $USER]";
        color = "rgba(255,255,255,0.45)";
        font_size = 20;
        font_family = "Noto Sans";
        position = "0, 90";
        halign = "center";
        valign = "center";
      }
    ];

    # ===== Password Field (Matches Window Style) =====
    input-field = [
      {
        size = "340, 55";

        outline_thickness = 2;

        outer_color = "rgba(255,255,255,0.25)";
        inner_color = "rgba(0,0,0,0.35)";
        font_color = "rgba(255,255,255,1.0)";

        dots_size = 0.3;
        dots_spacing = 0.25;
        dots_center = true;

        fade_on_empty = false;
        placeholder_text = "<span foreground='##ffffff88'>Enter Password...</span>";

        position = "0, 30";
        halign = "center";
        valign = "center";
      }
    ];
  '';
in
{
  config = lib.mkIf cfg.enable {
    programs.hyprlock = {
      enable = true;
      extraConfig = hyprlockConfig;
    };
  };
}