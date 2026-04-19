# nix-flake

Personal flake.

## Dendritic features

### Legend

- s: [Simple Aspect](https://github.com/Doc-Steve/dendritic-design-with-flake-parts/wiki/Dendritic_Aspects#simple-aspect)
- m: [Multi Context Aspect](https://github.com/Doc-Steve/dendritic-design-with-flake-parts/wiki/Dendritic_Aspects#multi-context-aspect)
- i: [Inheritance Aspect](https://github.com/Doc-Steve/dendritic-design-with-flake-parts/wiki/Dendritic_Aspects#inheritence-aspect)
- c: [Conditional Aspect](https://github.com/Doc-Steve/dendritic-design-with-flake-parts/wiki/Dendritic_Aspects#conditional-aspect)

### Features

|      Name        | Aspects |
| ---------------- | ------- |
| `bat`            |    s    |
| `direnv`         |    s    |
| `discord`        |    s    |
| `eza`            |    s    |
| `fish`           |    s    |
| `games`          |    m    |
| `git`            |    s    |
| `kitty`          |    s    |
| `neovim`         |    s    |
| `obs-studio`     |    s    |
| `ssh`            |    s    |
| `tailscale`      |    s    |
| `tmux`           |    s    |
| `virtualisation` |    s    |
| `vscode`         |    s    |
| `yazi`           |    s    |
| `zoxdie`         |    s    |
| `flatpak`        |    s    |

### Systems

- `system-default`
- `system-desktop`
- `system-laptop`
- `system-hyprland`
- `system-hyprland-laptop`

## devShells

- `default`: devenv for developping this flake
