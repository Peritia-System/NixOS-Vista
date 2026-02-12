{
  config,
  lib,
  nixosVista,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkAfter;
  root = nixosVista.eww;
  cfg = root.widgets.gif2;
in {
  options.nixosVista.eww.widgets.gif2.enable =
    mkEnableOption "Gif2 widget";

  config = mkIf (root.enable && cfg.enable) {
    home.file = {
      ".config/eww/images/gif2.gif".source =
        ./assets/gif2.gif;

      ".config/eww/gif2.yuck".text = ''
        (defwidget gif2 []
          (box :halign "center" :valign "center" :class "container"
            (image :path "images/gif2.gif")
          )
        )

        (defwindow gif2
          :monitor '["<primary>", 2, 1, 0]'
          :windowtype "dock"
          :stacking "bg"
          :namespace "eww"
          (gif2)
        )
      '';
    };

    home.file.".config/eww/eww.yuck".text = mkAfter ''
      (include "gif2.yuck")
    '';
  };
}
