{
  config,
  lib,
  pkgs,
  nixosVista,
  ...
}: let
  root = nixosVista;
in {
  config = lib.mkIf root.enable {
    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts
    ];
  };
}
