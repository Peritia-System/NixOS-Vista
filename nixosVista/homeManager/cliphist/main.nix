{
  config,
  lib,
  pkgs,
  nixosVista,
  ...
}: {
  config = lib.mkIf nixosVista.enable {
    home.packages = with pkgs; [
      wezterm
      wl-clipboard
      cliphist
      fzf
      file
      bat
      timg
      wofi
      imagemagick
      imv
    ];

    home.file.".local/bin/TermClipboardManager" = {
      executable = true;
      text = ''
        #!/usr/bin/env bash
        set -euo pipefail

        preview() {
          TMP=$(mktemp)
          cliphist decode "$1" > "$TMP" 2>/dev/null || {
            echo "Failed to decode"
            rm -f "$TMP"
            return
          }

          MIME=$(file --mime-type -b "$TMP")

          if [[ "$MIME" == image/* ]]; then
            DIM=$(identify -format "%wx%h" "$TMP" 2>/dev/null || echo "unknown")
            echo "Image • $MIME • $DIM"
            echo "────────────────────────────────────────"

            # Dynamic scaling to preview pane
            timg --quiet --center \
                 --fit \
                 --max-size="''${FZF_PREVIEW_COLUMNS}x''${FZF_PREVIEW_LINES}" \
                 "$TMP"
          else
            echo "Text • $MIME"
            echo "────────────────────────────────────────"
            bat --style=plain --color=always "$TMP" 2>/dev/null || cat "$TMP"
          fi

          rm -f "$TMP"
        }

        export -f preview

        HELP="Enter: Copy & Close | Ctrl-Y: Copy (stay) | DEL: Delete | Ctrl-D: Wipe | Ctrl-O: Open Image | Ctrl-I: Toggle Preview"

        while true; do
          SELECTION=$(
            cliphist list | \
            fzf \
              --height=100% \
              --border \
              --header="$HELP" \
              --preview 'bash -c "preview \"$1\"" _ {}' \
              --preview-window=right:60% \
              --bind 'del:execute-silent(bash -c "cliphist delete \"$1\"" _ {})+reload(cliphist list)' \
              --bind 'ctrl-d:execute-silent(cliphist wipe)+reload(cliphist list)' \
              --bind 'ctrl-y:execute-silent(bash -c "cliphist decode \"$1\" | wl-copy" _ {})' \
              --bind 'ctrl-o:execute-silent(bash -c "cliphist decode \"$1\" > /tmp/clipimg && imv /tmp/clipimg" _ {})' \
              --bind 'ctrl-i:change-preview-window(hidden)'
          )

          [[ -z "$SELECTION" ]] && exit 0

          cliphist decode <<< "$SELECTION" | wl-copy
          exit 0
        done
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

      #bind = $mainMod SHIFT, V, exec, alacritty --class TermClipboardManager -e ~/.local/bin/TermClipboardManager
      bind = $mainMod SHIFT, V, exec, wezterm start --class TermClipboardManager -- ~/.local/bin/TermClipboardManager
      # TermClipboardManager

      #   windowrule = float 1, match:class ^(TermClipboardManager)$
      #   windowrule = size 1000 600, match:class ^(TermClipboardManager)$
      #   windowrule = center 1, match:class ^(TermClipboardManager)$
      #   windowrule = animation popin, match:class ^(TermClipboardManager)$
      #   windowrule = rounding 20, match:class ^(TermClipboardManager)$
      # TermClipboardManager
      windowrule = float 1, match:class ^(TermClipboardManager)$
      windowrule = size 1000 600, match:class ^(TermClipboardManager)$
      windowrule = center 1, match:class ^(TermClipboardManager)$
      windowrule = animation popin, match:class ^(TermClipboardManager)$
      windowrule = rounding 20, match:class ^(TermClipboardManager)$
      windowrule = opaque 0.95, match:class ^(TermClipboardManager)$

    '';
  };
}
