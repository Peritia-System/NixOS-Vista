{lib, ...}: {
  imports = [
    # Main entry:
    ./main.nix

    # Each one is a Snippet for the main
    # Each one will first add to the fragment so that it can build the hyprland config in order
    ./header.nix
    ./monitor.nix
    ./startup.nix
    ./variables.nix
    ./enviorment.nix
    ./special.nix
    ./input.nix
    ./keybindings.nix
    ./windowRules.nix
    ./style

    # Doesn't work yet:
    ./customUser.nix
  ];
}
