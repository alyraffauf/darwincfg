{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    agenix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:ryantm/agenix";
    };

    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/master";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";

    secrets = {
      url = "github:alyraffauf/secrets";
      flake = false;
    };
  };

  outputs = {self, ...}: let
    allSystems = [
      "aarch64-darwin"
    ];

    forAllSystems = f:
      self.inputs.nixpkgs.lib.genAttrs allSystems (system:
        f {
          pkgs = import self.inputs.nixpkgs {
            inherit overlays system;
            config.allowUnfree = true;
          };
        });

    overlays = [
      self.inputs.nur.overlays.default
    ];
  in {
    darwinConfigurations."fortree" = self.inputs.nix-darwin.lib.darwinSystem {
      modules = [
        ./hosts/fortree

        {
          nixpkgs = {
            inherit overlays;
            config.allowUnfree = true;
          };
        }
      ];

      specialArgs = {inherit self;};
    };

    devShells = forAllSystems ({pkgs}: {
      default = pkgs.mkShell {
        packages =
          (with pkgs; [
            alejandra
            bash-language-server
            git
            nix-update
            nixd
            nodePackages.prettier
            shellcheck
            shfmt
          ])
          ++ [
            self.inputs.agenix.packages.${pkgs.system}.default
          ];

        shellHook = ''
          export FLAKE="."
        '';
      };
    });

    formatter = forAllSystems ({pkgs}: pkgs.alejandra);
    homeManagerModules.aly = ./homes/aly;
  };
}
