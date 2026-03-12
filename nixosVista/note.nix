{ config, lib, pkgs, ... }:

let
  cfg = config.nixosVista;
in
{
  config = lib.mkIf (cfg.enable && !cfg.ignoreDeprecationNote) {
    warnings = [
      ''
      ###########################
      #   !!!   Warning   !!!   #
      ###########################
      
      NixOS-Vista has moved!

      This repository is no longer maintained.
      Please use the new repository:

      https://git.alovely.space/Nyx/NixOS-Vista

      If this note bothers you and you do not care about any changes to the repo:
      add this to your config:

        nixosVista.ignoreDeprecationNote = true;

      or switch to the new repo:

      nixosVista.url = "git+https://git.alovely.space/Nyx/NixOS-Vista";
      
      ''
    ];
  };
}