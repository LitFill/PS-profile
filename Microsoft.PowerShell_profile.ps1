oh-my-posh init powershell | Invoke-Expression
$tanggalSekarang = Get-Date
$tanggalSekarang

# variabel untuk pesanJadwal
$kemarin = ($tanggalSekarang).AddDays(-1).ToString("ddMMyy")
$hariIni = ($tanggalSekarang).ToString("ddMMyy")
$besok = ($tanggalSekarang).AddDays(1).ToString("ddMMyy")
$namaHariIni = $tanggalSekarang.ToString("dddd")
$jam = $tanggalSekarang.Hour

# kustom cmdlet
# function Print-Hello {echo "Hello World!"}
# Menampilkan pesan sapaan ke pengguna
function Show-UserGreet {
    param (
        [String]$userName
    )
    if (-not $userName) {
        $userName = 'Fakhrur'
    }
    switch ($jam) {
        { $_ -lt 4 } { $waktu = 'malam'; break }
        { $_ -lt 11 } { $waktu = 'pagi'; break }
        { $_ -lt 16 } { $waktu = 'siang'; break }
        { $_ -lt 19 } { $waktu = 'sore'; break }
        default { $waktu = 'malam' }
    }
    Write-Output "Halo, $userName! selamat $waktu!"
}

# Mengirim pesan jadwal
function Show-PesanJadwal {
    param (
        [string]$tanggal
    )
    if (-not $tanggal) {
        $tanggal = $hariIni
    }
    node.exe .\jadwal.js --pesanWA $tanggal
}

function Show-PesanJadwalPagi {
    param (
        [string]$tanggal
    )
    if (-not $tanggal) {
        $tanggal = $hariIni
    }
    node.exe .\jadwal.js --pesanWA1 $tanggal
}

function Show-PesanJadwalSore {
    param (
        [string]$tanggal
    )
    if (-not $tanggal) {
        $tanggal = $hariIni
    }
    node.exe .\jadwal.js --pesanWA2 $tanggal
}

# Menyimpan pesan jadwal ke file teks
function Save-PesanJadwal {
    param (
        [string]$tanggal
    )
    if (-not $tanggal) {
        $tanggal = $hariIni
    }
    $outputPath = Join-Path -Path ".\prod" -ChildPath "$tanggal.txt"
    node.exe .\jadwal.js --pesanWA $tanggal | Out-File -FilePath $outputPath
}

# menyalin pesan yang akan dikirmkan
function Send-Pesan1 {
    param (
        [string]$tanggal
    )
    if (-not $tanggal) {
        $tanggal = $hariIni
    }
    Show-PesanJadwalPagi $tanggal | Set-Clipboard
    Save-PesanJadwal $tanggal
}

function Send-Pesan2 {
    param (
        [string]$tanggal
    )
    if (-not $tanggal) {
        $tanggal = $hariIni
    }
    Show-PesanJadwalSore $tanggal | Set-Clipboard
    Save-PesanJadwal $tanggal
}

function Show-JadwalGuru {
    param (
        [string]$kodeGuru,
        [string]$hari
    )
    if (-not $hari) {
        $hari = $namaHariIni
    }
    node.exe .\jadwal.js --jadwal --guru $kodeGuru --hari $hari
}

function Show-JadwalGuruFull {
    param (
        [Parameter(Mandatory = $true)]
        [string]$kodeGuru
    )
    node.exe .\jadwal.js --jadwal --guru $kodeGuru
}

function Show-Perizinan {
    param (
        [string]$data,
        [string]$tanggal
    )
    if (-not $tanggal) {
        $tanggal = $hariIni
    }
    node.exe .\jadwal.js --pesanIzin $tanggal --data $data
}

