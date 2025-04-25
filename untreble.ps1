# Setze die Ausgabe-Kodierung auf UTF-8
$OutputEncoding = [System.Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Hintergrundfarbe (F = Weiß)
[console]::BackgroundColor = 'White'

# Textfarbe (0 = Schwarz)
[console]::ForegroundColor = 'Black'

# Anwenden der Änderungen
Clear-Host

# LOGOS
# Untreble Logo
$Untreblelogo = {
	clear
    $logo = @(
        "██    ██ ███    ██ ████████ ██████  ███████ ██████  ██      ███████",
        "██    ██ ████   ██    ██    ██   ██ ██      ██   ██ ██      ██     ",
        "██    ██ ██ ██  ██    ██    ██████  █████   ██████  ██      █████  ",
        "██    ██ ██  ██ ██    ██    ██   ██ ██      ██   ██ ██      ██     ",
        " ██████  ██   ████    ██    ██   ██ ███████ ██████  ███████ ███████"
    )
    
    # Ausgabe des Logos mit Farben
    $logo | ForEach-Object { Write-Host $_ -ForegroundColor Magenta -BackgroundColor White }
}

# Nokia Logo
$Nokialogo = {
	clear
    $logo = @(
		"░▒▓███████▓▒░ ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓██████▓▒░ ", 
		"░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░", 
		"░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░", 
		"░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓█▓▒░▒▓████████▓▒░", 
		"░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░", 
		"░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░", 
		"░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░"
    )

    # Ausgabe des Logos mit Farben
    $logo | ForEach-Object { Write-Host $_ -ForegroundColor Magenta -BackgroundColor White }
}

# Global Variables 
# Untreble-Github-Repo

$UntrebleGithubConfig = @{
	URL = "https://github.com"
	RAWURL = "https://raw.githubusercontent.com"
	User = "Niemandausduisburg"
    Repo = "untreble"
    UpdateURL = "refs/heads"
    DownloadURL = "releases/download"
    DependenciesTag = "untreble-needed-files"
    Branch = "main"
    UpdateFile = "untreble.ps1"
	Untrebletempfile = "temp.ps1"
}

$UpdateURL = "$($UntrebleGithubConfig.RAWURL)/$($UntrebleGithubConfig.User)/$($UntrebleGithubConfig.Repo)/$($UntrebleGithubConfig.UpdateURL)/$($UntrebleGithubConfig.Branch)/$($UntrebleGithubConfig.Updatefile)"
$GithubDependenciesURL = "$($UntrebleGithubConfig.URL)/$($UntrebleGithubConfig.User)/$($UntrebleGithubConfig.Repo)/$($UntrebleGithubConfig.DownloadURL)/$($UntrebleGithubConfig.DependenciesTag)"


# Abortscript Variable
$Abortscript = {
	# Hintergrundfarbe (F = Weiß)
	[console]::BackgroundColor = 'Black'

	# Textfarbe (0 = Schwarz)
	[console]::ForegroundColor = 'White'
	
	Clear-Host; & $Cleanup; exit 1
}

# Yes/No
$YesNo = {
	Write-Host "1) Yes" -ForegroundColor Green -BackgroundColor White; Write-Host "2) No" -ForegroundColor Red -BackgroundColor White
}

# Check Windows Version
$WindowsVersion = [System.Environment]::OSVersion.Version.Major
$WindowsName = (Get-CimInstance -ClassName Win32_OperatingSystem).Caption

$CheckWindowsVersion = {
	& $Untreblelogo
	if ($WindowsVersion -in @("6", "10")) {
		Write-Host "`nYour Windows version is $WindowsName." -ForegroundColor Red -BackgroundColor White; Write-Host "`nYour Windows version is supported by Untreble :-)" -ForegroundColor Green -BackgroundColor White; Write-Host "Untreble will start now." -ForegroundColor Green -BackgroundColor White
		Start-Sleep -Seconds 5
	} else {
		Write-Host "`nYour Windows version is $WindowsName." -ForegroundColor Red -BackgroundColor White; Write-Host "`nYour Windows version is unsupprted by Untreble :-(" -ForegroundColor Red -BackgroundColor White; Write-Host "`nPlease upgrade to Windows 7 or higher." -ForegroundColor Red -BackgroundColor White; Write-Host "`nPlease report it here to get support:" -ForegroundColor Red -BackgroundColor White -NoNewline; Write-Host "https://t.me/HMD_Nokia_8" -ForegroundColor Blue -BackgroundColor White
		Start-Sleep -Seconds 10
		& $Abortscript
	}	
}

# Check PowerShell Version
$PowerShellVersion = $PSVersionTable.PSVersion.Major

$CheckPowerShellVersion = {
    & $Untreblelogo
    if ([int]$PowerShellVersion -ge 5) {
        Write-Host "`nYour PowerShell version is $PowerShellVersion.`n`nYour PowerShell version is supported by Untreble :-)" -ForegroundColor Green -BackgroundColor White; Write-Host "Untreble will start now." -ForegroundColor Green -BackgroundColor White
        Start-Sleep -Seconds 5
    }
    else {
        Write-Host "`nYour PowerShell version is $PowerShellVersion.`n`nYour PowerShell version is unsupported by Untreble :-(" -ForegroundColor Red -BackgroundColor White; Write-Host "Untreble requires PowerShell 5 or higher.`n" -ForegroundColor Red -BackgroundColor White; Write-Host "You can download PowerShell 5 here: " -ForegroundColor Red -BackgroundColor White; Write-Host "https://aka.ms/wmf5download" -ForegroundColor Blue -BackgroundColor White; Write-Host "`nOr you can try PowerShell 7.5 from here:" -ForegroundColor Red -BackgroundColor White; Write-Host "https://github.com/PowerShell/PowerShell/releases/tag/v7.5.0" -ForegroundColor Blue -BackgroundColor White; Write-Host "`nPlease report it here to get support: " -ForegroundColor Red -BackgroundColor White -NoNewline; Write-Host "https://t.me/HMD_Nokia_8" -ForegroundColor Blue -BackgroundColor White
        Start-Sleep -Seconds 10
        & $Abortscript
    }
}

#Prepare Untreble
# Ask for check for updates
$AskforcheckUpdate = {
	& $Untreblelogo
	Write-Host "`nDo you want to check for updates?" -ForegroundColor Black -BackgroundColor White
	& $YesNo
}

# Check for Update
$CheckforUpdate = {
	& $Untreblelogo
	Write-Host "`nChecking for updates" -ForegroundColor Black -BackgroundColor White; Write-Host "WindowsVersion: $WindowsVersion" -ForegroundColor Red -BackgroundColor White 
	Start-Sleep -Seconds 2
	# Use PS Invoke-WebRequest for Downlaods
	try {
		Invoke-WebRequest -Uri "$UpdateURL" -OutFile "$($UntrebleGithubConfig.Untrebletempfile)" -ErrorAction Stop
	} catch {
		Start-Sleep -Seconds 0
	}
}

# Compare Scripts
$CompareUpdate = {
	# Use Get-FileHash for getting SHA256Sums 
	$Script:Revertold = (Get-FileHash -Algorithm SHA256 -Path "$($UntrebleGithubConfig.UpdateFile)" -ErrorAction SilentlyContinue).Hash
	$Script:Revertnew = (Get-FileHash -Algorithm SHA256 -Path "$($UntrebleGithubConfig.Untrebletempfile)" -ErrorAction SilentlyContinue).Hash
}

# When no update is selected
$SelectnoUpdate = {
	& $Untreblelogo
	Write-Host "`nDon't cry when something is not working." -ForegroundColor Red -BackgroundColor White; Write-Host "Joke xD" -ForegroundColor Red -BackgroundColor White; Write-Host "When something is not working check for Updates." -ForegroundColor Red -BackgroundColor White
    Remove-Item -Force "$($UntrebleGithubConfig.Untrebletempfile)" -ErrorAction Ignore	
	Start-Sleep -Seconds 5
}

# Ask for Update
$AskforUpdate = {
	& $Untreblelogo
	Write-Host "`nUpdate found!!!" -ForegroundColor Red -BackgroundColor White; Write-Host "Do you want update?" -ForegroundColor Black -BackgroundColor White
	& $YesNo
}

# When no updated found
$Noupdatefound = {
	& $Untreblelogo	
	Write-Host "`nUntreble is already up-to-date :-)" -ForegroundColor Green -BackgroundColor White; Write-Host "`nUntreble will continue now." -ForegroundColor Black -BackgroundColor White
    Remove-Item -Force "$($UntrebleGithubConfig.Untrebletempfile)" -ErrorAction Ignore
	Start-Sleep -Seconds 5
}

# Update Untreble
$Update = {
    & $Untreblelogo
    Write-Host "`nUpdating Untreble..." -ForegroundColor Red -BackgroundColor White	
    Start-Sleep -Seconds 5
    Remove-Item -Force "$($UntrebleGithubConfig.UpdateFile)" -ErrorAction Ignore
    Rename-Item -Force "$($UntrebleGithubConfig.Untrebletempfile)" "$($UntrebleGithubConfig.UpdateFile)"
    & $AfterUpdate
    powershell.exe -NoProfile -ExecutionPolicy Bypass -File "$($UntrebleGithubConfig.UpdateFile)"
    exit 0
}

# Check architecture
$CheckArchitecture = (Get-WmiObject -Class Win32_OperatingSystem).OSArchitecture
$IsArchitecture = "64-bit"

# Wrong Architecture
$WrongArchitecture = {
	& $Untreblelogo
	Write-Host "`nWrong architecture :-(" -ForegroundColor Red -BackgroundColor White; Write-Host "Untreble is only for x86_64 (64Bit) architecture." -ForegroundColor Red -BackgroundColor White; Write-Host "" -ForegroundColor Red -BackgroundColor White; Write-Host "Untreble will be closed after 10 seconds." -ForegroundColor Red -BackgroundColor White
	Start-Sleep -Seconds 10
	& $Abortscript
}

# Check if Android-SDK-Tools are installed
# Fastboot & Adb
$Fastboot = "adb/fastboot.exe"
$ADB = "adb/adb.exe"
$FastbootChecksum = "E1B1537A9F5E73C746A96F6F2FE3461477320867A4206B7ECE138AC1AEEF5300"
$ADBChecksum = "0E606318957BAAC81B997CCD8EE4BCDFF79964A9921DA07C716AEA3E8D856AF7"


$CheckADBTools = {
	& $Untreblelogo
	# Use Get-FileHash for getting SHA256Sums 
	$Script:GetFastbootChecksum = (Get-FileHash -Algorithm SHA256 -Path $Fastboot -ErrorAction SilentlyContinue).Hash
	$Script:GetADBChecksum = (Get-FileHash -Algorithm SHA256 -Path $ADB -ErrorAction SilentlyContinue).Hash
	Write-Host "`nCheck if Android-SDK-Platform-Tools are installed." -ForegroundColor Black -BackgroundColor White
	Start-Sleep -Seconds 3
	if (($GetFastbootChecksum -eq $FastbootChecksum) -and ($GetADBChecksum -eq $ADBChecksum)) {
		$Script:Fastbootneeded = "no"
	} else {
		$Script:Fastbootneeded = "yes"
	}	
}

# Download SDK
$SDKSize = "6,39MB"
$SDKZipfile = "platform-tools_r35.0.2-windows.zip"
$SDKChecksum = "D076031AF58F4413B373E055737340528B8C0A68FA39DF62B3FBFA361D93AD87"

$SDKMessage = {
	& $Untreblelogo
	Write-Host "`nIt will download and install Android-SDK-Platform-Tools ($SDKSize)" -ForegroundColor Red -BackgroundColor White
	& $Continue
	& $YesNo
}

# Broken ADB-Tools Archive
$BrokenADBTools = {
	& $Untreblelogo
	Write-Host "`nAndroid-SDK-Platform-Tools installation package is broken :-(" -ForegroundColor Red -BackgroundColor White; Write-Host "Please download it again." -ForegroundColor Red -BackgroundColor White
	Start-Sleep -Seconds 10
	& $Abortscript
}

# Define Stockimages
$Stockimages = {
    $files = @{
        ABL         = "abl.elf"
        BOOT        = "boot.img"
        BOX         = "box.bin"
        CDA         = "cda.img"
        DSP         = "dsp.bin"
        ELABEL      = "elabel.bin"
        GPT0        = "gpt_both0.bin"
        HIDDEN      = "hidden.img"
        KEYSTORE    = "keystore.bin"
        LOGDUMP     = "logdump.bin"
        MISC        = "misc.bin"
        MODEM       = "modem.bin"
        PERSIST     = "persist.img"
        SPLASH2     = "splash2.img"
        SSD         = "ssd.bin"
        SUTINFO     = "sutinfo.img"
        SYSTEM      = "system.img"
        SYSTEMOTHER = "system_other.img"
        SYSTEMINFO  = "systeminfo.img"
        XBL         = "xbl.elf"
    }

    foreach ($key in $files.Keys) {
    $filePath = "ROM/$($files[$key])"
    Set-Variable -Name $key -Value $filePath -Scope Script
	}
}

# Get-Images
$Checkstockimages = {
    $files = @(
        "ABL", "BOOT", "BOX", "CDA", "DSP", "ELABEL", "GPT0", "HIDDEN", "KEYSTORE", "LOGDUMP",
        "MISC", "MODEM", "PERSIST", "SPLASH2", "SSD", "SUTINFO", "SYSTEM", "SYSTEMOTHER", "SYSTEMINFO", "XBL"
    )

    foreach ($name in $files) {
        $var = Get-Variable -Name $name -Scope Script -ErrorAction SilentlyContinue
        if ($var -and (Test-Path $var.Value)) {
            Set-Variable -Name ("Get" + $name) -Scope Script -Value $var.Value
        }
    }
}

# Stockimages SHA256Sums
$SHA256SUMABL = "8EAE04FFFF46431D7FA424CC32A2FA2551B0CD759A3AF6FC259F3F13F42BED36"
$SHA256SUMBOOT = "B5EFC67602CF0DFCAF7C36062D91964B4AB0F3793FEABF2483DB618FCE886473"
$SHA256SUMBOX = "ABC5B9C4BDF7199F2B15F8D217002872A014567CF64A7857858E5A9ECBD7D4A0"
$SHA256SUMCDA = "189D946139A822886DC5EE4F2ED282E3A57A673EAFBD109B3DBAA738989E199C"
$SHA256SUMDSP = "D0C8B604DD7081CF9E2D94DD5B57D99BCA99141A207791FE36901F9886DD4467"
$SHA256SUMELABEL = "080ACF35A507AC9849CFCBA47DC2AD83E01B75663A516279C8B9D243B719643E"
$SHA256SUMGPT0 = "1065C7B6D7666908EDD8A6E79F8232B343003F5C6E595A128176D87AF1F03657"
$SHA256SUMHIDDEN = "0BAF82AC193F712B6797D6D1C6FB725B19F2248C08C61167CEB4D105D6CD42BC"
$SHA256SUMKEYSTORE = "07854D2FEF297A06BA81685E660C332DE36D5D18D546927D30DAAD6D7FDA1541"
$SHA256SUMLOGDUMP = "54D46CA3AF6A0FB6315E307AA07E365C7EF12081C4C17093FA62BD600F17F302"
$SHA256SUMMISC = "30E14955EBF1352266DC2FF8067E68104607E750ABB9D3B36582B8AF909FCB58"
$SHA256SUMMODEM = "09CF1A2EC44FF5553BF486C7C960BACF398DD51DF3487F0F3C27F704514917AA"
$SHA256SUMPERSIST = "4952A421B17C1AB5BA08D7E14127809CF5047D5F7EF4321AC6F997AC2E84B0EA"
$SHA256SUMSPLASH2 = "6A4CCC7193F04860ECDB21AD031497C2EC55D66C83C307FC43CDE787A2FDE3EC"
$SHA256SUMSSD = "E1456C442369F77218FD02A0013B606063A46A3FB051D0C0CF024A171F146FB5"
$SHA256SUMSUTINFO = "478F477CC561EC49494189C1D2B4A3A8ECACA10928914915A3F67700EF5F81F2"
$SHA256SUMSYSTEM = "7E1D19F50BA24F97CB69F6E3F25EBB6F52F5426A500852AA3DFD82CD8127B85A"
$SHA256SUMSYSTEMINFO = "193DF877B5CE43D0F31AE269B72514512E515CCFD94DB7E2DDD5616E301B35BE"
$SHA256SUMSYSTEMOTHER = "0A4C4A6FB396270A35B595D9C00403B9A4B3643B8934D856109BEC661F8F7C2A"
$SHA256SUMXBL = "A5328530F2F26F556844A6B8DFCF02FED6FA3BA4B9357A55CFD474FB2C0DDF1A"

# Check SHA256SUms for Stockimages
	# Use Get-FileHash for getting SHA256Sums on Windows 10/11
	# Use certutil for getting SHA256Sums on Windows 7/8
	# Suppress error message
$StockgetSHA = {
    $files = @(
        "ABL", "BOOT", "BOX", "CDA", "DSP", "ELABEL", "GPT0", "HIDDEN", "KEYSTORE", "LOGDUMP",
        "MISC", "MODEM", "PERSIST", "SPLASH2", "SSD", "SUTINFO", "SYSTEM", "SYSTEMOTHER", "SYSTEMINFO", "XBL"
    )

    foreach ($name in $files) {
        $filePath = Get-Variable -Name $name -Scope Script -ErrorAction SilentlyContinue
        if ($filePath -and (Test-Path $filePath.Value)) {
            # SHA256-Hash berechnen
            $hash = (Get-FileHash -Algorithm SHA256 -Path $filePath.Value -ErrorAction SilentlyContinue).Hash
            # Dynamische Zuweisung der Hash-Werte
            Set-Variable -Name ("GetSHA256SUM" + $name) -Value $hash -Scope Script
        }
    }
}

# Check 7Zip Version
$Zip7ZipSHA = "707F415D7D581EDD9BCE99A0429AD4629D3BE0316C329E8B9EBD576F7AB50B71"
$Zip7ZIPPackageSHA = "80C8DDB819A6EC7EE4D71D1F8D4650F757D6B85A792AC76F22511C8BBB30BF3A"
$Zip7ZipCheckSHA = {
	if (Test-Path '7zip/7z.exe') {
		$Script:Z7ZIPcheckSHA = (Get-FileHash -Algorithm SHA256 -Path '7zip/7z.exe' -ErrorAction SilentlyContinue).Hash
	}
}

$Check7ZIP = {
	if ($Zip7ZipSHA -eq $Z7ZIPcheckSHA) {
		$Script:Zip7ZipNeeded = "no"
	} else {
		$Script:Zip7ZipNeeded = "yes"
	}
}

# Aptitude not supported
# Windows is currently thinking what is Aptitude? xD

# Broken Stock-ROM-Archive
$BrokenROMArchive = {
	& $Untreblelogo
	Write-Host "`nSeems like the Stock-ROM-archive is broken  :-(" -ForegroundColor Red -BackgroundColor White; Write-Host "Please download it again." -ForegroundColor Red -BackgroundColor White
}

# Broken 7Zip Archive
$Broken7ZArchive = {
	& $Untreblelogo
	Write-Host "`n7Zip installation package is broken :-(" -ForegroundColor Red -BackgroundColor White; Write-Host "Please download it again." -ForegroundColor Red -BackgroundColor White
}

# 7Zip Archive not able to install
$Wrong7ZIP = {
	& $Untreblelogo
	Write-Host "`nCould not install 7Zip which is required for Untreble :-(" -ForegroundColor Red -BackgroundColor White; Write-Host "Please try it again." -ForegroundColor Red -BackgroundColor White
}

# ADB-TOOLS not able to install
$WrongADBTools = {
	& $Untreblelogo
	Write-Host "`nCould not install Android-SDK-Platform-Tools which are required for Untreble :-(" -ForegroundColor Red -BackgroundColor White; Write-Host "Please try it again." -ForegroundColor Red -BackgroundColor White
	Start-Sleep -Seconds 10
	& $Abortscript
}

# All Stock-ROM files are existing
$AllStockfilesExist = {
	& $Untreblelogo
	Write-Host "`nAll files from Stock-ROM are exist :-)" -ForegroundColor Green -BackgroundColor White; Write-Host "We can continue." -ForegroundColor Green -BackgroundColor White
}

# Some Files are missing after extract Stock-ROM Package
$AllStockfilesdontExist = {
	& $Untreblelogo
	Write-Host "`nSome files from Stock-Rom are missing :-(" -ForegroundColor Red -BackgroundColor White; Write-Host "Please delete the ROM folder and try it again." -ForegroundColor Red -BackgroundColor White
}

# Broken files in Stock-ROM
$BrokenStock = {
	& $Untreblelogo
	Write-Host "`nSeems like some files from Stock-ROM are broken :-(" -ForegroundColor Red -BackgroundColor White; Write-Host "Please delete the ROM folder and download the package again." -ForegroundColor Red -BackgroundColor White
}

# All files in Stock-ROM are fine
$GoodStock = {
	& $Untreblelogo
	Write-Host "`nAll files from Stock-ROM are fine :-)" -ForegroundColor Green -BackgroundColor White; Write-Host "We can continue." -ForegroundColor Green -BackgroundColor White
}

# GPT0 found
$GPT0Exist = {
	& $Untreblelogo
	Write-Host "`nGPT-Table exist :-)" -ForegroundColor Green -BackgroundColor White; Write-Host "We can continue." -ForegroundColor Green -BackgroundColor White
}

# GPT0 missing
$GPT0dontExist = {
	& $Untreblelogo
	Write-Host "`nGPT-Table was not found :-(" -ForegroundColor Red -BackgroundColor White; Write-Host "Please delete the ROM folder and try it again." -ForegroundColor Red -BackgroundColor White
}

# Good GPT-Table
$GoodGPT = {
	& $Untreblelogo
	Write-Host "`nGPT-Table is fine:-)" -ForegroundColor Green -BackgroundColor White; Write-Host "We can continue." -ForegroundColor Green -BackgroundColor White
}

# Broken GPT-Table
$BrokenGPT = {
	& $Untreblelogo
	Write-Host "`nSeems like GPT-Table is broken :-(" -ForegroundColor Red -BackgroundColor White; Write-Host "Please remove gpt_both0.bin in ROM folder and download it again." -ForegroundColor Red -BackgroundColor White
}

# SDK missing
$NoSDK = {
	& $Untreblelogo
	Write-Host "`nAndroid-SDK-Platform-Tools were not found or are outdated :-( " -ForegroundColor Red -BackgroundColor White; Write-Host "They are required to use Untreble." -ForegroundColor Red -BackgroundColor White; Write-Host "" -ForegroundColor Black -BackgroundColor White; Write-Host "Do you want to download and install them?" -ForegroundColor Black -BackgroundColor White
	& $YesNo
}

# Download 7Zip
# Ask for Download 7Zip 
$ZIP7ZIP = "7z-24.08_Windows.zip"
$Size7ZIP = "2,41MB"
$Version7ZIP = "23.01"

$Download7ZIPMessage = {
	& $Untreblelogo
	Write-Host "`n7Zip not found or wrong version :-(" -ForegroundColor Red -BackgroundColor White; Write-Host "" -ForegroundColor Red -BackgroundColor White; Write-Host "It is required to unpack the stock ROM." -ForegroundColor Red -BackgroundColor White; Write-Host "" -ForegroundColor Black -BackgroundColor White; Write-Host "Do you want to download and install 7Zip $Version7ZIP ($Size7ZIP)?" -ForegroundColor Black -BackgroundColor White
	& $YesNo
}

# Continue?
$Continue = {
	Write-Host "Do you want to continue?" -ForegroundColor Black -BackgroundColor White
}

# Main Menu
$MainMenu = {
	& $Untreblelogo
	Write-Host "`nSelect an option what you want:" -ForegroundColor Black -BackgroundColor White
}
	
# Main Menu - Option 1
$Option1 = {
	Write-Host "1)Going back to Stock-ROM (Android 9 - 516A)" -ForegroundColor Green -BackgroundColor White
}	

# Main Menu - Option 2
$Option2 = {
	Write-Host "2)Only restore Stock-Partition-Table (For flashing with NOST/OST LA/OSTRemote)" -ForegroundColor DarkYellow -BackgroundColor White
}

# Download Stock-Rom
$StockromSize = "1,48GB"
$SHA256SUMStockRom = "371D7C8555064E1D00936C5EA605979EB1547B87C42D43EB959328C75A3D06A7"
$DownloadStockROMMessage = {
	& $Untreblelogo
	Write-Host "`nIt will download the Stock-ROM ($StockromSize)" -ForegroundColor Red -BackgroundColor White; Write-Host "" -ForegroundColor Black -BackgroundColor White
	& $Continue
	& $YesNo
}

# Download GPT-Table
$GPT0Size = "44kb"
$DownloadGPT0Message = {
	& $Untreblelogo
	Write-Host "`nIt will download the Stock-GPT-Table ($GPT0Size)" -ForegroundColor Red -BackgroundColor White; Write-Host "" -ForegroundColor Black -BackgroundColor White
	& $Continue
	& $YesNo
}
	
# Flashing
# Get Serial Number
$GetSerialNo = {
	$serialOutput = & $Fastboot getvar serialno 2>&1  

	$serialLine = $serialOutput | Select-String "serialno:"

	if ($serialLine -match "serialno:\s*(\S+)") {
		$Script:Serial = $matches[1]  # Seriennummer extrahieren
	}
}

# Check if device is a NB1
$CheckDevice = {
	if ($Serial -like "NB1*") {
		& $DeviceisNB1
	} else {
		& $DeviceisnotNB1
	}
}

# Device is NB1
$DeviceisNB1 = {
	& $Untreblelogo
	Write-Host "`nDevice is a NB1" -ForegroundColor Green -BackgroundColor White; Write-Host "We can continue :-)" -ForegroundColor Green -BackgroundColor White
	Start-Sleep -Seconds 5
}

# Device is not NB1
$DeviceisnotNB1 = {
	& $Untreblelogo
	Write-Host "`nDevice is not a NB1" -ForegroundColor Red -BackgroundColor White; Write-Host "We can''t continue :-(" -ForegroundColor Red -BackgroundColor White; Write-Host "" -ForegroundColor Red -BackgroundColor White; Write-Host "Script will be closed now." -ForegroundColor Red -BackgroundColor White
	Start-Sleep -Seconds 10
	& $Abortscript
}

# Check if Bootloader is unlocked
$Bootloaderunlock = {
	$unlockOutput = & $FASTBOOT -s $SERIAL oem device-info 2>&1
    $unlockLine = $unlockOutput | Select-String "Device unlocked:"

    if ($unlockLine -match "Device unlocked:\s*(true|false)") {
        $Script:CheckBootloaderunlock = $matches[1]  # Speichert "true" oder "false"
    }
	
	if ($CheckBootloaderunlock -eq $Unlocked) {
		& $Untreblelogo
		& $BootloaderunlockMessage
		Start-Sleep -Seconds 2
		Write-Host "Bootloader is unlocked :-)" -ForegroundColor Green -BackgroundColor White
		Start-Sleep -Seconds 3
	} elseif ($CheckBootloaderunlock -eq $Locked) {
		& $Untreblelogo
		& $BootloaderunlockMessage
		Start-Sleep -Seconds 2
		Write-Host "Bootloader is locked :-(" -ForegroundColor Red -BackgroundColor White
		Start-Sleep -Seconds 3
		& $Abortscript
	}
}

# Check if Bootloader is critical 
$Bootloadercriticalunlock = {
	$unlockCriticalOutput = & $FASTBOOT -s $SERIAL oem device-info 2>&1
    $unlockCriticalLine = $unlockCriticalOutput | Select-String "Device critical unlocked:"

    if ($unlockCriticalLine -match "Device critical unlocked:\s*(true|false)") {
        $Script:CheckBootloaderCriticalunlock = $matches[1]  # Speichert "true" oder "false"
    }
	
	if ($CheckBootloaderCriticalunlock -eq $Unlocked) {
		& $Untreblelogo
		& $BootloadercriticalunlockMessage
		Start-Sleep -Seconds 2
		Write-Host "Bootloader is unlocked :-)" -ForegroundColor Green -BackgroundColor White
		Start-Sleep -Seconds 3
		$Script:Unlocked = "yes"
	} elseif ($CheckBootloaderCriticalunlock -eq $Locked) {
		& $Untreblelogo
		& $BootloadercriticalunlockMessage
		Start-Sleep -Seconds 2
		Write-Host "Bootloader is locked :-(" -ForegroundColor Red -BackgroundColor White
		Start-Sleep -Seconds 3
		& $Abortscript
	}
}

# Bootloader state
$Unlocked = "true"
$Locked = "false"

# Flash bootloader
$Flashbootloader = {
	& $Untreblelogo
	Write-Host "`nFlashing bootloader:" -ForegroundColor Black -BackgroundColor White
	Start-Sleep -Seconds 2
	& $Fastboot -s $Serial flash abl_a $ABL
	& $Fastboot -s $Serial flash abl_b $ABL
	& $Fastboot -s $Serial flash xbl_a $XBL
	& $Fastboot -s $Serial flash xbl_b $XBL
}

# Flash Stock-Images
$FlashStockImages = {
	& $Untreblelogo
	Write-Host "`nFlashing Stock ROM::" -ForegroundColor Black -BackgroundColor White
	Start-Sleep -Seconds 2
	& $Fastboot -s $Serial flash boot_a $BOOT
	& $Fastboot -s $Serial flash boot_b $BOOT	
	& $Fastboot -s $Serial flash box $BOX
	& $Fastboot -s $Serial flash cda_a $CDA
	& $Fastboot -s $Serial flash cda_b $CDA
	& $Fastboot -s $Serial flash dsp_a $DSP
	& $Fastboot -s $Serial flash dsp_b $DSP
	& $Fastboot -s $Serial flash elabel $ELABEL
	& $Fastboot -s $Serial flash hidden_a $HIDDEN
	& $Fastboot -s $Serial flash hidden_b $HIDDEN
	& $Fastboot -s $Serial flash keystore $KEYSTORE
	& $Fastboot -s $Serial flash logdump $LOGDUMP
	& $Fastboot -s $Serial flash misc $MISC
	& $Fastboot -s $Serial flash modem_a $MODEM
	& $Fastboot -s $Serial flash modem_b $MODEM
	& $Fastboot -s $Serial flash persist $PERSIST
	& $Fastboot -s $Serial flash splash2 $SPLASH2
	& $Fastboot -s $Serial flash ssd $SSD
	& $Fastboot -s $Serial flash sutinfo $SUTINFO
	& $Fastboot -s $Serial flash system_a $SYSTEM
	& $Fastboot -s $Serial flash system_b $SYSTEMOTHER
	& $Fastboot -s $Serial flash systeminfo_a $SYSTEMINFO
	& $Fastboot -s $Serial flash systeminfo_b $SYSTEMINFO
}

# Set boot-slot
$SetBootSlot = {
	& $Untreblelogo
	Write-Host "`nSwitching to Slot A:" -ForegroundColor Red -BackgroundColor White
	Start-Sleep -Seconds 2
	& $Fastboot -s $Serial --set-active=a
}	

# Erase Userdata
$EraseUserdata = {
	& $Untreblelogo
	Write-Host "`nErasing Userdata:" -ForegroundColor Red -BackgroundColor White
	Start-Sleep -Seconds 2
	& $Fastboot -s $Serial -w
}	

# Reboot to bootloader
$Reboot_Bootloader = {
	& $Untreblelogo
	Write-Host "`nRebooting device into download mode. DO NOT disconnect your device!" -ForegroundColor Red -BackgroundColor White
	& $Fastboot -s $Serial reboot bootloader
	Start-Sleep -Seconds 5
}	

# Reboot to system
$Reboot_System = {
	& $Untreblelogo
	Write-Host "`nRebooting device into system. DO NOT disconnect your device!'" -ForegroundColor Red -BackgroundColor White
	& $Fastboot -s $Serial reboot
	Start-Sleep -Seconds 5
}	

# Flash GPT-Table
$FlashGPT = {
	& $Untreblelogo
	Write-Host "`nFlashing stock partition-table:" -ForegroundColor Black -BackgroundColor White
	Start-Sleep -Seconds 2
	& $Fastboot -s $Serial flash partition:0 $GPT0
}

# Check if Bootloader is unlocked message
$BootloaderunlockMessage = {
	Write-Host "`nCheck if bootloader is unlocked:`n" -ForegroundColor Black -BackgroundColor White
}

# Check if Bootloader is critical unlocked message
$BootloadercriticalunlockMessage = {
	Write-Host "`nCheck if bootloader is critical unlocked:`n" -ForegroundColor Black -BackgroundColor White
}

# Welcome Screen
$WelcomeScreen = {
	if ($FLASHMODE -eq "Stock") {
		& $Untreblelogo
		Write-Host "`nThis will flash the Nokia stock ROM (Android 9 / 516A) on your device." -ForegroundColor Black -BackgroundColor White
		Start-sleep -Seconds 5
	} elseif ($FLASHMODE -eq "GPT")	{
		& $Untreblelogo		
		Write-Host "`nThis will flash the Nokia stock GPT-Table for you for flasing your device with NOST, OST LA, OSTRemote." -ForegroundColor Black -BackgroundColor White
		Start-sleep -Seconds 5		
	}	
}

# Warning Screen 1
$WarningScreen1 = {
	if ($FLASHMODE -eq "Stock" -or $FLASHMODE -eq "GPT") {
		& $Untreblelogo
		Write-Host "`nWARNING!" -ForegroundColor Red -BackgroundColor White; Write-Host "MAKE A BACKUP FROM YOUR DATA!" -ForegroundColor Red -BackgroundColor White; Write-Host "ALL DATA WILL BE LOST AFTER FLASHING (FACTORY RESET)!" -ForegroundColor Red -BackgroundColor White; Write-Host "WE ACCEPT NO LIABILITY IF YOU LOSE DATA OR USE THIS TOOL INCORRECTLY!" -ForegroundColor Red -BackgroundColor White
		Start-sleep -Seconds 10
	}
}

# Warning Screen 2
$WarningScreen2 = {
	if ($FLASHMODE -eq "Stock") {
		& $Untreblelogo		
		Write-Host "`nWARNING!" -ForegroundColor Red -BackgroundColor White; Write-Host "FLASHING SOME PARTITIONS CAN TAKE SOME TIME (ABOUT 5 MINUTES)." -ForegroundColor Red -BackgroundColor White; Write-Host "DO NOT UNPLUG THE USB-CABLE OR CLOSE POWERSHELL OR YOU WILL BRICK YOUR DEVICE!!!" -ForegroundColor Red -BackgroundColor White; Write-Host "SOMETIMES POWERSHELL SEEMS TO BE FREZZING. DO NOT ABORT THE PROCESS AND STILL WAITING UNTIL THE PROCESS IS DONE." -ForegroundColor Red -BackgroundColor White
		Start-sleep -Seconds 10
	}
}

# Ask for flash Stock
$AskforStock = {
	& $Untreblelogo		
	Write-Host "`nAre you sure you want to flash Stock ROM?" -ForegroundColor Black -BackgroundColor White
}

# Ask for flash GPT
$AskforGPT = {
	& $Untreblelogo		
	Write-Host "`nAre you sure you want to flash the stock GPT-Table?" -ForegroundColor Black -BackgroundColor White
}	

# Ask for sure flash
$Flashsure = {
	& $Untreblelogo		
	Write-Host "`nHave you read and understand the warnings and are you sure you want to proceed?" -ForegroundColor Black -BackgroundColor White
}	

# Instruction
$Instruction = {
	& $Untreblelogo		
	Write-Host "`nBoot your device into download-mode (Vol- & Plug-in USB-cable) and connect it to your PC." -ForegroundColor Black -BackgroundColor White; Write-Host "Be sure your device is recognized correctly." -ForegroundColor Black -BackgroundColor White; Write-Host "Enter " -ForegroundColor Black -BackgroundColor White -NoNewline; Write-Host "[f] " -ForegroundColor Red -BackgroundColor White -NoNewline; Write-Host "when your device is in download-mode and connected to your PC to proceed." -ForegroundColor Black -BackgroundColor White
}

# Last warning
$LastWarning = {
	if ($FlashMode -eq "Stock") {
		& $Untreblelogo		
		Write-Host "`nATTENTION!!!" -ForegroundColor Red -BackgroundColor White; Write-Host "THE WHOLE FLASHING PROCESS CAN TAKE UP TO 10 MINUTES." -ForegroundColor Red -BackgroundColor White; Write-Host "LEAN BACK AND LET IT FLASHING." -ForegroundColor Red -BackgroundColor White
		Start-Sleep -Seconds 10
		& $Untreblelogo
		Write-Host "`nLet's flash and revert back to Stock-ROM :-)" -ForegroundColor Black -BackgroundColor White
		Start-Sleep -Seconds 5	
	} elseif ($FlashMode -eq "GPT") {
		& $Untreblelogo		
		Write-Host "`nLet's flash and revert back to Stock-GPT-Table :-)" -ForegroundColor Black -BackgroundColor White
		Start-Sleep -Seconds 5	
	}
}

# Well done
$WellDone = {
	& $Untreblelogo		
	Write-Host "`nWell done xD" -ForegroundColor Green -BackgroundColor White
	Start-Sleep -Seconds 5
}
	
# Finish flash Stock-ROM
$FinishStock = {
	& $Nokialogo
	Write-Host "`nYou are back to Stock ROM successfully." -ForegroundColor Green -BackgroundColor White; Write-Host "Your device will boot into the ROM now." -ForegroundColor Green -BackgroundColor White; Write-Host "Enjoy your time travel to the ancient times xD" -ForegroundColor Green -BackgroundColor White; Write-Host "" -ForegroundColor Green -BackgroundColor White; Write-Host "You can unplug your device now :-)" -ForegroundColor Green -BackgroundColor White
	Start-Sleep -Seconds 10
	clear
	# Hintergrundfarbe (F = Weiß)
	[console]::BackgroundColor = 'Black'
	# Textfarbe (0 = Schwarz)
	[console]::ForegroundColor = 'White'
	# Anwenden der Änderungen
	Clear-Host
	& $Cleanup;	exit 0
}
	
# Finish flash GPT-Table
$FinishGPT = {
	& $Untreblelogo
	Write-Host "`nPartition-Table successfully flashed :-)" -ForegroundColor Green -BackgroundColor White; Write-Host "`nYou need to flash a Stock-Firmware with NOST or OST LA to boot your device!!!" -ForegroundColor Red -BackgroundColor White; Write-Host "I don't recommend using OSTRemote or it will brick your device :-(" -ForegroundColor Red -BackgroundColor White
	Start-Sleep -Seconds 10
	clear
	# Hintergrundfarbe (F = Weiß)
	[console]::BackgroundColor = 'Black'
	# Textfarbe (0 = Schwarz)
	[console]::ForegroundColor = 'White'
	# Anwenden der Änderungen
	Clear-Host
	& $Cleanup;	exit 0
}

# After Update
$AfterUpdate = {
    & $Untreblelogo		
	Write-Host "`nUpdate successfully :-)" -ForegroundColor Green -BackgroundColor White
	Write-Host "`nUntreble will restart now." -ForegroundColor Black -BackgroundColor White	
	Start-Sleep -Seconds 5
}
	
# Remove Sub-Scripts & reset variables
$Cleanup = {
	Remove-Variable -Name "ABL" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "ADB" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "Abortscript" -ErrorAction Ignore
	Remove-Variable -Name "AfterUpdate" -ErrorAction Ignore
	Remove-Variable -Name "AllStockfilesdontExist" -ErrorAction Ignore
	Remove-Variable -Name "AskforGPT" -ErrorAction Ignore
	Remove-Variable -Name "AskforStock" -ErrorAction Ignore
	Remove-Variable -Name "AskforUpdate" -ErrorAction Ignore
	Remove-Variable -Name "AskforcheckUpdate" -ErrorAction Ignore
	Remove-Variable -Name "AskusertoUpdate" -ErrorAction Ignore
	Remove-Variable -Name "Askusertosearchupdate" -ErrorAction Ignore
	Remove-Variable -Name "BOOT" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "BOX" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "Bootloadercriticalunlock" -ErrorAction Ignore
	Remove-Variable -Name "BootloadercriticalunlockMessage" -ErrorAction Ignore
	Remove-Variable -Name "Bootloaderunlock" -ErrorAction Ignore
	Remove-Variable -Name "BootloaderunlockMessage" -ErrorAction Ignore	
	Remove-Variable -Name "Broken7ZArchive" -ErrorAction Ignore	
	Remove-Variable -Name "BrokenADBTools" -ErrorAction Ignore	
	Remove-Variable -Name "BrokenGPT" -ErrorAction Ignore	
	Remove-Variable -Name "BrokenROMArchive" -ErrorAction Ignore	
	Remove-Variable -Name "BrokenStock" -ErrorAction Ignore	
	Remove-Variable -Name "CDA" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "CheckADBTools" -ErrorAction Ignore
	Remove-Variable -Name "CheckArchitecture" -ErrorAction Ignore	
	Remove-Variable -Name "CheckDevice" -ErrorAction Ignore	
	Remove-Variable -Name "CheckPowerShellVersion" -ErrorAction Ignore
	Remove-Variable -Name "CheckWindowsVersion" -ErrorAction Ignore
	Remove-Variable -Name "CheckforUpdate" -ErrorAction Ignore	
	Remove-Variable -Name "Checkstockimages" -ErrorAction Ignore	
	Remove-Variable -Name "Checksum" -ErrorAction Ignore	
	Remove-Variable -Name "Cleanup" -ErrorAction Ignore	
	Remove-Variable -Name "CompareUpdate" -ErrorAction Ignore	
	Remove-Variable -Name "Continue" -ErrorAction Ignore	
	Remove-Variable -Name "DSP" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "DeviceisNB1" -ErrorAction Ignore	
	Remove-Variable -Name "DeviceisnotNB1" -ErrorAction Ignore	
	Remove-Variable -Name "Download7ZIPMessage" -ErrorAction Ignore	
	Remove-Variable -Name "DownloadGPT0Message" -ErrorAction Ignore	
	Remove-Variable -Name "DownloadStockROMMessage" -ErrorAction Ignore	
	Remove-Variable -Name "ELABEL" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "EraseUserdata" -ErrorAction Ignore	
	Remove-Variable -Name "Fastboot" -ErrorAction Ignore	
	Remove-Variable -Name "Fastbootneeded" -ErrorAction Ignore
	Remove-Variable -Name "Fastbootneeded" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "FinishGPT" -ErrorAction Ignore	
	Remove-Variable -Name "FinishStock" -ErrorAction Ignore	
	Remove-Variable -Name "FlashGPT" -ErrorAction Ignore	
	Remove-Variable -Name "FlashMode" -ErrorAction Ignore	
	Remove-Variable -Name "FlashStockImages" -ErrorAction Ignore	
	Remove-Variable -Name "Flashbootloader" -ErrorAction Ignore	
	Remove-Variable -Name "Flashready" -ErrorAction Ignore	
	Remove-Variable -Name "Flashsure" -ErrorAction Ignore	
	Remove-Variable -Name "GPT0" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GPT0DownloadQuestion" -ErrorAction Ignore
	Remove-Variable -Name "GPT0Exist" -ErrorAction Ignore
	Remove-Variable -Name "GPT0Size" -ErrorAction Ignore
	Remove-Variable -Name "GPT0dontExist" -ErrorAction Ignore
	Remove-Variable -Name "GetABL" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetBOOT" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetBOX" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetCDA" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetDSP" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetELABEL" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetGPT0" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetGPTSTOCK" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetHIDDEN" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetKEYSTORE" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetLOGDUMP" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetMISC" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetMODEM" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetPERSIST" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetSDKChecksum" -ErrorAction Ignore
	Remove-Variable -Name "GetSHA256SUMABL" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetSHA256SUMBOOT" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetSHA256SUMBOX" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetSHA256SUMCDA" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetSHA256SUMDSP" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetSHA256SUMELABEL" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetSHA256SUMGPT0" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetSHA256SUMHIDDEN" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetSHA256SUMKEYSTORE" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetSHA256SUMLOGDUMP" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetSHA256SUMMISC" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetSHA256SUMMODEM" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetSHA256SUMPERSIST" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetSHA256SUMSPLASH2" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetSHA256SUMSSD" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetSHA256SUMSUTINFO" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetSHA256SUMSYSTEM" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetSHA256SUMSYSTEMINFO" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetSHA256SUMSYSTEMOTHER" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetSHA256SUMXBL" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetSPLASH2" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetSSD" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetSUTINFO" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetSYSTEM" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetSYSTEMINFO" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetSYSTEMOTHER" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GetXBL" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "GoodGPT" -ErrorAction Ignore	
	Remove-Variable -Name "GoodStock" -ErrorAction Ignore	
	Remove-Variable -Name "HIDDEN" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "Instruction" -ErrorAction Ignore	
	Remove-Variable -Name "IsArchitecture" -ErrorAction Ignore	
	Remove-Variable -Name "KEYSTORE" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "LOGDUMP" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "LastWarning" -ErrorAction Ignore
	Remove-Variable -Name "Locked" -ErrorAction Ignore
	Remove-Variable -Name "MISC" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "MODEM" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "MainMenu" -ErrorAction Ignore	
	Remove-Variable -Name "NoSDK" -ErrorAction Ignore	
	Remove-Variable -Name "Nokialogo" -ErrorAction Ignore	
	Remove-Variable -Name "Noupdatefound" -ErrorAction Ignore	
	Remove-Variable -Name "Option1" -ErrorAction Ignore	
	Remove-Variable -Name "Option2" -ErrorAction Ignore	
	Remove-Variable -Name "Optionselect" -ErrorAction Ignore
	Remove-Variable -Name "PERSIST" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "PowerShellVersion" -ErrorAction Ignore
	Remove-Variable -Name "Reboot_Bootloader" -ErrorAction Ignore	
	Remove-Variable -Name "Reboot_System" -ErrorAction Ignore	
	Remove-Variable -Name "Revertnew" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "Revertold" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "SDKChecksum" -ErrorAction Ignore
	Remove-Variable -Name "SDKChoice" -ErrorAction Ignore
	Remove-Variable -Name "SDKMessage" -ErrorAction Ignore	
	Remove-Variable -Name "SDKSize" -ErrorAction Ignore	
	Remove-Variable -Name "SDKZipfile" -ErrorAction Ignore	
	Remove-Variable -Name "SHA256SUMABL" -ErrorAction Ignore
	Remove-Variable -Name "SHA256SUMBOOT" -ErrorAction Ignore
	Remove-Variable -Name "SHA256SUMBOX" -ErrorAction Ignore
	Remove-Variable -Name "SHA256SUMCDA" -ErrorAction Ignore
	Remove-Variable -Name "SHA256SUMDSP" -ErrorAction Ignore
	Remove-Variable -Name "SHA256SUMELABEL" -ErrorAction Ignore
	Remove-Variable -Name "SHA256SUMGPT0" -ErrorAction Ignore
	Remove-Variable -Name "SHA256SUMHIDDEN" -ErrorAction Ignore
	Remove-Variable -Name "SHA256SUMKEYSTORE" -ErrorAction Ignore
	Remove-Variable -Name "SHA256SUMLOGDUMP" -ErrorAction Ignore
	Remove-Variable -Name "SHA256SUMMISC" -ErrorAction Ignore
	Remove-Variable -Name "SHA256SUMMODEM" -ErrorAction Ignore
	Remove-Variable -Name "SHA256SUMPERSIST" -ErrorAction Ignore
	Remove-Variable -Name "SHA256SUMSPLASH2" -ErrorAction Ignore
	Remove-Variable -Name "SHA256SUMSSD" -ErrorAction Ignore
	Remove-Variable -Name "SHA256SUMSUTINFO" -ErrorAction Ignore
	Remove-Variable -Name "SHA256SUMSYSTEM" -ErrorAction Ignore
	Remove-Variable -Name "SHA256SUMSYSTEMINFO" -ErrorAction Ignore
	Remove-Variable -Name "SHA256SUMSYSTEMOTHER" -ErrorAction Ignore		
	Remove-Variable -Name "SHA256SUMStockRom" -ErrorAction Ignore
	Remove-Variable -Name "SHA256SUMXBL" -ErrorAction Ignore
	Remove-Variable -Name "SPLASH2" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "SSD" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "SUTINFO" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "SYSTEM" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "SYSTEMINFO" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "SYSTEMOTHER" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "SearcedforUpdate" -ErrorAction Ignore
	Remove-Variable -Name "SelectnoUpdate" -ErrorAction Ignore
	Remove-Variable -Name "Serial" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "SetBootSlot" -ErrorAction Ignore	
	Remove-Variable -Name "Size7ZIP" -ErrorAction Ignore
	Remove-Variable -Name "StockDowloadQuestion" -ErrorAction Ignore
	Remove-Variable -Name "StockgetSHA" -ErrorAction Ignore
	Remove-Variable -Name "Stockimages" -ErrorAction Ignore
	Remove-Variable -Name "StockromSize" -ErrorAction Ignore
	Remove-Variable -Name "Unlocked" -ErrorAction Ignore
	Remove-Variable -Name "Unlocked" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "UntrebleGithubConfig" -ErrorAction Ignore	
	Remove-Variable -Name "Untreblelogo" -ErrorAction Ignore	
	Remove-Variable -Name "Update" -ErrorAction Ignore
	Remove-Variable -Name "Version7ZIP" -ErrorAction Ignore
	Remove-Variable -Name "WarningScreen1" -ErrorAction Ignore
	Remove-Variable -Name "WarningScreen2" -ErrorAction Ignore
	Remove-Variable -Name "WelcomeScreen" -ErrorAction Ignore
	Remove-Variable -Name "WellDone" -ErrorAction Ignore
	Remove-Variable -Name "WindowsName" -ErrorAction Ignore
	Remove-Variable -Name "WindowsVersion" -ErrorAction Ignore
	Remove-Variable -Name "WindowsVersion" -ErrorAction Ignore
	Remove-Variable -Name "Wrong7ZIP" -ErrorAction Ignore
	Remove-Variable -Name "WrongADBTools" -ErrorAction Ignore
	Remove-Variable -Name "WrongArchitecture" -ErrorAction Ignore
	Remove-Variable -Name "XBL" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "YesNo" -ErrorAction Ignore
	Remove-Variable -Name "Z7ZIPcheckSHA" -Scope Script -ErrorAction Ignore
	Remove-Variable -Name "ZIP7ZIP" -ErrorAction Ignore
	Remove-Variable -Name "Zip7ZipCheckSHA" -ErrorAction Ignore
	Remove-Variable -Name "Zip7ZipNeeded" -ErrorAction Ignore
	Remove-Variable -Name "Zip7ZipSHA" -ErrorAction Ignore
	Remove-Variable -Name "Zipdownloadquestion" -ErrorAction Ignore
	Remove-Variable -Name "logo" -ErrorAction Ignore	
    Remove-Variable -Name "AllStockfilesExist" -ErrorAction Ignore	
    Remove-Variable -Name "AskROMGPT" -ErrorAction Ignore
    Remove-Variable -Name "Askflashsure" -ErrorAction Ignore
    Remove-Variable -Name "Proceedflash" -ErrorAction Ignore
}

#-------------------------------------------------------------------------------------------------------------------------------------	
# Start Untreble
# Prepare Untreble

# Check Windows Version
& $CheckWindowsVersion

# Check PowerShell Version
& $CheckPowerShellVersion

# Ask for checking for Update
& $AskforcheckUpdate

# User input. Wait for 1 or 2
do {
    $Askusertosearchupdate = [System.Console]::ReadKey($true).KeyChar
} until (($Askusertosearchupdate -eq "1") -or ($Askusertosearchupdate -eq "2"))

if ($Askusertosearchupdate -eq "1") {
# Check for Update
    & $CheckforUpdate
    & $CompareUpdate
    $SearcedforUpdate = "1"
} elseif ($Askusertosearchupdate -eq "2") {
# Don't check for Update	
    & $SelectnoUpdate
}

# Ask for Update when availible
if ($SearcedforUpdate -eq "1" ) {
	if ($Revertold -ne $Revertnew) {
		& $AskforUpdate
		do {
			$AskusertoUpdate = [System.Console]::ReadKey($true).KeyChar
		} until (($AskusertoUpdate -eq "1") -or ($AskusertoUpdate -eq "2"))
	} elseif ($Revertold -eq $Revertnew) {
		& $Noupdatefound
	}
}	

# Update Untreble
if ($AskusertoUpdate -eq "1") {
	& $Update
} elseif ($AskusertoUpdate -eq "2") {
	& $SelectnoUpdate
}

# Check architecture for 64-Bit
if ($CheckArchitecture -eq $IsArchitecture) {
	Start-Sleep -Seconds 0	
} elseif ($CheckArchitecture -ne $IsArchitecture) {
	& $WrongArchitecture
}

# Check if Android-SDK-Platform-Tools are installed
& $CheckADBTools

if ($Fastbootneeded -eq "yes") {
	& $NoSDK
	do {
		$SDKChoice = [System.Console]::ReadKey($true).KeyChar
	} until (($SDKChoice -eq "1") -or ($SDKChoice -eq "2"))
}

# Asking for downloading ADB-Tools
if ($Fastbootneeded -eq "yes") {
	if ($SDKChoice -eq "1") {
		& $SDKMessage
		do {
			$SDKDownloadChoice = [System.Console]::ReadKey($true).KeyChar
		} until (($SDKDownloadChoice -eq "1") -or ($SDKDownloadChoice -eq "2"))
	} elseif ($SDKChoice -eq "2") {
		& $Abortscript
	}
}

# Download ADB-TOOLS
if ($Fastbootneeded -eq "yes") {
	if ($SDKChoice -eq "1") {
		if ($SDKDownloadChoice -eq "1") {
			& $Untreblelogo
			Invoke-WebRequest -Uri "$GithubDependenciesURL/$SDKZipfile" -OutFile "$SDKZipfile" -ErrorAction Stop
			$GetSDKChecksum = (Get-FileHash -Algorithm SHA256 -Path $SDKZipfile -ErrorAction SilentlyContinue).Hash
		} elseif ($SDKDownloadChoice -eq "2") {
			& $Abortscript
		}
	}
}

# Install ADB-Tools
if ($Fastbootneeded -eq "yes") {
	if ($SDKChoice -eq "1") {
		if ($SDKDownloadChoice -eq "1") {
			if ($GetSDKChecksum -eq $SDKChecksum) {
				& $Untreblelogo
				Remove-Item -Path 'adb' -Recurse -Force -ErrorAction Ignore
				Expand-Archive -Path $SDKZipfile -DestinationPath 'adb' -ErrorAction SilentlyContinue
				Remove-Item -Force $SDKZipfile -ErrorAction Ignore
			} elseif ($GetSDKChecksum -ne $SDKChecksum) {
				& $BrokenADBTools
			}
		}
	}
}

# Check if Android-SDK-Platform-Tools are installed sucessfully
if ($Fastbootneeded -eq "yes") {
	if ($SDKChoice -eq "1") {
		if ($SDKDownloadChoice -eq "1") {
			if ($GetSDKChecksum -eq $SDKChecksum) {
				& $CheckADBTools
			}
		}
	}
}

if ($Fastbootneeded -eq "no") {
	Start-Sleep -Seconds 0
} elseif ($Fastbootneeded -eq "yes") {
	& $WrongADBTools
}

#& $Cleanup
# -------------------------------------------------------------------------------------------------------------------------------------
# Runnning Untreble 
# Welcome Screen (Main Menu)
if ($Fastbootneeded -eq "no") {
	& $MainMenu
	& $Option1
	& $Option2
	do {
			$Optionselect = [System.Console]::ReadKey($true).KeyChar
		} until (($Optionselect -eq "1") -or ($Optionselect -eq "2"))
}

# Check if the Stock-ROM-images or GPT-Table are already exists
if ($Fastbootneeded -eq "no") {
	if (($Optionselect -eq "1") -or ($Optionselect -eq "2")) {
		& $Stockimages
		& $Checkstockimages
	}
}	

# Ask for download Stock-ROM if not exist
if ($Fastbootneeded -eq "no") {
	if ($Optionselect -eq "1") {
		if (($ABL -eq $GetABL) -and ($BOOT -eq $GetBOOT) -and ($BOX -eq $GetBOX) -and ($CDA -eq $GetCDA) -and ($DSP -eq $GETDSP) -and ($ELABEL -eq $GetELABEL) -and ($GPT0 -eq $GetGPT0) -and ($HIDDEN -eq $GetHIDDEN) -and ($KEYSTORE -eq $GetKEYSTORE) -and ($LOGDUMP -eq $GetLOGDUMP) -and ($MISC -eq $GetMISC) -and ($MODEM -eq $GetMODEM) -and ($PERSIST -eq $GetPERSIST) -and ($SPLASH2 -eq $GetSPLASH2) -and ($SSD -eq $GetSSD) -and ($SUTINFO -eq $GetSUTINFO) -and ($SYSTEM -eq $GetSYSTEM) -and ($SYSTEMOTHER -eq $GetSYSTEMOTHER) -and ($SYSTEMINFO -eq $SYSTEMINFO) -and ($XBL -eq $GetXBL)) {
			Start-Sleep -Seconds 0
		} else {		
			& $DownloadStockROMMessage
			do {
				$StockDowloadQuestion = [System.Console]::ReadKey($true).KeyChar
			} until (($StockDowloadQuestion -eq "1") -or ($StockDowloadQuestion -eq "2"))			
		}
	}
}	

# Ask for download GPT-Table
if ($Fastbootneeded -eq "no") {
	if ($Optionselect -eq "2") {
		if ($GPT0 -eq $GetGPT0) {
			Start-Sleep -Seconds 0
		} else {
			& $DownloadGPT0Message
			do {
				$GPT0DownloadQuestion = [System.Console]::ReadKey($true).KeyChar
			} until (($GPT0DownloadQuestion -eq "1") -or ($GPT0DownloadQuestion -eq "2"))
		}
	}
}	

# Check 7-Zip version
if ($Fastbootneeded -eq "no") {
	if ($Optionselect -eq "1") {
		if ($StockDowloadQuestion -eq "1") {
			& $Zip7ZipCheckSHA
			& $Check7ZIP
		}
	}
}

# Ask for download & install 7Zip
if ($Zip7ZipNeeded -eq "yes") {
	& $Download7ZIPMessage
	do {
		$Zipdownloadquestion = [System.Console]::ReadKey($true).KeyChar
	} until (($Zipdownloadquestion -eq "1") -or ($Zipdownloadquestion -eq "2"))
}

# Download 7Zip
if ($Zip7ZipNeeded -eq "yes") {
	if ($Zipdownloadquestion -eq "1") {
		& $Untreblelogo
		Invoke-WebRequest -Uri "$GithubDependenciesURL/$ZIP7ZIP" -OutFile "$ZIP7ZIP" -ErrorAction Stop
		$GetZip7ZIPPackageSHA = (Get-FileHash -Algorithm SHA256 -Path $ZIP7ZIP -ErrorAction SilentlyContinue).Hash
	} elseif ($Zipdownloadquestion -eq "2") {
		& $Wrong7ZIP
		Start-Sleep -Seconds 10
		& $Abortscript
	}
}

# Install 7Zip
if ($Zip7ZipNeeded -eq "yes") {
	if ($Zipdownloadquestion -eq "1") {
		if ($Zip7ZIPPackageSHA -eq $GetZip7ZIPPackageSHA) {
			& $Untreblelogo
			Remove-Item -Path '7zip' -Recurse -Force -ErrorAction Ignore
			Expand-Archive -Path $ZIP7ZIP -DestinationPath '7zip' -ErrorAction SilentlyContinue
			Remove-Item -Force $ZIP7ZIP -ErrorAction Ignore
		} else {
			& Broken7ZArchive
			Start-Sleep -Seconds 10
			& Abortscript
		}
	}
}

# Check if 7Zip is installed sucessfully
if ($Zip7ZipNeeded -eq "yes") {
	if ($Zipdownloadquestion -eq "1") {
		& $Zip7ZipCheckSHA
		& $Check7ZIP
	}
}	

if ($Zipdownloadquestion -eq "1") {
	if ($Zip7ZipNeeded -eq "no") {
		Start-Sleep -Seconds 0
	} else {
		& $Wrong7ZIP
		Start-Sleep -Seconds 10
		& $Abortscript
	}
}

# Download Stock-ROM-Images 
if ($Optionselect -eq "1") {
	if ($Zip7ZipNeeded -eq "no") {
		& $Untreblelogo
		Invoke-WebRequest -Uri "$GithubDependenciesURL/Stock.7z" -OutFile "Stock.7z" -ErrorAction Stop
		$GetSHA256SUMStockRom = (Get-FileHash -Algorithm SHA256 -Path 'Stock.7z' -ErrorAction SilentlyContinue).Hash
	}
}

# Download GPT-Table
if ($Fastbootneeded -eq "no") {
	if ($Optionselect -eq "2") {
		if ($GPT0 -eq $GetGPT0) {
			Start-Sleep -Seconds 0
		} else {
			if ($GPT0DownloadQuestion -eq "1") {
				& $Untreblelogo
				New-Item -Path 'ROM' -ItemType Directory -ErrorAction Ignore
				Invoke-WebRequest -Uri "$GithubDependenciesURL/gpt_both0_Stock.bin" -OutFile "ROM/gpt_both0.bin" -ErrorAction Stop
			} else {
				& $Abortscript
			}
		}
	}		
}

# Check & unpack Stock-ROM
if ($Optionselect -eq "1") {
	if ($Zip7ZipNeeded -eq "no") {
		if ($SHA256SUMStockRom -eq $GetSHA256SUMStockRom) {
			& $Untreblelogo
			Remove-Item -Path 'ROM' -Recurse -Force -ErrorAction Ignore
			7zip/7z.exe x 'Stock.7z' -oROM
			Remove-Item -Force 'Stock.7z' -ErrorAction Ignore
		} else {
			& $BrokenROMArchive
			Start-Sleep -Seconds 10
			& $Abortscript
		}
	}
}

# Check if Stock-ROM ist extracted / GPT-Table downloaded sucessfully
if ($Fastbootneeded -eq "no") {
	if (($Optionselect -eq "1") -or ($Optionselect -eq "2")) {
		& $Stockimages
		& $Checkstockimages
	}
}

if ($Optionselect -eq "1") {
	if (($ABL -eq $GetABL) -and ($BOOT -eq $GetBOOT) -and ($BOX -eq $GetBOX) -and ($CDA -eq $GetCDA) -and ($DSP -eq $GETDSP) -and ($ELABEL -eq $GetELABEL) -and ($GPT0 -eq $GetGPT0) -and ($HIDDEN -eq $GetHIDDEN) -and ($KEYSTORE -eq $GetKEYSTORE) -and ($LOGDUMP -eq $GetLOGDUMP) -and ($MISC -eq $GetMISC) -and ($MODEM -eq $GetMODEM) -and ($PERSIST -eq $GetPERSIST) -and ($SPLASH2 -eq $GetSPLASH2) -and ($SSD -eq $GetSSD) -and ($SUTINFO -eq $GetSUTINFO) -and ($SYSTEM -eq $GetSYSTEM) -and ($SYSTEMOTHER -eq $GetSYSTEMOTHER) -and ($SYSTEMINFO -eq $SYSTEMINFO) -and ($XBL -eq $GetXBL)) {
		& $AllStockfilesExist
		Start-Sleep -Seconds 5
		& $StockgetSHA
	} else {
		& $AllStockfilesdontExist
		Start-Sleep -Seconds 10
		& $Abortscript
	}
} elseif ($Optionselect -eq "2") {
	if ($GPT0 -eq $GetGPT0) {
		& $GPT0Exist
		Start-Sleep -Seconds 5
		& $StockgetSHA
	} else {
		& $GPT0dontExist
		Start-Sleep -Seconds 10
		& $Abortscript
	}
}

# Check Stock-ROM files or GPT-Table for corruption
if ($Optionselect -eq "1") {
	if (($SHA256SUMABL -eq $GetSHA256SUMABL) -and ($SHA256SUMBOOT -eq $GetSHA256SUMBOOT) -and ($SHA256SUMBOX -eq $GetSHA256SUMBOX) -and ($SHA256SUMCDA -eq $GetSHA256SUMCDA) -and ($SHA256SUMDSP -eq $GetSHA256SUMDSP) -and ($SHA256SUMELABEL -eq $GetSHA256SUMELABEL) -and ($SHA256SUMGPT0 -eq $GetSHA256SUMGPT0) -and ($SHA256SUMHIDDEN -eq $GetSHA256SUMHIDDEN) -and ($SHA256SUMKEYSTORE -eq $GetSHA256SUMKEYSTORE) -and ($SHA256SUMLOGDUMP -eq $GetSHA256SUMLOGDUMP) -and ($SHA256SUMMISC -eq $GetSHA256SUMMISC) -and ($SHA256SUMMODEM -eq $GetSHA256SUMMODEM) -and ($SHA256SUMPERSIST -eq $GetSHA256SUMPERSIST) -and ($SHA256SUMSPLASH2 -eq $GetSHA256SUMSPLASH2) -and ($SHA256SUMSSD -eq $GetSHA256SUMSSD) -and ($SHA256SUMSUTINFO -eq $GetSHA256SUMSUTINFO) -and ($SHA256SUMSYSTEM -eq $GetSHA256SUMSYSTEM) -and ($SHA256SUMSYSTEMOTHER -eq $GetSHA256SUMSYSTEMOTHER) -and ($SHA256SUMSYSTEMINFO -eq $GetSHA256SUMSYSTEMINFO) -and ($SHA256SUMXBL -eq $GetSHA256SUMXBL)) {
		& $GoodStock
		Start-Sleep -Seconds 5
		$FlashMode = "Stock"
	} else {
		& $BrokenStock
		Start-Sleep -Seconds 10
		& $Abortscript
	}
} elseif ($Optionselect -eq "2") {
	if ($SHA256SUMGPT0 -eq $GetSHA256SUMGPT0) {
		& $GoodGPT
		Start-Sleep -Seconds 5
		$FlashMode = "GPT"
	} else {
		& $BrokenGPT
		Start-Sleep -Seconds 10
		& $Abortscript
	}
}

# Welcome-Screen
& $WelcomeScreen

# Warning-Screen 1
& $WarningScreen1

# Warning screen 2
& $WarningScreen2

# Ask for flash Stock-ROM // GPT-Table
if ($FlashMode -eq "Stock") {
	& $AskforStock
	& $YesNo
	do {
		$AskROMGPT = [System.Console]::ReadKey($true).KeyChar
	} until (($AskROMGPT -eq "1") -or ($AskROMGPT -eq "2"))
} elseif ($FlashMode -eq "GPT") {
	& $AskforGPT
	& $YesNo
	do {
		$AskROMGPT = [System.Console]::ReadKey($true).KeyChar
	} until (($AskROMGPT -eq "1") -or ($AskROMGPT -eq "2"))
}

# Ask for be sure to flash Stock-ROM //GPT-Table
if ($AskROMGPT -eq "1") {
	if (($FlashMode -eq "Stock") -or ($FlashMode -eq "GPT")) {
		& $Flashsure
		& $YesNo
		do {
			$Askflashsure = [System.Console]::ReadKey($true).KeyChar
		} until (($Askflashsure -eq "1") -or ($Askflashsure -eq "2"))
	}
} elseif ($AskforGPT -eq "2") {
	& $Abortscript
}	

# Instruction
if ($AskROMGPT -eq "1") {
	if ($Askflashsure -eq "1") {
		if (($FlashMode -eq "Stock") -or ($FlashMode -eq "GPT")) {
			& $Instruction
			do {
				$Proceedflash = [System.Console]::ReadKey($true).KeyChar
			} until ($Proceedflash -eq "F")
	    }
	}
}	

# Last warning screen
if ($AskROMGPT -eq "1") {
	if ($Askflashsure -eq "1") {
		if ($Proceedflash -eq "F") {
			$Flashready = "yes"
			& $LastWarning
		}
	}	
}

# Get Serialnumber
if ($Flashready -eq "yes") {
	& $GetSerialNo
}

# Check if device if NB1
if ($Flashready -eq "yes") {
	& $CheckDevice
}

# Check if bootloader is unlocked
if ($Flashready -eq "yes") {
	if ($Serial -like "NB1*") {
		& $Bootloaderunlock
	}
}	

# Check if bootloader is critical unlocked
if ($Flashready -eq "yes") {
	if ($Serial -like "NB1*") {
		if ($CheckBootloaderunlock -eq $Unlocked) {
			& $Bootloadercriticalunlock
		}	
	}
}	

# Flash ROM / GPT-Table
if ($Flashready -eq "yes") {
	if ($Unlocked -eq "yes") {
		if ($FlashMode -eq "Stock") {
			# Flash Bootloader
			& $Flashbootloader
			# Reboot bootloader after flashing Bootloader
			& $Reboot_Bootloader
			# Flash GPT-Table
			& $FlashGPT
			# Reboot bootloader after flashing GPT-Table
			& $Reboot_Bootloader
			# Flash Stock-Rom Images
			& $FlashStockImages
			# WellDone
			& $WellDone
			# Set Slot to A
			& $SetBootSlot
			# Erase Userdata
			& $EraseUserdata
			# Reboot to SYSTEM
			& $Reboot_System
		} elseif ($FlashMode -eq "GPT") {
			# Flash GPT-Table
			& $FlashGPT
			# Reboot bootloader after flashing GPT-Table
			& $Reboot_Bootloader
			# WellDone
			& $WellDone
		}
	}
}

# Finish :-D
if ($Flashready -eq "yes") {
	if ($Unlocked -eq "yes") {
		if ($FlashMode -eq "Stock") {
			& $FinishStock
		} elseif ($FlashMode -eq "GPT") {
			& $FinishGPT
		}
	}
}
