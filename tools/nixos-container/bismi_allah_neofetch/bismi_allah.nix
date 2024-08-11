# بسم الله الرحمن الرحيم
# la ilaha illa Allah Mohammed Rassoul Allah
{ pkgs ? import <nixpkgs> { }
, pkgsLinux ? import <nixpkgs> { system = "x86_64-linux"; }
}:

pkgs.dockerTools.buildImage {
  name = "bismi_allah_neofetch";
    contents = with pkgs; [ neofetch ];
  config = {
    Cmd = [ "echo" "بسم الله الرحمن الرحيم" ];
  };
}
