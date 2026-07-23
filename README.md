# dots

NixOS niri rice

![Static Badge](https://img.shields.io/badge/Distro-%231e1e2e?style=for-the-badge&logo=nixos&logoColor=%2374c7ec&label=NixOS&labelColor=%23181825)
![Static Badge](https://img.shields.io/badge/WM-%231e1e2e?style=for-the-badge&logo=niri&logoColor=%23fab387&label=niri&labelColor=%23181825)
![Static Badge](https://img.shields.io/badge/Terminal-%231e1e2e?style=for-the-badge&logo=ghostty&logoColor=%2374c7ec&label=Ghostty&labelColor=%23181825)
![Static Badge](https://img.shields.io/badge/Shell-%231e1e2e?style=for-the-badge&logo=fishshell&logoColor=%23a6e3a1&label=Fish&labelColor=%23181825)
![Static Badge](https://img.shields.io/badge/Editor-%231e1e2e?style=for-the-badge&logo=neovim&logoColor=%23a6e3a1&label=Neovim&labelColor=%23181825)
![Static Badge](https://img.shields.io/badge/Browser-%231e1e2e?style=for-the-badge&logo=heliumbrowser&logoColor=%2374c7ec&label=Helium&labelColor=%23181825)

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

The source files in this repository are distributed under the
[MIT License](LICENSE).
