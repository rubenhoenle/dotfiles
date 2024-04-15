# NixOS Configuration

```bash
sudo nixos-rebuild switch --flake .#deathstar

# temporary package installation
nix-shell -p <package_name>

# updating the system
nix flake update
fwupdmgr update

# code formatting
nix fmt
```

- [NixOS Package and option search](https://search.nixos.org)
- [Home manager option search](https://home-manager-options.extranix.com)

## Backups
I use restic for my backups. The backups are stored on Backblaze B2 via the S3 API and on a local harddrive.

### Backblaze B2 backup

The backup to Backblaze B2 is automated and runs every hour.

``` bash
# showing the status of the backblaze b2 backup
systemctl status restic-backups-b2.service

# showing the snapshots of the backblaze b2 backup
restic-b2 snapshots
```

### Local harddrive backup

[restic documentation for restoring](https://restic.readthedocs.io/en/latest/050_restore.html)

``` bash
# starting the HDD backup
systemctl start restic-backups-hdd

# showing the status of the HDD backup
systemctl status restic-backups-hdd

# showing the snapshots of the HDD backup
restic-hdd snapshots

# restoring the backup from the HDD
restic-hdd restore latest --target /
```

## agenix

[agenix](https://github.com/ryantm/agenix) is a tool for encrypted secrets in your NixOS config.

### Restic environment variable file

``` bash
AWS_ACCESS_KEY_ID=<MY_ACCESS_KEY>
AWS_SECRET_ACCESS_KEY=<MY_SECRET_ACCESS_KEY>
```

### Adding a new secret to agenix

``` bash
cd secrets
agenix -e secret1.age
```

### Adding a new SSH key to agenix
Add the new public key into `secrets.nix`.

``` bash
# rekey the secrets
agenix -r
```

## Troubleshooting

### Restarting Waybar manually
After doing a nixos-rebuild which changed some waybar settings, it might be
necessary to restart the waybar manually to apply the changes.

`systemctl --user restart waybar`

### Hibernation
Don't forget to set the proper sleep state option (`Linux`) in the BIOS in menu `Config -> Power`.

### Links
- https://discourse.nixos.org/t/error-after-updating-flakes/34028

