#in the name of Allah
#la ilaha illa Allah mohammed rassoul Allah
{
  description = "bismi_allah_mysql_flake";

  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.11";
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
  };

  outputs = { self, nixpkgs, devenv, systems, ... }@inputs:
  
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    devShells.${system}.default = 
      devenv.lib.mkShell
      {
        inherit inputs pkgs;
        modules = 
        [{
          packages = with pkgs;
          [
            mariadb
          ];

          enterShell = ''
          clear
          echo "in the name of Allah"
          echo "this is 'bismi_allah_mysql_flake'"
          '';

          services.mysql = {enable = true; package=pkgs.mariadb;};
        }];
      };
  };
}

