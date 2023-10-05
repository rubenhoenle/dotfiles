# Docs

## Backups
I use restic for my backups. The backups are stored on Backblaze B2 via the S3 API and on a local harddrive.

### Initializing the restic repository
``` bash
export AWS_DEFAULT_REGION=eu-central-003
export RESTIC_REPOSITORY=s3:https://s3.eu-central-003.backblazeb2.com/nixos-restic-backup
export AWS_ACCESS_KEY_ID=<SECRET>
export AWS_SECRET_ACCESS_KEY=<SECRET>
export RESTIC_PASSWORD=<SECRET>

restic init
```

