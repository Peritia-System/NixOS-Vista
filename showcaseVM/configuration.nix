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
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  users.mutableUsers = true;
  users.users.${username} = {
    isNormalUser = true;
    description = gitUsername;
    createHome = true;
    home = "/home/${username}";
    initialPassword = password;

    shell = pkgs.zsh;

    extraGroups = [
      "wheel"
      "networkmanager"
      "libvirtd"
      "scanner"
      "lp"
      "video"
      "input"
      "audio"
    ];
  };

  environment.systemPackages = with pkgs; [
    zsh
    fastfetch

    btop

    neovim

    # test:
    mpv
    kitty

    # hcange probably
    mate.caja
    mate.caja

    alacritty
    librewolf
    vscodium
    zsh
  ];

  programs.neovim.enable = true;

  programs.zsh.enable = true;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users.${username} = import ./home.nix {
      inherit pkgs inputs username;
    };
  };

  boot.loader.grub = {
    enable = true;
    device = "nodev";
    useOSProber = false;
  };

  networking = {
    networkmanager.enable = true;
    hostName = "NixOS-Vista";
  };

  # Required for NixOS
  system.stateVersion = "25.11";
}
