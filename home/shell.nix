{ pkgs, ... }:
let
  shellAliases = {
    # shortcuts
    ll = "ls -lisa";

    # nixos update commands
    update = "sudo nixos-rebuild switch --flake .#";
    update-boot = "sudo nixos-rebuild boot --flake .#";

    # backup monitoring
    restic-log = "journalctl --user -eu restic_backup.service";

    # other stuff
    xclip = "xclip -selection c";
    open = "xdg-open";
    gloww = "glow README.md";

    logout = "exec ${pkgs.systemd}/bin/loginctl terminate-user $USER";

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
      plugins = [ "git" ];
      theme = "robbyrussell";
    };
  };
}
