Move-Item -Path "$env:USERPROFILE\.config\nvim" -Destination "$env:USERPROFILE\AppData\Local\nvim"

# function that attempts to install a package if it is not already installed
# exits the program with an error if install fails
function Try-Install {
    param (
        [string]$packageName
    )

    if (Get-Command $packageName -ErrorAction SilentlyContinue) {
        Write-Host "$packageName is already installed. Skipping..."
    } else {
        Write-Host "No $packageName. Installing..."
        try {
            winget install -e --id $packageName
        } catch {
            Write-Host "Failed to install $packageName."
            Write-Host "Please manually install it and restart the script."
            exit 1
        }
        Write-Host ""
    }
}

Write-Host "------------------------------ BOOTSTRAPPER ------------------------------"
Write-Host ""

# No need to try install git, as it is required by yadm in the first place
Try-Install "cURL.cURL"
Try-Install "Neovim.Neovim"
Try-Install "BurntSushi.ripgrep.GNU"
Try-Install "sharkdp.fd"
Try-Install "sharkdp.bat"
Try-Install "wez.wezterm"
Try-Install "chrisant996.clink"

# Install scoop
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression

scoop bucket add extras
scoop install neovide

# Previously when I used packer.nvim, I'd set nvim up around here.
# However, with lazy.nvim, the plugin bootstraps itself and all of your other
# plugins when you boot up nvim for the first time. Awesome!

Write-Host "Bootstrapping complete."
Write-Host "Make sure to install a NerdFont for the best experience."
