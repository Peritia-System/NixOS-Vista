{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nixosVista;
in {
  config = lib.mkIf cfg.enable {
    #    warnings = [">>> fonts ACTIVE <<<"];

    fonts.packages = with pkgs; [
      nerd-fonts.jetbrains-mono
      noto-fonts
    ];
  };
}
