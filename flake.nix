# flake.nix
{
  description = "Chris's NixOS configuration for all hosts";

  inputs = {
    # NixOS package repository
    # Pin to a specific release for reproducibility, or use nixos-unstable for bleeding edge:
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";  # Stable release (Yarara)
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";  # Rolling release

    # Flake-parts: the framework that wraps flakes in the module system
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      # Use the same nixpkgs version to avoid dependency explosion
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # Disko: declarative disk partitioning
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = { url = "github:Mic92/sops-nix"; inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, flake-parts, sops-nix, disko, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      # Note: do NOT set allowUnfree here. `flake.nixpkgs` is not a valid flake-parts option.
      # The correct location is the NixOS module option `nixpkgs.config.allowUnfree = true;`
      # inside a host/module — see modules/common/nix-settings.nix.
      # Define supported systems
      systems = [ "x86_64-linux" ];

      # Per-system: packages and dev shells available everywhere
      perSystem = { config, self', inputs', pkgs, system, ... }: {
        # Dev shell for editing the config itself
        devShells.default = pkgs.mkShell {
          packages = [
            pkgs.nixpkgs-fmt   # Format Nix files
            pkgs.alejandra      # Alternative formatter (stricter)
            pkgs.statix         # Linter for Nix
          ];
        };
      };

      # Define the hosts (NixOS systems) — the documented flake-parts pattern.
      # `flake.nixosConfigurations.<host>` is a standard flake output; each host imports
      # its feature modules directly (see hosts/server/configuration.nix).
      # Do NOT use `flake.devices` or `flake.modules.<name>` — those are not valid
      # flake-parts options unless you declare them as custom options first.
      flake.nixosConfigurations.server = inputs.nixpkgs.lib.nixosSystem {
        modules = [ ./hosts/server ];
        specialArgs = { inherit inputs; };  # lets the host import inputs.disko.nixosModules.disko
      };
      # flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
      #   modules = [ ./hosts/laptop ]; specialArgs = { inherit inputs; };
      # };
      # flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
      #   modules = [ ./hosts/desktop ]; specialArgs = { inherit inputs; };
      # };
    };
}
