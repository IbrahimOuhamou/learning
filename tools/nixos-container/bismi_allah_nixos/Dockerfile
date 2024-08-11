#بسم الله الرحمن الرحيم
#la ilaha illa Allah Mohammed Rassoul Allah
# Use the official NixOS Docker image as the base
FROM nixos/nix:latest

# Copy your NixOS configuration file into the container
COPY configuration.nix /etc/nixos/configuration.nix

RUN nix-env -f '<nixpkgs/nixos>' -I nixos-config=/root/configuration.nix -iA config.environment.systemPackage

# Run nixos-rebuild to apply the configuration
RUN nixos-rebuild switch

# Set the default command to start a shell
CMD ["bash"]

