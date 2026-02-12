{
  config,
  lib,
  nixosVista,
  ...
}: {
  config = lib.mkIf nixosVista.enable {
    #warnings = [">>> HYPRLAND HEADER MODULE ACTIVE <<<"];
    nixosVista.hyprland.fragments.header = ''
      # ========
      #   Hyprland config file
      #   Credit goes alot to diinki
      #   Inspiration: https://github.com/diinki/diinki-aero/
      # ========

    '';
  };
}
