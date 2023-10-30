{
  programs.git = {
    enable = true;
    userName = "Ruben Hoenle";
    userEmail = "git@hoenle.xyz";
    extraConfig = {
      init = {
        defaultBranch = "main";
      };
      push = {
        autoSetupRemote = true;
      };
    };
  };
}
