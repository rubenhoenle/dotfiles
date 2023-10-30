{
  programs.zsh = {
    enable = true;
    shellAliases = {
      # shortcuts
      ll = "ls -lisa";
      s = "screenfetch";
      c = "clear";

      # nixos update commands
      update = "sudo nixos-rebuild switch --flake .#";
      update-boot = "sudo nixos-rebuild boot --flake .#";

      # other stuff
      xclip = "xclip -selection c";
      ntfy = "curl -L ntfy.hoenle.xyz/test -d";
      hibernate = "systemctl hibernate";
      open = "xdg-open";
      gloww = "glow README.md";
    };
    enableCompletion = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
      ];
      theme = "robbyrussell";
    };
  };
}
