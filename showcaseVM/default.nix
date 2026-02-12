{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./nixosVista.nix
    ./haveItrun.nix
  ];
}
