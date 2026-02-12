{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.nixosVista;
in {
  imports = [
    ./options.nix
    ./desktop.nix
    ./systemWide
  ];

  config = lib.mkIf cfg.enable {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;

    # This is so cool maybe we implement this in NixOS95 (just a thought)
    home-manager.sharedModules = [
      {
        _module.args = {
          nixosVista = cfg;
        };
        imports = [./homeManager];
      }
    ];
  };
}
