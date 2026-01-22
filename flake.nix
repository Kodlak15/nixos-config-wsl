{
  description = "My NixOS configuration for WSL.";

  inputs = {
    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvim.url = "github:Kodlak15/nvim-configs";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
  };

  outputs =
    inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      perSystem =
        {
          config,
          self',
          inputs',
          pkgs,
          system,
          ...
        }:
        {
          # shells, packages, etc.
        };
      flake = {
        nixosConfigurations = {
          wsl = inputs.nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = [
              ./nixos

              inputs.home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.kodlak = import ./home;
              }

              inputs.nixos-wsl.nixosModules.default
              {
                system.stateVersion = "25.05";
                wsl.enable = true;
              }
            ];
            specialArgs = { inherit inputs; };
          };
        };
      };
    };
}
