{ pkgs, osConfig, ... }:
let
  cfg = osConfig.ruben.git;
  brancherer = pkgs.writeShellApplication {
    name = "branch";
    text = ''
      ${pkgs.git}/bin/git branch | grep -v "^\*" | ${pkgs.fzf}/bin/fzf --height=20% --reverse --info=inline | xargs ${pkgs.git}/bin/git checkout
    '';
  };
in
{
  config = {
    programs.git = {
      enable = true;
      userName = cfg.name;
      userEmail = cfg.mail;
      extraConfig = {
        init = {
          defaultBranch = "main";
        };
        push = {
          autoSetupRemote = true;
        };
        pull = {
          rebase = true;
        };
      };
    };

    home.packages = [ brancherer ];
  };
}
