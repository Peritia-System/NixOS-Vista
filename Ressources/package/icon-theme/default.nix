{
  lib,
  stdenvNoCC,
}:
stdenvNoCC.mkDerivation rec {
  pname = "crystal-remix-diinki-icon-theme";
  version = "1.0.0";

  src = ./source/crystal-remix-icon-theme-diinki-version;

  dontBuild = true;
  dontConfigure = true;

  themeName = "crystal-remix-icon-theme-diinki-version";

  installPhase = ''
    runHook preInstall

    mkdir -p "$out/share/icons/${themeName}"
    cp -R ./* "$out/share/icons/${themeName}/"

    chmod -R a+rX "$out/share/icons/${themeName}"

    runHook postInstall
  '';

  meta = with lib; {
    description = "Crystal Remix (Diinki version) icon theme";
    platforms = platforms.linux;
    license = licenses.gpl3Only;
  };
}
