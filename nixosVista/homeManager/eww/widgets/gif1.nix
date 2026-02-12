{
  config,
  lib,
  nixosVista,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkAfter;
  root = nixosVista.eww;
  cfg = root.widgets.gif1;
in {
  options.nixosVista.eww.widgets.gif1.enable =
    mkEnableOption "Gif1 widget";

  config = mkIf (root.enable && cfg.enable) {
    home.file = {
      ".config/eww/images/gif1.gif".source =
        ./assets/gif1.gif;

      ".config/eww/gif1.yuck".text = ''
        (defwidget gif1 []
          (box :halign "center" :valign "center" :class "container"
            (image :path "images/gif1.gif")
          )
        )

        (defwindow gif1
          :monitor '["<primary>", 2, 1, 0]'
          :windowtype "dock"
          :stacking "bg"
          :namespace "eww"
          (gif1)
        )
      '';
    };

    home.file.".config/eww/eww.yuck".text = mkAfter ''
      (include "gif1.yuck")
    '';
  };
}
