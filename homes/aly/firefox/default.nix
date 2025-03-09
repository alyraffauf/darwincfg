{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    package = pkgs.runCommand "firefox-0.0.0" {} "mkdir $out";

    profiles.default = {
      containersForce = true;

      containers = {
        personal = {
          color = "purple";
          icon = "circle";
          id = 1;
          name = "Personal";
        };

        private = {
          color = "red";
          icon = "fingerprint";
          id = 2;
          name = "Private";
        };

        atolls = {
          color = "blue";
          icon = "briefcase";
          id = 3;
          name = "Atolls";
        };
      };

      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        augmented-steam
        bitwarden
        clearurls
        consent-o-matic
        raindropio
        simple-tab-groups
        ublock-origin
        zoom-redirector
      ];

      id = 0;
      search.default = "DuckDuckGo";

      settings = {
        "browser.toolbars.bookmarks.visibility" = "newtab";
        # "sidebar.revamp" = true;
        "sidebar.verticalTabs" = true;
      };
    };
  };
}
