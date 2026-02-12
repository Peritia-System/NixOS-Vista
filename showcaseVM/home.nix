{
  pkgs,
  inputs,
  username,
  ...
}: let
  username = "icarus";
  gitUsername = "icarus";
  gitEmail = "icarus@nixos.vista";
in {
  #copy wallpaper files
  home.file."Pictures/wallpapers" = {
    source = ../Ressources/wallpapers;
    recursive = true;
  };

  ################################################################
  # Basic Setup
  ################################################################

  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = "25.11";

  ################################################################
  # Packages
  ################################################################

  home.packages = with pkgs; [
    git
  ];

  ################################################################
  # Git
  ################################################################

  programs.git = {
    enable = true;
    settings.user = {
      name = gitUsername;
      email = gitEmail;
    };
  };
}
