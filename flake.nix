{
  description = "NixOS-Vista: Style your NixOS to look like Windows Vista";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    ...
  }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in {
    nixosModules.nixosVista = ./nixosVista;

    ############################################################
    # Packages
    ############################################################

    packages.${system} = {
      diinki-aero-gtk-theme =
        pkgs.callPackage ./Ressources/package/gtk-theme {};

      crystal-remix-icon-theme =
        pkgs.callPackage ./Ressources/package/icon-theme {};

      vm = self.nixosConfigurations.showcase-vm.config.system.build.vm;
    };

    ############################################################
    # NixOS Config
    ############################################################

    nixosConfigurations.showcase-vm = nixpkgs.lib.nixosSystem {
      inherit system;

      specialArgs = {
        inherit inputs;
      };

      modules = [
        home-manager.nixosModules.home-manager
        self.nixosModules.nixosVista
        ./showcaseVM
      ];
    };

    # Templates
    ############################################################

    templates.default = {
      description = "Minimal NixOS-Vista configuration";
      path = ./example/default;
      welcomeText = ''
        # Welcome to NixOS-Vista

        Run:
          nixos-generate-config --dir .

        Then import the module:

          inputs.nixosVista.nixosModules.nixosVista
      '';
    };

    templates.home-manager = {
      description = "Minimal NixOS-Vista configuration with home-manager";
      path = ./example/home-manager;
      welcomeText = ''
        # Welcome to NixOS-Vista (with Home Manager)

        Run:
          nixos-generate-config --dir .

        Then import:

          inputs.nixosVista.nixosModules.nixosVista
      '';
    };
  };
}
