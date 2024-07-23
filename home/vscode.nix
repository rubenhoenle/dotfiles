{ pkgs, ... }:
{
  programs.vscode = {
    enable = true;
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
}
