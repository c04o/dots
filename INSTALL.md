1. Clone the repo

```bash
git clone https://github.com/c04o/dots.git ~/dots
cd ~/dots
```

2. Overwrite my hardware config with your actual machine's

```bash
sudo nixos-generate-config --show-hardware-config > ./hardware-configuration.nix
```

3. Replace my user variables in `home.nix`, `flake.nix`, and
   `configuration.nix`. Update `hostName`, `i18n`, `users`, `timeZone`, to match
   your desired setup

4. Stage the new files

> [!IMPORTANT]
> Nix Flakes ignore unstaged files. Stage everything or the build won't consider
> your changes

```bash
git add .
```

5. Build & apply

> [!NOTE]
> The extra flags ensure this works even on a fresh live USB install where
> flakes aren't enabled by default

```bash
sudo nixos-rebuild switch --flake .#yourhostname --extra-experimental-features "nix-command flakes"
```
