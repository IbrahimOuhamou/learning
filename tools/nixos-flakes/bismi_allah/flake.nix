#in the name of Allah
#la ilaha illa Allah mohammed rassoul Allah
{
  description = "in the name of Allah expirementing with flakes";

  inputs = {
    #nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-23.11";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }:
  
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    devShells.${system}.default = 
      pkgs.mkShell
      {
        buildInputs =
        [
          pkgs.htop
          pkgs.mysql
        ];
        shellHook = ''
        clear
        echo "in the name of Allah"
        '';
      };
  };
}

