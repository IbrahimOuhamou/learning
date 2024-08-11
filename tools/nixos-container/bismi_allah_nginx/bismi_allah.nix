#in the name of Allah
#la ilaha illa Allah mohammed rassoul Allah

{pkgs ? import <nixpkgs> { system  = "x86_64-linux";} }:
pkgs.dockerTools.buildLayeredImage
{
    name = "bismi_allah_nixos_nginx";
    tag = "latest";
    #time = "now";
    contents = with pkgs; [ nginx ];
    

    config = {
        Cmd = ["nginx" "-g" "daemon off;"];
        #Expose = [ "80" ];
    };
}

