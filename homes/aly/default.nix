{self, ...}: {
  imports = [
    ./helix
    ./mail
    ./shell
    ./vsCode
    ./secrets.nix
    self.inputs.agenix.homeManagerModules.default
  ];

  home = {
    homeDirectory = "/Users/aly";
    stateVersion = "25.05";
    username = "aly";
  };

  programs = {
    git = {
      enable = true;
      lfs.enable = true;
      userName = "Aly Raffauf";
      userEmail = "aly@raffauflabs.com";

      extraConfig = {
        color.ui = true;
        github.user = "alyraffauf";
        push.autoSetupRemote = true;
      };
    };

    gitui.enable = true;
    home-manager.enable = true;
  };
}
