{self, ...}: {
  home-manager = {
    backupFileExtension = "backup";
    extraSpecialArgs = {inherit self;};
    useGlobalPkgs = true;
    users.aly = self.homeManagerModules.aly;
    useUserPackages = true;
  };
}
