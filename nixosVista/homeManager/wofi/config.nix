{
  config,
  lib,
  nixosVista,
  ...
}: let
  root = nixosVista;
  cfg = root.wofi;

  ############################################################
  # Base Configuration
  ############################################################

  baseSettings = {
    term = root.terminal.command;

    show_all = true;
    gtk_dark = false;
    location = "center";
    insensitive = false;
    allow_markup = true;
    allow_images = true;
    line_wrap = "word";
    lines = 8;
    width = "30%";
    hide_scroll = true;
    show = "drun";
  };

  finalSettings = baseSettings // cfg.settings.extra;
in {
  programs.wofi = lib.mkIf (cfg.enable && cfg.style.preset != "none") {
    enable = true;
    settings = finalSettings;
  };
}
