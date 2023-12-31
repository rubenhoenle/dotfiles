# Docs

## Hibernation
Don't forget to set the proper sleep state option (`Linux`) in the BIOS in menu `Config -> Power`.

## Backups
I use restic for my backups. The backups are stored on Backblaze B2 via the S3 API and on a local harddrive.

### Checking the status of the backup service
`systemctl status --user restic_backup.service`

`journalctl --user -xeu restic_backup.service`

`systemctl status --user restic_backup_to_harddrive.service`

### Local harddrive backup
#### Restoring the backups of the local harddrive
[restic documentation for restoring](https://restic.readthedocs.io/en/latest/050_restore.html)
``` bash
export RESTIC_REPOSITORY=/run/media/ruben/SAMSUNG/restic
export RESTIC_PASSWORD=<SECRET>

restic restore latest --target /tmp/restore 
```

### Remote S3 backup
#### Initializing the S3 restic repository
`systemctl start --user restic_init.service`
Let's see if everything worked:
`systemctl status --user restic_init.service`

