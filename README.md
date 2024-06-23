# LitFill's PowerShell profile

## Dependencies

 1. PowerShell (ofc.)
 1. Oh My Posh (and a [nerd font](https://github.com/ryanoasis/nerd-fonts))
 1. PowerToys

### install dependencies

    winget install --id "Microsoft.PowerShell"
    winget install --id "JanDeDobbeleer.OhMyPosh"
    winget install --id "Microsoft.PowerToys"

## Usage

### Backup existing profile

backup by running this:

    $profil="$(echo $PROFILE)"
    mv $profil "$profil-backup"

### 

copy to the `$PROFILE` file:

    cp Microsoft.PowerShell_profile.ps1 "$(echo $PROFILE)"

