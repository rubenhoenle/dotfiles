{ osConfig, ... }:
let
  cfg = osConfig.ruben.git;
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
  };
}
