{
  pkgs,
  self,
  ...
}: {
  environment.systemPackages = with pkgs; [
    git
    helix
    vscode
  ];

  homebrew = {
    enable = true;

    casks = [
      "firefox"
      "ghostty"
      "obsidian"
      "signal"
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

  nix.enable = false;

  nixpkgs = {
    config.allowUnfree = true;
    hostPlatform = "aarch64-darwin";
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    silent = true;
  };

  security.pam.services.sudo_local.touchIdAuth = true;

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
}
