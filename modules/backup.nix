{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.ruben.backup;
  localRepo = "/run/media/ruben/SAMSUNG/restic-nixos";
  resticPasswordFile = config.age.secrets.resticPassword.path;
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
      services.restic.backups.backblaze = {
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

      systemd.user.services = {
        restic_backup_to_harddrive = {
          # systemctl list-units --type=mount
          after = [ "run-media-ruben-SAMSUNG.mount" ];
          requires = [ "run-media-ruben-SAMSUNG.mount" ];
          wantedBy = [ "run-media-ruben-SAMSUNG.mount" ];
          serviceConfig = {
            ExecStart = "${pkgs.restic}/bin/restic backup -r ${localRepo} --exclude-caches --excludeFile=${excludeFile} --password-file ${resticPasswordFile} --one-file-system --tag systemd.timer /home/ruben";
          };
        };
      };
    };
}
