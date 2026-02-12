{
  config,
  lib,
  pkgs,
  ...
}: let
  diinkiAeroGtkTheme =
    pkgs.callPackage
    ../../../Ressources/package/gtk-theme
    {};

  crystalRemixIconTheme =
    pkgs.callPackage
    ../../../Ressources/package/icon-theme
    {};
in {
  gtk = {
    enable = true;

    theme = {
      name = "diinki-aero";
      package = diinkiAeroGtkTheme;
    };

    iconTheme = {
      name = "crystal-remix-icon-theme-diinki-version";
      package = crystalRemixIconTheme;
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;

    name = "Oxygen_Zion";
    size = 24;
    package = pkgs.kdePackages.oxygen;
  };
}
#        # cursorTheme = {
#        #   name = "Adwaita";
#        #   package = pkgs.gnome.adwaita-icon-theme;
#        # };
#       };
#   #};
# }

