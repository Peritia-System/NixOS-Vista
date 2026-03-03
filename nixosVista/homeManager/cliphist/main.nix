{
  config,
  lib,
  pkgs,
  nixosVista,
  ...
}: {
  config = lib.mkIf nixosVista.enable {
    home.packages = with pkgs; [
      wl-clipboard
      cliphist
      wofi
    ];

    services.cliphist = {
      enable = true;

      # A Wayland session
      systemdTargets = ["graphical-session.target"];

      extraOptions = [
        "-max-dedupe-search"
        "10"
        "-max-items"
        "500"
      ];
      allowImages = true;
    };
    nixosVista.hyprland.fragments.internalClipboard = ''
      ############################################################
      # Clipboard
      ############################################################

      #  "services.cliphist.enable = true;" does this
      #exec-once = wl-paste --type text --watch cliphist store
      #exec-once = wl-paste --type image --watch cliphist store
      bind = $mainMod, V, exec, cliphist list | wofi --dmenu --prompt "Clipboard" | cliphist decode | wl-copy
    '';
  };
}
