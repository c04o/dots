# dots

NixOS niri rice

![Static Badge](https://img.shields.io/badge/Distro-%23333c43?style=for-the-badge&logo=nixos&logoColor=%237fbbb3&label=NixOS&labelColor=%23293136)
![Static Badge](https://img.shields.io/badge/WM-%23333c43?style=for-the-badge&logo=niri&logoColor=%23e69875&label=niri&labelColor=%23293136)
![Static Badge](https://img.shields.io/badge/Terminal-%23333c43?style=for-the-badge&logo=ghostty&logoColor=%237fbbb3&label=Ghostty&labelColor=%23293136)
![Static Badge](https://img.shields.io/badge/Shell-%23333c43?style=for-the-badge&logo=fishshell&logoColor=%23a7c080&label=Fish&labelColor=%23293136)
![Static Badge](https://img.shields.io/badge/Prompt-%23333c43?style=for-the-badge&logo=starship&logoColor=%23d699b6&label=Starship&labelColor=%23293136)
![Static Badge](https://img.shields.io/badge/Bat-%23333c43?style=for-the-badge&logo=bat&logoColor=%23d699b6&labelColor=%23293136)
![Static Badge](https://img.shields.io/badge/Editor-%23333c43?style=for-the-badge&logo=neovim&logoColor=%23a7c080&label=Neovim&labelColor=%23293136)
![Static Badge](https://img.shields.io/badge/Browser-%23333c43?style=for-the-badge&logo=zen-browser&logoColor=%23e69875&label=Zen&labelColor=%23293136)

My personal dotfiles riced around the
[Everforest](https://github.com/sainnhe/everforest) dark soft variant

## Installation

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

## License

dots is licensed under the [MIT license](LICENSE)
