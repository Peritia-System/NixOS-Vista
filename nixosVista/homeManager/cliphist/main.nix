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
      fzf
      wofi
    ];

    home.file.".local/bin/TermClipboardManager" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        cliphist list | \
        fzf --preview 'cliphist decode {1} | chafa -' \
            --preview-window=right:60%:wrap | \
        cliphist decode | wl-copy
      '';
    };

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

      bind = $mainMod SHIFT, V, exec, alacritty --class TermClipboardManager -e TermClipboardManager
      windowrule = float, class:^(TermClipboardManager)$
      windowrule = center, class:^(TermClipboardManager)$
      windowrule = size 1000 600, class:^(TermClipboardManager)$
      windowrule = animation popin, class:^(TermClipboardManager)$
      windowrule = rounding 12, class:^(TermClipboardManager)$
      windowrule = noborder, class:^(TermClipboardManager)$

    '';
  };
}
