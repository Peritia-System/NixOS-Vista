{
  config,
  lib,
  nixosVista,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkAfter;
  root = nixosVista.eww;
  cfg = root.widgets.menu;
in {
  options.nixosVista.eww.widgets.menu.enable =
    mkEnableOption "Menu widget";

  config = mkIf (root.enable && cfg.enable) {
    home.file = {
      ".config/eww/images/os_logo.png".source =
        ./assets/os_logo.png;

      ".config/eww/menu.yuck".text = ''
        (defwidget menu []
          (box :halign "center" :valign "center" :class "container"
            (button :onclick "wofi --show drun &" :class "button"
              (image :path "images/os_logo.png"
                     :image-width 50
                     :image-height 50)
            )
          )
        )

        (defwindow menu
          :monitor '["<primary>", 2, 1, 0]'
          :windowtype "dock"
          :stacking "bg"
          :namespace "eww"
          :geometry (geometry
            :x "30px"
            :y "30px"
            :width "70px"
            :height "70px"
            :anchor "top right")
          (menu)
        )
      '';
    };

    home.file.".config/eww/eww.yuck".text = mkAfter ''
      (include "menu.yuck")
    '';
  };
}
