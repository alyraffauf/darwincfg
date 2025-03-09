{
  lib,
  pkgs,
  self,
  ...
}: {
  imports = [
    ./home.nix
    self.inputs.home-manager.darwinModules.default
  ];

  environment.systemPackages = with pkgs; [
    eza
    git
    rclone
  ];

  fonts.packages = with pkgs; [
    nerd-fonts.caskaydia-cove
    nerd-fonts.ubuntu-sans
    source-serif-pro
  ];

  homebrew = {
    enable = true;

    casks = [
      "firefox"
      "ghostty"
      "obsidian"
      "signal"
      "thunderbird"
    ];

    onActivation = {
      cleanup = "uninstall"; # uninstall any not listed here
      upgrade = true; # not idempotent anymore
    };
  };

  networking = {
    computerName = "fortree";
    hostName = "fortree";
    localHostName = "fortree";
  };

  nix = {
    gc = {
      automatic = true;

      interval = [
        {
          Hour = 9;
        }
      ];
    };

    linux-builder = {
      enable = true;
      ephemeral = true;

      config.virtualisation = {
        cores = 6;

        darwin-builder = {
          diskSize = 40 * 1024;
          memorySize = 8 * 1024;
        };
      };

      maxJobs = 4;
    };

    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = ["@admin"];
    };
  };

  nixpkgs.hostPlatform = "aarch64-darwin";

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    silent = true;
  };

  security.pam.services.sudo_local.touchIdAuth = true;
  services.openssh.enable = true;

  system = {
    configurationRevision = self.rev or self.dirtyRev or null; # Set Git commit hash for darwin-version.

    defaults = {
      dock = {
        autohide = false; # autohide dock
        mru-spaces = false; # do not rearrange spaces based on most recent use
        show-recents = false; # do not show recently closed apps

        # # set hot corners
        # wvous-tl-corner = 2;
        # wvous-tr-corner = 2;
        # wvous-bl-corner = 1;
        # wvous-br-corner = 1;

        # persistent-apps = [];
        # # persistent-others = ["~/Desktop" "~/Downloads"];
      };

      finder = {
        AppleShowAllFiles = true; # show hidden files
        CreateDesktop = false; # do not show icons on desktop
        FXDefaultSearchScope = "SCcf"; # search current folder by default
        ShowPathbar = true; # show path bar
        ShowStatusBar = true; # show status bar
      };
    };

    stateVersion = 6;
  };

  users.users.aly = {
    description = "Aly Raffauf";
    home = "/Users/aly";

    openssh.authorizedKeys = {
      keyFiles =
        lib.map (file: "${self.inputs.secrets}/publicKeys/${file}")
        (lib.filter (file: lib.hasPrefix "aly_" file)
          (builtins.attrNames (builtins.readDir "${self.inputs.secrets}/publicKeys")));

      keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGcJBb7+ZxkDdk06A0csNsbgT9kARUN185M8k3Lq7E/d u0_a336@localhost" # termux on winona
      ];
    };

    shell = pkgs.zsh;
  };
}
