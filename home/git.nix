{
  programs.git = {
    enable = true;
    userName = "ruben.hoenle";
    userEmail = "ruben.hoenle@fntsoftware.com";
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
}
