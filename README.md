# dotfiles

Setup for:
- OS: Windows 11 + WSL2 
- on WSL:
    - Ubuntu (latest)
    - NixOS

For running `.ps1` (since it is not digitally signed, the system's PowerShell execution policy will preventing it from running), open powershell and enable for the current powershell session:
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```