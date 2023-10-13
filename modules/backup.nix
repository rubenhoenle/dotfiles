{ pkgs, config, lib, ... }:
with lib;
let
  cfg = config.ruben.backup;
in
{
  options.ruben.backup = {

    # TODO: seems like we have to do something like anywhere else: ruben.backups.enable = true;

    enable = mkEnableOption "restic backup";
  };
  config = mkIf (cfg.enable)
    {
      systemd.user.services =
        let
          s3DefaultRegion = "eu-central-003";
          remoteRepo = "s3:https://s3.eu-central-003.backblazeb2.com/nixos-restic-backup";
          #s3AccessKeyId = config.age.secrets.backblazeB2ResticSecretKeyId.path;
          #s3SecretAccessKey = config.age.secrets.backblazeB2ResticSecretAccessKey.path;

          s3SecretsEnvironmentFile = config.age.secrets.backblazeB2ResticS3EnvironmentSecrets.path;

          localRepo = "/run/media/ruben/backup-drive/restic";
          resticPasswordFile = config.age.secrets.resticPassword.path;
          backupPaths = "/home/ruben";
          backupExcludes = "--exclude-caches --exclude=\"/home/ruben/cache\" --exclude=\"/home/ruben/.local/\"";
          keep = {
            hourly = "48";
            daily = "7";
            weekly = "4";
            monthly = "6";
            yearly = "5";
          };
        in
        {
          restic_backup = {
            serviceConfig = {
              Type = "oneshot";
              #Environment = [
              #  "AWS_ACCESS_KEY_ID=${s3AccessKeyId}"
              #  "AWS_SECRET_ACCESS_KEY=${s3SecretAccessKey}"
              #];
              EnvironmentFile = "${s3SecretsEnvironmentFile}";
              ExecStart = "${pkgs.restic}/bin/restic backup -r ${remoteRepo} ${backupExcludes} -o s3.region=${s3DefaultRegion} --password-file ${resticPasswordFile} --one-file-system --tag systemd.timer ${backupPaths}";
              ExecStartPost = "${pkgs.restic}/bin/restic forget -r ${remoteRepo} ${backupExcludes} -o s3.region=${s3DefaultRegion} --password-file ${resticPasswordFile} --tag systemd.timer --group-by \"paths,tags\" --keep-hourly ${keep.hourly} --keep-daily ${keep.daily} --keep-weekly ${keep.weekly} --keep-monthly ${keep.monthly} --keep-yearly ${keep.yearly}";
            };
            onFailure = [ "restic_unlock.service" ];
            path = [
              pkgs.openssh
            ];
          };
          restic_backup_to_harddrive = {
            after = [ "run-media-jgero-backup\\x2ddrive.mount" ];
            requires = [ "run-media-jgero-backup\\x2ddrive.mount" ];
            wantedBy = [ "run-media-jgero-backup\\x2ddrive.mount" ];
            serviceConfig = {
              ExecStart = "${pkgs.restic}/bin/restic backup -r ${localRepo} --password-file ${resticPasswordFile} --one-file-system --tag systemd.timer ${backupPaths}";
            };
            unitConfig = {
              OnSuccess = "restic_backup.service";
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
