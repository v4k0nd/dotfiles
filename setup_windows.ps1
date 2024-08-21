# prompt for accepting EULA
winget list  --accept-source-agreements  # --accept-package-agreements

# install with winget
# ESSENTIAL
winget install KeePassXCTeam.KeePassXC
winget install Google.Drive
winget install 7zip.7zip
winget install Microsoft.PowerShell
winget install Microsoft.WindowsTerminal
winget install Google.Chrome
winget install Mozilla.Firefox
winget install Docker.DockerDesktop
winget install VideoLAN.VLC
winget install Microsoft.PowerToys
winget install Microsoft.VisualStudioCode
winget install tailscale.tailscale
winget install WireGuard.WireGuard
winget install 'Sysinternals Suite' --accept-source-agreements  # store-id: 9P7KNL5RWT25
winget install File-New-Project.EarTrumpet
winget install xanderfrangos.twinkletray
winget install WinSCP.WinSCP
winget install voidtools.Everything
# NICE TO HAVE
winget install Discord.Discord
winget install AntibodySoftware.WizTree
winget install SublimeHQ.SublimeText.4
winget install Mozilla.Thunderbird
winget install SlackTechnologies.Slack
winget install Notion.Notion
winget install ShareX.ShareX
winget install Valve.Steam
winget install Parsec.Parsec
winget install ZeroTier.ZeroTierOne
winget install QL-Win.QuickLook
winget install VMware.WorkstationPro
winget install OBSProject.OBSStudio

# PROGRAMMING
winget install --id MikeFarah.yq

# DEBATING
# winget install -i Git.Git
# winget install SourceFoundry.HackFonts
# winget install gow # https://github.com/bmatzelle/gow
# winget install screentogif
# winget install sumatrapdf
# winget install coretemp
# winget install CrystalDewWorld.CrystalDiskInfo
# winget install gnupg
# winget install gpg4win
# winget install MRidgers.Clink
# winget install Neovim.Neovim
# winget install stnkl.EverythingToolbar
# winget install Microsoft.MouseandKeyboardCenter  # for overwriting default buttons

# DISTRO'S
"running:  wsl --install"
wsl --install
winget install Ubuntu --accept-source-agreements  # store-id: 9PDXGNCFSCZV

# https://github.com/nix-community/NixOS-WSL/releases
# https://github.com/LGUG2Z/nixos-wsl-starter
cd $env:USERPROFILE\Downloads
curl -LO https://github.com/nix-community/NixOS-WSL/releases/download/2405.5.4/nixos-wsl.tar.gz

Copy-Item -Path .\nixos-wsl.tar.gz -Destination $env:LOCALAPPDATA\Packages
cd $env:LOCALAPPDATA\Packages
"Run the below command to import"
"wsl --import NixOS .\NixOS\ .\nixos-wsl.tar.gz --version 2"

