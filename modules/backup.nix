{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.ruben.backup;
in
{
  options.ruben.backup = {
    enable = mkEnableOption "restic backup";
  };

  config = mkIf (cfg.enable)
    {
      systemd.user.services =
        let
          s3DefaultRegion = "eu-central-003";
          remoteRepo = "s3:https://s3.eu-central-003.backblazeb2.com/nixos-restic-backup";
          s3SecretsEnvironmentFile = config.age.secrets.backblazeB2ResticS3EnvironmentSecrets.path;
          localRepo = "/run/media/ruben/SAMSUNG/restic-nixos";
          resticPasswordFile = config.age.secrets.resticPassword.path;
          backupPaths = "/home/ruben";
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
          backupExcludes = "--exclude-caches --exclude-file=${excludeFile}";
          keep = {
            hourly = "48";
            daily = "7";
            weekly = "4";
            monthly = "6";
            yearly = "5";
          };
        in
        {
          restic_init = {
            serviceConfig = {
              Type = "oneshot";
              EnvironmentFile = "${s3SecretsEnvironmentFile}";
              ExecStart = "${pkgs.restic}/bin/restic init -r ${remoteRepo} -o s3.region=${s3DefaultRegion} --password-file ${resticPasswordFile}";
            };
            path = [
              pkgs.openssh
            ];
          };
          restic_backup = {
            serviceConfig = {
              Type = "oneshot";
              EnvironmentFile = "${s3SecretsEnvironmentFile}";
              ExecStart = "${pkgs.restic}/bin/restic backup -r ${remoteRepo} ${backupExcludes} -o s3.region=${s3DefaultRegion} --password-file ${resticPasswordFile} --one-file-system --tag systemd.timer ${backupPaths}";
              ExecStartPost = "${pkgs.restic}/bin/restic forget -r ${remoteRepo} -o s3.region=${s3DefaultRegion} --password-file ${resticPasswordFile} --tag systemd.timer --group-by \"paths,tags\" --keep-hourly ${keep.hourly} --keep-daily ${keep.daily} --keep-weekly ${keep.weekly} --keep-monthly ${keep.monthly} --keep-yearly ${keep.yearly}";
            };
            onFailure = [ "restic_unlock.service" ];
            path = [
              pkgs.openssh
            ];
          };
          restic_backup_to_harddrive = {
            # systemctl list-units --type=mount
            after = [ "run-media-ruben-SAMSUNG.mount" ];
            requires = [ "run-media-ruben-SAMSUNG.mount" ];
            wantedBy = [ "run-media-ruben-SAMSUNG.mount" ];
            serviceConfig = {
              ExecStart = "${pkgs.restic}/bin/restic backup -r ${localRepo} ${backupExcludes} --password-file ${resticPasswordFile} --one-file-system --tag systemd.timer ${backupPaths}";
            };
          };
          restic_prune = {
            serviceConfig = {
              Type = "oneshot";
              EnvironmentFile = "${s3SecretsEnvironmentFile}";
              ExecStart = "${pkgs.restic}/bin/restic -r ${remoteRepo} -o s3.region=${s3DefaultRegion} --password-file ${resticPasswordFile} prune";
            };
            path = [
              pkgs.openssh
            ];
          };
          restic_unlock = {
            serviceConfig = {
              Type = "oneshot";
              EnvironmentFile = "${s3SecretsEnvironmentFile}";
              ExecStart = "${pkgs.restic}/bin/restic -r ${remoteRepo} -o s3.region=${s3DefaultRegion} --password-file ${resticPasswordFile} unlock";
            };
            unitConfig = {
              OnSuccess = "restic_backup.service";
            };
            path = [
              pkgs.openssh
            ];
          };
        };
      systemd.user.timers = {
        restic_backup = {
          wantedBy = [ "timers.target" ];
          partOf = [ "restic_backup.service" ];
          timerConfig = {
            OnCalendar = "hourly";
            Persistent = true;
          };
        };
        restic_prune = {
          wantedBy = [ "timers.target" ];
          partOf = [ "restic_prune.service" ];
          timerConfig = {
            OnCalendar = "monthly";
            Persistent = true;
          };
        };
      };
    };
}
