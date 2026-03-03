{
  config,
  lib,
  nixosVista,
  ...
}: 
 {

  config = lib.mkIf nixosVista.enable {


  environment.systemPackages = with pkgs; [
    wl-clipboard
    cliphist
    rofi
  ];

  ##########################################################
  # XDG Portal (IMPORTANT for Firefox / Flatpak)
  ##########################################################

  xdg.portal.enable = true;
  xdg.portal.extraPortals = [
    pkgs.xdg-desktop-portal-hyprland
  ];




 services.cliphist.enable = true;






    nixosVista.hyprland.fragments.internalClipboard = ''
      ############################################################
      # This is configuration for the Clipboard 
      ############################################################

    exec-once = wl-paste --type text --watch cliphist store
    exec-once = wl-paste --type image --watch cliphist store
    bind = $mainMod, V, exec, cliphist list | rofi -dmenu | cliphist decode | wl-copy"
  
  
      '';
  };
}


