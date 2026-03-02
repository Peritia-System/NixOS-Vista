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
    warnings = [">>> fonts ACTIVE <<<"];

    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts
    ];
  };
}
