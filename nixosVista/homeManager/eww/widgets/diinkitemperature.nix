{
  config,
  lib,
  pkgs,
  nixosVista,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types mkIf mkAfter;
  root = nixosVista.eww;
  cfg = root.widgets.diinkitemperature;
in {
  options.nixosVista.eww.widgets.diinkitemperature = {
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

  config = mkIf (root.enable && cfg.enable) {
    assertions = [
      {
        assertion = cfg.apiKey != null && cfg.cityID != null;
        message = "Temperature widget requires apiKey and cityID.";
      }
    ];

    home.file = {
      ".config/eww/images/macscreen.png".source =
        ./assets/macscreen.png;

      ".config/eww/scripts/weather.sh" = {
        executable = true;
        source = pkgs.writeShellScript "eww-weather" ''
          API_KEY="${cfg.apiKey}"
          CITY_ID="${cfg.cityID}"
          UNIT="${cfg.unit}"

          CACHE="$HOME/.cache/eww/weather.json"
          mkdir -p "$HOME/.cache/eww"

          fetch() {
            ${pkgs.curl}/bin/curl -s \
              "https://api.openweathermap.org/data/2.5/weather?id=$CITY_ID&appid=$API_KEY&units=$UNIT" \
              | ${pkgs.jq}/bin/jq '.' > "$CACHE"
          }

          case "$1" in
            --getdata)
              fetch
              ;;
            --temp)
              ${pkgs.jq}/bin/jq -r '.main.temp | tostring + "°"' "$CACHE"
              ;;
            --stat)
              ${pkgs.jq}/bin/jq -r '.weather[0].main' "$CACHE"
              ;;
            --icon)
              ${pkgs.jq}/bin/jq -r '.weather[0].icon' "$CACHE"
              ;;
          esac
        '';
      };

      ".config/eww/temperature.yuck".text = ''
        (defpoll TEMP :interval "30s" '~/.config/eww/scripts/weather.sh --temp')
        (defpoll WEATHER :interval "30s" '~/.config/eww/scripts/weather.sh --stat')
        (defpoll WEATHERICON :interval "30s" '~/.config/eww/scripts/weather.sh --icon')

        (defwidget diinkitemperature []
          (overlay :halign "center" :valign "center" :class "temperature-container"
            (image :path "images/macscreen.png" :image-width 250)
            (label :text WEATHERICON :class "temp-label-header")
            (label :text TEMP :class "temp-label")
            (label :text WEATHER :class "weather-label")
          )
        )

        (defwindow diinkitemperature
          :monitor '["<primary>", 2, 1, 0]'
          :windowtype "dock"
          :stacking "bg"
          :namespace "eww"
          :geometry (geometry
            :x "0px"
            :y "360px"
            :width "250px"
            :height "250px"
            :anchor "top right")
          (diinkitemperature)
        )
      '';
    };

    home.file.".config/eww/eww.yuck".text = mkAfter ''
      (include "temperature.yuck")
    '';
  };
}