function Send-Perizinan {
    param (
        [string]$data,
        [string]$tanggal
    )
    if (-not $tanggal) {
        $tanggal = $hariIni
    }
    node.exe .\jadwal.js --pesanIzin $tanggal --data $data | Set-Clipboard
}
function matikan {
    param ( [int]$seconds )
    Write-Host "Count down begins"
    for ($i = $seconds; $i -gt 0; $i--) {
        Write-Host "$i..."
        Start-Sleep -Seconds 1
    }
    Write-Host "Shutting down...";
    Stop-Computer -ComputerName localhost
}

function restart {
    $hitung = 300;
    for ($i = $hitung; $i -gt 0; $i--) {
        Write-Host "$i..." Start-Sleep -Seconds 1
    }
    Write-Host "Restarting...";
    Restart-Computer -ComputerName localhost
}

function Merge-CSVs {
    param (
        [Parameter(Mandatory = $true)]
        [string]$path,
        [string]$filter
    )
    node.exe E:\Rozy\concatJS\index.js $path $filter
}

$AppToUpgradeId = @(
    "7zip.7zip"
    "AutoHotkey.AutoHotkey"
    "Canva.Canva"
    "DeepL.DeepL"
    "Erlang.ErlangOTP"
    "Git.Git"
    "GitHub.GitHubDesktop"
    "GitHub.cli"
    "Gleam.Gleam"
    "GoLang.Go"
    "Google.Chrome"
    "JanDeDobbeleer.OhMyPosh"
    "KDE.KDEConnect"
    "Kotatogram.Kotatogram"
    "Microsoft.OpenSSH.Beta"
    "Microsoft.PowerShell"
    "Microsoft.PowerToys"
    "Microsoft.VisualStudioCode"
    "Microsoft.WindowsTerminal"
    "Microsoft.WSL"
    "Neovim.Neovim"
    "Peppy.Osu!"
    "SoftDeluxe.FreeDownloadManager"
    "Telegram.TelegramDesktop"
    "Valve.Steam"
    "VideoLAN.VLC"
    "voidtools.Everything"
    "StephanDilly.gitui"
    "OpenJS.NodeJS.LTS"
)

function Windet {
    foreach ($app  in $AppToUpgradeId) {
        Write-Host "Upgrading $app..."
        winget.exe upgrade $app --silent --verbose
        Write-Host ""
    }
}

function Winstall {
    foreach ($app  in $AppToUpgradeId) {
        Write-Host "Installing $app..."
        winget.exe install $app --silent --verbose
        Write-Host ""
    }
}

Set-Alias -Name salam -Value Show-UserGreet -Description 'Menyapa'
Set-Alias -Name jadwalGuru -Value Show-JadwalGuru
Set-Alias -Name jadwalGuruFull -Value Show-JadwalGuruFull
Set-Alias -Name kirimPesan1 -Value Send-Pesan1
Set-Alias -Name kirimPesan2 -Value Send-Pesan2
Set-Alias -Name saveJadwal -Value Save-PesanJadwal
Set-Alias -Name izinkan -Value Send-Perizinan

$VPS_IP = "98.142.245.14"
$VPS_HOST = "ssh.litfill.site"
$VPS_PORT = "44422"

function vps {
	$sshPath = "C:\Program Files\OpenSSH\ssh.exe"
	& $sshPath "litfill@$VPS_IP" -p $VPS_PORT
}

function sshin {
    param (
        [String]$user
    )
    if (-not $user) {
        $user = 'litfill'
    }
	$sshPath = "C:\Program Files\OpenSSH\ssh.exe"
	& $sshPath "$user@$VPS_HOST" -p $VPS_PORT
}

function yank {
	param (
		[String]$user
	)
	if (-not $user) {
		$user = 'litfill'
	}
	$scpPath = "C:\Program Files\OpenSSH\scp.exe"
	& cd ~
	& $scpPath -P 44422 $user@ssh.litfill.site:/home/litfill/saluran.txt .
	& cat saluran.txt | Set-Clipboard
	& cd -
}

#f45873b3-b655-43a6-b217-97c00aa0db58 PowerToys CommandNotFound module

Import-Module -Name Microsoft.WinGet.CommandNotFound
#f45873b3-b655-43a6-b217-97c00aa0db58

