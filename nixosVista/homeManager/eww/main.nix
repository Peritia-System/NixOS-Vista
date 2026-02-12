{
  config,
  lib,
  pkgs,
  nixosVista,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  cfg = nixosVista.eww;
in {
  #
  #
  #  Definetly not done yet the Widgets don't really work
  #
  #
  #

  options.nixosVista.eww.enable =
    mkEnableOption "Modular EWW system";

  config = mkIf cfg.enable {
    programs.eww.enable = true;

    home.packages = [
      pkgs.jq
      pkgs.curl
    ];

    home.file = {
      ".config/eww/eww.scss".source = ./base/eww.scss;

      ".config/eww/eww.yuck".text = ''
        ;; Base EWW file
        (include "eww_vars.yuck")
      '';

      ".config/eww/eww_vars.yuck".text = ''
        (defpoll DATE :interval "1s" '~/.config/eww/date_format.sh')
        (defpoll uptime :interval "25s" "uptime -p | sed -e 's/up //;s/ hours,/h/;s/ minutes/m/'")
      '';

      ".config/eww/date_format.sh".source =
        ./base/date_format.sh;

      ".config/eww/start.sh".source =
        ./base/start.sh;
    };
  };
}
