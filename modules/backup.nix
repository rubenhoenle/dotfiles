{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.ruben.backup;
  excludeFile = pkgs.writeText "restic-excludes.txt"
    ''
      /home/ruben/.bash_history
      /home/ruben/.bash_profile
      /home/ruben/.bashrc
      /home/ruben/.cache
      /home/ruben/.config
      /home/ruben/.docker
      /home/ruben/.gnupg
      /home/ruben/.local
      /home/ruben/.mozilla
      /home/ruben/.nix-defexpr
      /home/ruben/.nix-profile
      /home/ruben/.pki
      /home/ruben/.profile
      /home/ruben/.vim
      /home/ruben/.viminfo
      /home/ruben/.vscode
      /home/ruben/.zshenv
      /home/ruben/.zsh_history
      /home/ruben/.zshrc
      /home/ruben/go
      /home/ruben/Arduino
      node_modules
      __pycache__
      /home/ruben/nobackup
      !/home/ruben/.mozilla/firefox/**/bookmarkbackups
      !/home/ruben/.local/share/Trash
      !/home/ruben/.local/share/PrismLauncher
    '';
in
{
  options.ruben.backup = {
    enable = mkEnableOption "restic backup";
  };

  config = mkIf (cfg.enable)
    {
      /* restic backup service to backblaze b2 bucket */
      services.restic.backups.b2 = {
        user = "ruben";
        initialize = true;
        passwordFile = config.age.secrets.resticPassword.path;
        repository = "s3:https://s3.eu-central-003.backblazeb2.com/nixos-restic-backup";
        environmentFile = config.age.secrets.backblazeB2ResticS3EnvironmentSecrets.path;
        paths = [ "/home/ruben" ];
        pruneOpts = [
          "--keep-hourly 48"
          "--keep-daily 7"
          "--keep-weekly 4"
          "--keep-monthly 12"
          "--keep-yearly 5"
        ];
        extraOptions = [ "s3.region=eu-central-003" ];
        extraBackupArgs = [ "--exclude-caches" "--exclude-file=${excludeFile}" ];
        timerConfig = {
          OnCalendar = "hourly";
          Persistent = true;
        };
      };

      /* restic backup service to a local drive */
      services.restic.backups.hdd = {
        user = "ruben";
        initialize = true;
        passwordFile = config.age.secrets.resticPassword.path;
        repository = "/run/media/ruben/SAMSUNG/restic-nixos";
        paths = [ "/home/ruben" ];
        extraBackupArgs = [ "--exclude-caches" "--exclude-file=${excludeFile}" ];
        timerConfig = null;
      };
    };
}
