{pkgs, ...}: {
  programs.vscode = {
    enable = true;

    profiles.default = {
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;

      extensions = with pkgs.vscode-extensions; [
        github.vscode-github-actions
        github.vscode-pull-request-github
        ms-vscode-remote.remote-ssh
        oderwat.indent-rainbow
        rubymaniac.vscode-paste-and-indent
        supermaven.supermaven
      ];

      keybindings = [
        {
          "key" = "alt+e";
          "command" = "workbench.action.quickOpen";
        }
        {
          "key" = "cmd+p";
          "command" = "-workbench.action.quickOpen";
        }
        {
          "key" = "cmd+p";
          "command" = "workbench.action.showCommands";
        }
        {
          "key" = "cmd+shift+t";
          "command" = "-workbench.action.reopenClosedEditor";
        }
        {
          "key" = "cmd+shift+t";
          "command" = "workbench.action.tasks.runTask";
        }
        {
          "key" = "cmd+shift+p";
          "command" = "-workbench.action.showCommands";
        }
      ];

      userSettings = {
        "diffEditor.ignoreTrimWhitespace" = false;
        "direnv.restart.automatic" = true;
        "ditor.fontFamily" = "CaskaydiaCove Nerd Font";
        "editor.fontSize" = 14;
        "editor.formatOnPaste" = true;
        "editor.formatOnSave" = true;
        "editor.formatOnType" = true;
        "editor.rulers" = [80];
        "editor.wordWrap" = "wordWrapColumn";
        "editor.wordWrapColumn" = 80;
        "explorer.confirmDelete" = false;
        "files.autoSave" = "afterDelay";
        "git.autofetch" = true;
        "git.autoStash" = true;
        "git.confirmSync" = false;
        "github.gitProtocol" = "ssh";
        "terminal.integrated.fontFamily" = "CaskaydiaCove Nerd Font";
        "terminal.integrated.fontSize" = 14;
      };
    };
  };
}
