{
    test1 = {pkgs, config, ...}:
    {
        services.openssh.enable = true;
        nixpkgs.localSystem.system = "x86_64-linux";
        deployment.targetHost = "test1.example.net";
        # Other NixOS options
    };

    test2 = {pkgs, config, ...}:
        {
            services.openssh.enable = true;
            services.httpd.enable = true;
            environment.systemPackages = [ pkgs.lynx ];
            nixpkgs.localSystem.system = "x86_64-linux";
            deployment.targetHost = "test2.example.net";

            # Other NixOS options
        };
    }
}
