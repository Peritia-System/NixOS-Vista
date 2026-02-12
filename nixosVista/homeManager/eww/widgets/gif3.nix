{
  config,
  lib,
  nixosVista,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkAfter;
  root = nixosVista.eww;
  cfg = root.widgets.gif3;
in {
  options.nixosVista.eww.widgets.gif3.enable =
    mkEnableOption "Gif3 widget";

  config = mkIf (root.enable && cfg.enable) {
    home.file = {
      ".config/eww/images/gif3.gif".source =
        ./assets/gif3.gif;

      ".config/eww/gif3.yuck".text = ''
        (defwidget gif3 []
          (image :path "images/gif3.gif")
        )

        (defwindow gif3
          :monitor '["<primary>", 2, 1, 0]'
          :windowtype "dock"
          :stacking "bg"
          :namespace "eww"
          (gif3)
        )
      '';
    };

    home.file.".config/eww/eww.yuck".text = mkAfter ''
      (include "gif3.yuck")
    '';
  };
}
