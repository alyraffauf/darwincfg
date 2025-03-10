{...}: {
  home.shellAliases = {
    cat = "bat";
    grep = "rg";
  };

  programs = {
    bat.enable = true;

    direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
      extraOptions = ["--group-directories-first" "--header"];
      git = true;
      icons = "auto";
    };

    fzf.enable = true;

    oh-my-posh = {
      enable = true;
      useTheme = "zash";
    };

    ripgrep = {
      enable = true;
      arguments = ["--pretty"];
    };

    yazi = {
      enable = true;
      enableBashIntegration = true;

      settings = {
        log.enabled = false;

        manager = {
          show_hidden = false;
          sort_by = "mtime";
          sort_dir_first = true;
          sort_reverse = true;
          sort_sensitive = true;
          linemode = "size";
          show_symlink = true;
        };

        preview.tab_size = 4;
      };
    };

    zellij = {
      enable = true;
      enableBashIntegration = false;
      enableZshIntegration = false;
      enableFishIntegration = false;
    };

    zsh = {
      enable = true;
      autocd = true;
      autosuggestion.enable = true;
      enableCompletion = true;
      enableVteIntegration = true;
      historySubstringSearch.enable = true;

      history = {
        expireDuplicatesFirst = true;
        extended = true;
        ignoreAllDups = true;
      };
    };
  };
}
