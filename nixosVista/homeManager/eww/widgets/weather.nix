{
  config,
  lib,
  pkgs,
  nixosVista,
  ...
}: let
  cfg = nixosVista.eww;
  w = cfg.widgets;

  ############################################################
  # Window blocks
  ############################################################

  dayboxWindow = lib.optionalString w.daybox.enable ''
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

  menuWindow = lib.optionalString w.menu.enable ''
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

  temperatureWindow = lib.optionalString w.diinkitemperature.enable ''
    (defwindow diinkitemperature
      :monitor '["<primary>", 2, 1, 0]'
      :windowtype "dock"
      :stacking "bg"
      :namespace "eww"
      :geometry (geometry
        :x "0px"
        :y "360px"
        :width "100px"
        :height "100px"
        :anchor "top right")
      (diinkitemperature)
    )
  '';

  gif1Window = lib.optionalString w.gif1.enable ''
    (defwindow gif1
      :monitor '["<primary>", 2, 1, 0]'
      :windowtype "dock"
      :stacking "bg"
      :namespace "eww"
      (gif1)
    )
  '';

  ############################################################
  # Final yuck
  ############################################################

  finalYuck = ''
    (include "eww_widgets.yuck")

    ${dayboxWindow}
    ${menuWindow}
    ${temperatureWindow}
    ${gif1Window}
  '';
in
  {
    programs.eww.enable = lib.mkIf cfg.enable true;

    home.file.".config/eww/eww.yuck" = lib.mkIf cfg.enable {
      text = finalYuck;
    };
  }
  {
    config,
    lib,
    pkgs,
    nixosVista,
    ...
  }: let
    root = nixosVista.eww;
    w = root.widgets.diinkitemperature;

    weatherScript = pkgs.writeShellScript "weather.sh" ''
      #!/usr/bin/env bash

      KEY="${w.apiKey}"
      ID="${w.cityID}"
      UNIT="${w.unit}"

      echo "Weather stub"
    '';

    windowBlock = lib.optionalString w.enable ''
      (defwindow diinkitemperature
        :monitor '["<primary>", 2, 1, 0]'
        :windowtype "dock"
        :stacking "bg"
        :namespace "eww"
        :geometry (geometry
          :x "0px"
          :y "360px"
          :width "100px"
          :height "100px"
          :anchor "top right")
        (diinkitemperature)
      )
    '';
  in {
    config = lib.mkIf (root.enable && w.enable) {
      home.packages = [
        pkgs.curl
        pkgs.jq
      ];

      home.file.".config/eww/scripts/weather.sh" = {
        source = weatherScript;
        executable = true;
      };

      nixosVista.eww.generatedYuck =
        lib.mkAfter windowBlock;
    };
  }
