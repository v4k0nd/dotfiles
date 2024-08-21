# dotfiles

Quick run on new machine the `windows` part:
```ps
iex (iwr -Uri "https://raw.githubusercontent.com/v4k0nd/dotfiles/main/setup_windows.ps1" -UseBasicParsing).Content
```

The `ubuntu` part:
```sh
bash <(curl -s https://raw.githubusercontent.com/v4k0nd/dotfiles/main/setup_ubuntu.sh)
```

Get inspired: https://dotfiles.github.io/

Setup for:
- OS: Windows 11 + WSL2 
- on WSL:
    - Ubuntu (latest)
    - NixOS

For running `.ps1` (since it is not digitally signed, the system's PowerShell execution policy will preventing it from running), open powershell and enable for the current powershell session:
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

## Windows terminal

Colors: https://windowsterminalthemes.dev/.

### Settings sync

As of march 2024, there seems to be no official way to sync the settings [link](https://github.com/microsoft/terminal/issues/2933). So I include my settings the [settings.json](./settings.json).

### Quake at startup

For quake window to work on startup, need it to run on startup. For some reason Windows Terminal still doesn't have a startup as minimized built in [link](https://github.com/microsoft/terminal/issues/9996#issuecomment-1984133049), so here's the hacky way for now:
- `ctrl + r`: `shell:startup`
- right click, new -> shortcut, `wt.exe -w _quake`
- shift right click on new shortcut, properties, set `Run: Minimised`

## WSL

### NixOS

Setup: https://github.com/LGUG2Z/nixos-wsl-starter
