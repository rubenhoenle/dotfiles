{
  programs.zsh = {
    enable = true;
    shellAliases = {
      # shortcuts
      ll = "ls -lisa";
      s = "screenfetch";

      # nixos update commands
      update = "sudo nixos-rebuild switch --flake .#";
      update-boot = "sudo nixos-rebuild boot --flake .#";

      # backup monitoring
      restic-log = "journalctl --user -eu restic_backup.service";

      # other stuff
      xclip = "xclip -selection c";
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
