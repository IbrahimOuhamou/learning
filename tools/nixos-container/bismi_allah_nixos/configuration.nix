{ config, pkgs, ... }:

{
  imports = [ ];

  # Basic system configuration
  boot.isContainer = true;
  system.stateVersion = "23.05"; # Change this to the appropriate version

  # Services and packages
  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [
    wget
    vim
    nginx
  ];

  # Nginx service
  services.nginx.enable = true;
  services.nginx.virtualHosts."localhost" = {
    root = "/var/www";
    locations."/" = {
      index = "index.html";
    };
  };

  # Create a default index.html for Nginx
  systemd.tmpfiles.rules = [
    "d /var/www 0755 root root -"
    "f /var/www/index.html 0644 root root -"
  ];
}

