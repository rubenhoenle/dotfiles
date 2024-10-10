{ pkgs, ... }:
let
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

    logout = "exec ${pkgs.systemd}/bin/loginctl terminate-user $USER && ${pkgs.sway}/bin/swaymsg mode default";

    # wireguard
    wgu = "systemctl start wg-quick-wg0";
    wgd = "systemctl stop wg-quick-wg0";
    wgs = "systemctl status wg-quick-wg0";

    sp = "cd $(selecterer)";
  };
in
{
  programs.bash = {
    enable = true;
    shellAliases = shellAliases;
  };

  programs.zsh = {
    enable = true;
    shellAliases = shellAliases;
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
