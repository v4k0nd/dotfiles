# Set execution policy
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

# Winget arguments
$wingetArgs = "--accept-package-agreements --accept-source-agreements"

# prompt for accepting EULA
winget list  --accept-source-agreements  # --accept-package-agreements

winget install 'Sysinternals Suite' --accept-source-agreements  # store-id: 9P7KNL5RWT25

# Essential packages
$essentialPackages = @(
    'KeePassXCTeam.KeePassXC',
    'Google.Drive',
    '7zip.7zip',
    'Microsoft.PowerShell',
    'Microsoft.WindowsTerminal',
    'Google.Chrome',
    'Mozilla.Firefox',
    'Docker.DockerDesktop',
    'VideoLAN.VLC',
    'Microsoft.PowerToys',
    'Microsoft.VisualStudioCode',
    'tailscale.tailscale',
    'WireGuard.WireGuard',
    'File-New-Project.EarTrumpet',
    'xanderfrangos.twinkletray',
    'WinSCP.WinSCP',
    'voidtools.Everything'
)

# Nice-to-have packages
$niceToHavePackages = @(
    'Discord.Discord',
    'AntibodySoftware.WizTree',
    'SublimeHQ.SublimeText.4',
    'Mozilla.Thunderbird',
    'SlackTechnologies.Slack',
    'Notion.Notion',
    'ShareX.ShareX',
    'Valve.Steam',
    'Parsec.Parsec',
    'ZeroTier.ZeroTierOne',
    'QL-Win.QuickLook',
    # 'VMware.WorkstationPro',
    'OBSProject.OBSStudio'
    'Microsoft.SysinternalsSuite'
)

# Programming packages
$programmingPackages = @(
    'MikeFarah.yq',
    'JesseDuffield.lazygit',
    'ipinfo.ipinfo'
)

# Function to install packages
function Install-Packages {
    param (
        [string[]]$packages
    )
    foreach ($package in $packages) {
        Write-Host "Installing $package..."
        Try {
            winget install $wingetArgs --id $package -e -h
            Write-Host "Installed $package successfully."
        } Catch {
            Write-Host "Failed to install $package: $_"
            Add-Content -Path install_errors.log -Value "Failed to install $package: $_"
        }
    }
}

# Install essential applications
Install-Packages -packages $essentialPackages

# Install nice-to-have applications
Install-Packages -packages $niceToHavePackages

# Install programming tools
Install-Packages -packages $programmingPackages

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

