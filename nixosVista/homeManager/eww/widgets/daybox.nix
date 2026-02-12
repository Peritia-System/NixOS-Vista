{
  config,
  lib,
  nixosVista,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkAfter;
  root = nixosVista.eww;
  cfg = root.widgets.daybox;
in {
  options.nixosVista.eww.widgets.daybox.enable =
    mkEnableOption "Daybox widget";

  config = mkIf (root.enable && cfg.enable) {
    home.file.".config/eww/daybox.yuck".text = ''
      (defwidget daybox []
        (box :halign "center" :valign "center" :class "container"
          (box :halign "center" :valign "center" :class "daybox"
            (label :class "date-label" :text DATE)
          )
        )
      )

      (defwindow daybox
        :monitor '["<primary>", 2, 1, 0]'
        :windowtype "dock"
        :stacking "bg"
        :namespace "noblur"
        :geometry (geometry
          :x "0px"
          :y "30px"
          :width "150px"
          :height "70px"
          :anchor "top center")
        (daybox)
      )
    '';

    home.file.".config/eww/eww.yuck".text = mkAfter ''
      (include "daybox.yuck")
    '';
  };
}
