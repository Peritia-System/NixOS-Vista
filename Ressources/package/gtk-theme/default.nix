{
  lib,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation rec {
  pname = "diinki-aero-gtk-theme";
  version = "1.0.0";

  src = ./source/diinki-aero;

  dontBuild = true;
  dontConfigure = true;

  # Name of the theme directory as GTK will see it under share/themes/
  themeName = "diinki-aero";

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/themes/${themeName}"
    cp -R ./* "$out/share/themes/${themeName}/"

    # optional: ensure readable perms
    chmod -R a+rX "$out/share/themes/${themeName}"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Diinki Aero GTK theme";
    homepage = null;
    license = licenses.gpl3Only;
    platforms = platforms.linux;
  };
}
