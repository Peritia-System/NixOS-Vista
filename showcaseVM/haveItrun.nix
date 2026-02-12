{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: let
  username = "icarus";
  gitUsername = "icarus";
  password = "icarus";
in {
  # Enable Hyprland
  #programs.hyprland.enable = true;

  # No display manager
  #services.displayManager.sddm.enable = false;

  # Start Hyprland automatically after login
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.bash}/bin/bash -lc 'WLR_RENDERER=pixman start-hyprland'";
        user = username;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    pciutils
  ];

  # does not work?
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 2048; # Use 2048 MiB of RAM
      cores = 3; # Use 3 CPU cores
    };
  };

  environment.sessionVariables = {
    WLR_RENDERER = "pixman";
  };

  # temp enable ssh

  # virtualisation.vmVariant = {
  #   virtualisation.forwardPorts = [
  #     {
  #       from = "host";
  #       host.port = 8222;
  #       guest.port = 22;
  #     }
  #   ];
  # };

  # for testing:
  # services.openssh = {
  #   enable = true;
  #   settings = {
  #     PasswordAuthentication = true;
  #     PermitRootLogin = "yes"; # or "prohibit-password"
  #   };
  # };
}
