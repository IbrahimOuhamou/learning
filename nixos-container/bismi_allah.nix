#in the name of Allah
#la ilaha illa Allah mohammed rassoul Allah

{pkgs ? import <nixpkgs> { system  = "x86_64-linux";} }:
pkgs.dockerTools.buildLayeredImage
{
    name = "bismi_allah_nixos-docker";
    tag = "latest";
    contents = with pkgs; [ neovim ];
}

