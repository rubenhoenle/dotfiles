{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        github.vscode-github-actions
        sonarsource.sonarlint-vscode
      ];
      userSettings = {
        "terminal.integrated.gpuAcceleration" = "off";
        "workbench.editor.wrapTabs" = true;
      };
    };
  };
}
