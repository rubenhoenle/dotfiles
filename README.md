[![run flake check](https://github.com/rubenhoenle/dotfiles/actions/workflows/build.yaml/badge.svg?branch=main)](https://github.com/rubenhoenle/dotfiles/actions/workflows/build.yaml)

# NixOS Configuration

```bash
sudo nixos-rebuild switch --flake .#millenium-falcon

# temporary package installation
nix-shell -p <package_name>

# updating the system
nix flake update
fwupdmgr update

# code formatting
nix fmt

# The `clonerer` is a shitty bash script, which clones the defined git repos and adds the given git remotes to them.
clonerer
```

- [NixOS Package and option search](https://search.nixos.org)
- [Home manager option search](https://home-manager-options.extranix.com)

## Installation

1. Boot into a NixOS 24.05 minimal ISO
2. If you want to use WiFi in the minimal ISO create config: `wpa_passphrase <SSID> <PW> | sudo tee /etc/wpa_supplicant.conf` activate it: `sudo wpa_supplicant -B -c /etc/wpa_supplicant.conf -i wlp5s0` 
3. Run `sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko --flake github:rubenhoenle/dotfiles/main#deathstar --arg disk '"/dev/nvme0n1"'`
4. Run `sudo nixos-install --flake github:rubenhoenle/dotfiles#deathstar`
5. Reboot
6. Login using `root`
7. Open a Terminal using `Mod` + `Enter`
8. `cd /home/ruben`
9. `git clone git@github.com:rubenhoenle/dotfiles.git`

## Screen mirroring

`wl-mirror --fullscreen DP-1`

`wl-mirror --fullscreen eDP-1`

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

## Fingerprint authentication

```bash
# add fingerprint
sudo fprintd-enroll ruben

# verify fingerprint
sudo fprintd-verify ruben
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
agenix -i /home/ruben/.ssh/agenix/millenium-falcon/id_ed25519 -e secret1.age
```

### Adding a new SSH key to agenix
Add the new public key into `secrets.nix`.

``` bash
# rekey the secrets
agenix -i /home/ruben/.ssh/agenix/millenium-falcon/id_ed25519 -r
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
- https://discourse.nixos.org/t/how-to-ensure-all-packages-are-available-in-cache-nixos-org-on-nix-flake-update/37209

