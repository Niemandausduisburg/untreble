@echo off

:: Set needed variables
chcp 65001
:: Temporarly disable DelayedExpansion while generating subfunctions
setlocal DisableDelayedExpansion
color F0
cls

:: Configure font color
:: Not needed in PowerShell :-)

:: Windows size
:: Not working :-( with PowerShell
REM mode con: cols=105 lines=30

:: LOGOS
:: Untreble Logo
set "UNTREBLELOGO=UNTREBLELOGO.bat"
(
    echo cls
    echo powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "& { " ^
        "Write-Host '██    ██ ███    ██ ████████ ██████  ███████ ██████  ██      ███████' -ForegroundColor Magenta -BackgroundColor White; " ^
        "Write-Host '██    ██ ████   ██    ██    ██   ██ ██      ██   ██ ██      ██     ' -ForegroundColor Magenta -BackgroundColor White; " ^
        "Write-Host '██    ██ ██ ██  ██    ██    ██████  █████   ██████  ██      █████  ' -ForegroundColor Magenta -BackgroundColor White; " ^
        "Write-Host '██    ██ ██  ██ ██    ██    ██   ██ ██      ██   ██ ██      ██     ' -ForegroundColor Magenta -BackgroundColor White; " ^
        "Write-Host ' ██████  ██   ████    ██    ██   ██ ███████ ██████  ███████ ███████' -ForegroundColor Magenta -BackgroundColor White; " ^
    "}"
) > "%UNTREBLELOGO%"

:: Nokia Logo
set "NOKIALOGO=NOKIALOGO.bat"
(	
    echo cls
    echo powershell -NoProfile -ExecutionPolicy Bypass -Command ^
    "& { " ^
		"Write-Host '░▒▓███████▓▒░ ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓██████▓▒░ ' -ForegroundColor Magenta -BackgroundColor White; " ^
		"Write-Host '░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░' -ForegroundColor Magenta -BackgroundColor White; " ^
		"Write-Host '░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░' -ForegroundColor Magenta -BackgroundColor White; " ^
		"Write-Host '░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓█▓▒░▒▓████████▓▒░' -ForegroundColor Magenta -BackgroundColor White; " ^
		"Write-Host '░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░' -ForegroundColor Magenta -BackgroundColor White; " ^
		"Write-Host '░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░' -ForegroundColor Magenta -BackgroundColor White; " ^
		"Write-Host '░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░' -ForegroundColor Magenta -BackgroundColor White; " ^
    "}"
) > "%NOKIALOGO%"

:: Untreble-Github-Repo
set "UNGHURL=https://github.com/Niemandausduisburg"
set "UNGHRAWURL=https://raw.githubusercontent.com/Niemandausduisburg"
set "UNGHREPO=untreble"
set "UNGHUPDURL=refs/heads"
set "UNGHDLURL=releases/download"
set "UNGHTAG=untreble-needed-files"
set "UNGHBRANCH=main"
set "UNGHUPDFILE=untreble.bat"

:: Abortscript Variable
set "ABORTSCRIPT=ABORTSCRIPT.bat"
(
    echo @echo off
	echo color 0F
	echo cls
	echo call %%CLEANUP%% ^&^& exit 1
) > "%ABORTSCRIPT%"

:: Check architecture
for /f "tokens=*" %%i in ('wmic OS get OSArchitecture ^| findstr /i "64-bit"') do (
    set "CHECKARCH=%%i"
)
:: Remove leading and trailing spaces from CHECKARCH
set "CHECKARCH=%CHECKARCH:~0,6%"
set "ISARCH=64-bit"

:: Check package manager variable
:: Not needed in Windows :-) but we need check the Windows Version
set "CHECKWINVER=CHECKWINVER.bat"
(
	echo for /f "delims=" %%%%A in ^('powershell -command "[System.Environment]::OSVersion.Version.Major"'^) do ^(
	echo 	set "WINVER=%%%%A" 
	echo ^)
) > "%CHECKWINVER%"

:: Check if Android-SDK-Tools are installed

set "CHECKADBTOOLS=CHECKADBTOOLS.bat"
(
    echo @echo off
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Check if Android-SDK-Platform-Tools are installed.' -ForegroundColor Black -BackgroundColor White}"
	echo if exist "adb/adb.exe" ^(
	echo 	if exist "adb/fastboot.exe" ^(
	echo 		set "FASTBOOTNEEDED=no"
	echo 	^) else ^(
	echo			set "FASTBOOTNEEDED=yes"
	echo	^)
	echo ^) else ^(
	echo 	set "FASTBOOTNEEDED=yes"
	echo ^)
	echo timeout /t 3
) > "%CHECKADBTOOLS%"

:: Stockimages
set "STOCKIMAGES=STOCKIMAGES.bat"
(
echo set "ABL=ROM/abl.elf"
echo set "BOOT=ROM/boot.img"
echo set "BOX=ROM/box.bin"
echo set "CDA=ROM/cda.img"
echo set "DSP=ROM/dsp.bin"
echo set "ELABEL=ROM/elabel.bin"
echo set "GPT0=ROM/gpt_both0.bin"
echo set "HIDDEN=ROM/hidden.img"
echo set "KEYSTORE=ROM/keystore.bin"
echo set "LOGDUMP=ROM/logdump.bin"
echo set "MISC=ROM/misc.bin"
echo set "MODEM=ROM/modem.bin"
echo set "PERSIST=ROM/persist.img"
echo set "SPLASH2=ROM/splash2.img"
echo set "SSD=ROM/ssd.bin"
echo set "SUTINFO=ROM/sutinfo.img"
echo set "SYSTEM=ROM/system.img"
echo set "SYSTEMOTHER=ROM/system_other.img"
echo set "SYSTEMINFO=ROM/systeminfo.img"
echo set "XBL=ROM/xbl.elf"
) > "%STOCKIMAGES%" 


:: Stockimages destinations
set "CHECKSTOCKIMAGES=CHECKSTOCKIMAGES.bat"
(
	echo @echo off
	echo if exist "%%ABL%%" set "GETABL=ROM/abl.elf"
	echo if exist "%%BOOT%%" set "GETBOOT=ROM/boot.img"
	echo if exist "%%BOX%%" set "GETBOX=ROM/box.bin"
	echo if exist "%%CDA%%" set "GETCDA=ROM/cda.img"
	echo if exist "%%DSP%%" set "GETDSP=ROM/dsp.bin"
	echo if exist "%%ELABEL%%" set "GETELABEL=ROM/elabel.bin"
	echo if exist "%%GPT0%%" set "GETGPT0=ROM/gpt_both0.bin"
	echo if exist "%%HIDDEN%%" set "GETHIDDEN=ROM/hidden.img"
	echo if exist "%%KEYSTORE%%" set "GETKEYSTORE=ROM/keystore.bin"
	echo if exist "%%LOGDUMP%%" set "GETLOGDUMP=ROM/logdump.bin"
	echo if exist "%%MISC%%" set "GETMISC=ROM/misc.bin"
	echo if exist "%%MODEM%%" set "GETMODEM=ROM/modem.bin"
	echo if exist "%%PERSIST%%" set "GETPERSIST=ROM/persist.img"
	echo if exist "%%SPLASH2%%" set "GETSPLASH2=ROM/splash2.img"
	echo if exist "%%SSD%%" set "GETSSD=ROM/ssd.bin"
	echo if exist "%%SUTINFO%%" set "GETSUTINFO=ROM/sutinfo.img"
	echo if exist "%%SYSTEM%%" set "GETSYSTEM=ROM/system.img"
	echo if exist "%%SYSTEMOTHER%%" set "GETSYSTEMOTHER=ROM/system_other.img"
	echo if exist "%%SYSTEMINFO%%" set "GETSYSTEMINFO=ROM/systeminfo.img"
	echo if exist "%%XBL%%" set "GETXBL=ROM/xbl.elf"
) > "%CHECKSTOCKIMAGES%"

:: Stockimages SHA256Sums
set "SHA256SUMABL=8EAE04FFFF46431D7FA424CC32A2FA2551B0CD759A3AF6FC259F3F13F42BED36"
set "SHA256SUMBOOT=B5EFC67602CF0DFCAF7C36062D91964B4AB0F3793FEABF2483DB618FCE886473"
set "SHA256SUMBOX=ABC5B9C4BDF7199F2B15F8D217002872A014567CF64A7857858E5A9ECBD7D4A0"
set "SHA256SUMCDA=189D946139A822886DC5EE4F2ED282E3A57A673EAFBD109B3DBAA738989E199C"
set "SHA256SUMDSP=D0C8B604DD7081CF9E2D94DD5B57D99BCA99141A207791FE36901F9886DD4467"
set "SHA256SUMELABEL=080ACF35A507AC9849CFCBA47DC2AD83E01B75663A516279C8B9D243B719643E"
set "SHA256SUMGPT0=1065C7B6D7666908EDD8A6E79F8232B343003F5C6E595A128176D87AF1F03657"
set "SHA256SUMHIDDEN=0BAF82AC193F712B6797D6D1C6FB725B19F2248C08C61167CEB4D105D6CD42BC"
set "SHA256SUMKEYSTORE=07854D2FEF297A06BA81685E660C332DE36D5D18D546927D30DAAD6D7FDA1541"
set "SHA256SUMLOGDUMP=54D46CA3AF6A0FB6315E307AA07E365C7EF12081C4C17093FA62BD600F17F302"
set "SHA256SUMMISC=30E14955EBF1352266DC2FF8067E68104607E750ABB9D3B36582B8AF909FCB58"
set "SHA256SUMMODEM=09CF1A2EC44FF5553BF486C7C960BACF398DD51DF3487F0F3C27F704514917AA"
set "SHA256SUMPERSIST=4952A421B17C1AB5BA08D7E14127809CF5047D5F7EF4321AC6F997AC2E84B0EA"
set "SHA256SUMSPLASH2=6A4CCC7193F04860ECDB21AD031497C2EC55D66C83C307FC43CDE787A2FDE3EC"
set "SHA256SUMSSD=E1456C442369F77218FD02A0013B606063A46A3FB051D0C0CF024A171F146FB5"
set "SHA256SUMSUTINFO=478F477CC561EC49494189C1D2B4A3A8ECACA10928914915A3F67700EF5F81F2"
set "SHA256SUMSYSTEM=7E1D19F50BA24F97CB69F6E3F25EBB6F52F5426A500852AA3DFD82CD8127B85A"
set "SHA256SUMSYSTEMINFO=193DF877B5CE43D0F31AE269B72514512E515CCFD94DB7E2DDD5616E301B35BE"
set "SHA256SUMSYSTEMOTHER=0A4C4A6FB396270A35B595D9C00403B9A4B3643B8934D856109BEC661F8F7C2A"
set "SHA256SUMXBL=A5328530F2F26F556844A6B8DFCF02FED6FA3BA4B9357A55CFD474FB2C0DDF1A"

:: Stockimages get SHA256Sums
set "STOCKGETSHA=STOCKGETSHA.bat"
(
	echo @echo off
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%%ABL%%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMABL=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%%BOOT%%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMBOOT=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%%BOX%%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMBOX=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%%CDA%%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMCDA=%%%%A
    echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%%DSP%%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMDSP=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%%ELABEL%%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMELABEL=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%%GPT0%%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMGPT0=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%%HIDDEN%%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMHIDDEN=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%%KEYSTORE%%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMKEYSTORE=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%%LOGDUMP%%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMLOGDUMP=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%%MISC%%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMMISC=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%%MODEM%%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMMODEM=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%%PERSIST%%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMPERSIST=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%%SPLASH2%%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMSPLASH2=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%%SSD%%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMSSD=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%%SUTINFO%%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMSUTINFO=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%%SYSTEM%%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMSYSTEM=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%%SYSTEMOTHER%%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMSYSTEMOTHER=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%%SYSTEMINFO%%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMSYSTEMINFO=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%%XBL%%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMXBL=%%%%A
) > "%STOCKGETSHA%"

:: StockGPT get SHA256SUM
set "STOCKGPTGETSHA=STOCKGPTGETSHA.bat"
(
	echo @echo off
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%%GPT0%%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMGPT0=%%%%A
) > "%STOCKGPTGETSHA%"

:: Check 7Zip Version
set "ZIP7ZIPSHA=707F415D7D581EDD9BCE99A0429AD4629D3BE0316C329E8B9EBD576F7AB50B71"
set "ZIP7ZIPCHECKSHA=ZIP7ZIPCHECKSHA.bat"
(
	echo @echo off
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '7zip/7z.exe' | Select-Object -ExpandProperty Hash"`^) do set Z7ZIPCHECKSHA=%%%%A
) > "%ZIP7ZIPCHECKSHA%"

set "CHECK7ZIP=CHECK7ZIP.bat"
(
	echo @echo off
	echo if "%%ZIP7ZIPSHA%%" == "%%Z7ZIPCHECKSHA%%" (
    echo 	set "ZIP7ZIPNEEDED=no"
	echo ^) else ^(
    echo 	set "ZIP7ZIPNEEDED=yes"
	echo ^)
) > "%CHECK7ZIP%"


:: Wrong Architecture
set "WRONGARCHITECTURE=WRONGARCHITECTURE.bat"
(
    echo @echo off
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Wrong architecture :-(' -ForegroundColor Red -BackgroundColor White; Write-Host 'Untreble is only for x86_64 (64Bit) architecture.' -ForegroundColor Red -BackgroundColor White; Write-Host '' -ForegroundColor Red -BackgroundColor White; Write-Host 'Untreble will be closed after 10 seconds.' -ForegroundColor Red -BackgroundColor White}"
	echo timeout /t 10
	echo call %%ABORTSCRIPT%%
) > "%WRONGARCHITECTURE%"

:: Unsupported system
set "UNSUPPORTEDSYSTEM=UNSUPPORTEDSYSTEM.bat"
(
	echo @echo off
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Unsupported system detected :-(' -ForegroundColor Red -BackgroundColor White; Write-Host '' -ForegroundColor Magenta -BackgroundColor White; Write-Host 'Please report it here to get support:' -ForegroundColor Red -BackgroundColor White; Write-Host 'https://t.me/HMD_Nokia_8' -ForegroundColor Blue -BackgroundColor White}"
	echo timeout /t 10
	echo call %%ABORTSCRIPT%%
) > "%UNSUPPORTEDSYSTEM%"

:: Aptitude not supported
:: Windows is currently thinking what is Aptitude? xD

:: Broken Stock-ROM-Archive
set "BROKENARCHIVE=BROKENARCHIVE.bat"
(
	echo @echo off
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Seems like the Stock-ROM-archive is broken  :-(' -ForegroundColor Red -BackgroundColor White; Write-Host 'Please download it again.' -ForegroundColor Red -BackgroundColor White}"
) > "%BROKENARCHIVE%"

:: Broken 7Zip Archive
set "BROKEN7ZARCHIVE=BROKEN7ZARCHIVE.bat"
(
	echo @echo off
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host '7Zip installation package is broken :-(' -ForegroundColor Red -BackgroundColor White; Write-Host 'Please download it again.' -ForegroundColor Red -BackgroundColor White}"
) > "%BROKEN7ZARCHIVE%"

:: 7Zip Archive not able to install
set "WRONG7ZIP=WRONG7ZIP.bat"
(
	echo @echo off
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Could not install 7Zip which is required for Untreble :-(' -ForegroundColor Red -BackgroundColor White; Write-Host 'Please try it again.' -ForegroundColor Red -BackgroundColor White}"
) > "%WRONG7ZIP%"

:: ADB-TOOLS not able to install
set "WRONGADBTOOLS=WRONGADBTOOLS.bat"
(
	echo @echo off
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Could not install Android-SDK-Platform-Tools which are required for Untreble :-(' -ForegroundColor Red -BackgroundColor White; Write-Host 'Please try it again.' -ForegroundColor Red -BackgroundColor White}"
) > "%WRONGADBTOOLS%"

:: Broken ADB-Tools Archive
set "BROKENADBTOOLS=BROKENADBTOOLS.bat"
(
	echo @echo off
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Android-SDK-Platform-Tools installation package is broken :-(' -ForegroundColor Red -BackgroundColor White; Write-Host 'Please download it again.' -ForegroundColor Red -BackgroundColor White}"
) > "%BROKENADBTOOLS%"

:: Broken files in Stock-ROM
set "BROKENSTOCK=BROKENSTOCK.bat"
(
	echo @echo off
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Seems like some files from Stock-ROM are broken :-(' -ForegroundColor Red -BackgroundColor White; Write-Host 'Please delete the ROM folder and download the package again.' -ForegroundColor Red -BackgroundColor White}"
) > "%BROKENSTOCK%"

:: All files in Stock-ROM are fine
set "GOODSTOCK=GOODSTOCK.bat"
(
	echo @echo off
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'All files from Stock-ROM are fine :-)' -ForegroundColor Green -BackgroundColor White; Write-Host 'We can continue.' -ForegroundColor Green -BackgroundColor White}"
) > "%GOODSTOCK%"

:: Good GPT-Table
set "GOODGPT=GOODGPT.bat"
(
	echo @echo off
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'GPT-Table is fine:-)' -ForegroundColor Green -BackgroundColor White; Write-Host 'We can continue.' -ForegroundColor Green -BackgroundColor White}"
) > "%GOODGPT%"

:: Broken GPT-Table
set "BROKENGPT=BROKENGPT.bat"
(
	echo @echo off
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Seems like GPT-Table is broken :-(' -ForegroundColor Red -BackgroundColor White; Write-Host 'Please remove gpt_both0.bin in ROM folder and download it again.' -ForegroundColor Red -BackgroundColor White}"
) > "%BROKENGPT%"

:: SDK missing
set "NOSDK=NOSDK.bat"
(
	echo @echo off
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Android-SDK-Platform-Tools not found :-(' -ForegroundColor Red -BackgroundColor White; Write-Host ''; Write-Host 'They are required to use Untreble.' -ForegroundColor Red -BackgroundColor White; Write-Host 'Do you want to download and install it?' -ForegroundColor Black -BackgroundColor White}"
	echo call %%YESNO%%
) > "%NOSDK%"

:: Download SDK
set "SDKSIZE=6,39MB"
set "SDKZIP=platform-tools_r35.0.2-windows.zip"

set "SDKMESSAGE=SDKMESSAGE.bat"
(
	echo @echo off
	echo if "%%WINVER%%" == "10" ^(
	echo 	call %%UNTREBLELOGO%%
	echo 	powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo 	powershell -command "& {Write-Host 'It will download and install Android-SDK-Platform-Tools ("%%SDKSIZE%%")' -ForegroundColor Red -BackgroundColor White}"
	echo 	call %%CONTINUE%%
	echo 	call %%YESNO%%
	echo ^) else if "%%WINVER%%" == "6" ^(
	echo 	call %%UNTREBLELOGO%%
	echo	powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo 	powershell -command "& {Write-Host 'It will download and install Android-SDK-Platform-Tools ("%%SDKSIZE%%")' -ForegroundColor Red -BackgroundColor White}"
	echo 	call %%CONTINUE%%
	echo 	call %%YESNO%%
	echo ^) else ^(
    echo 	call "%%UNSUPPORTEDSYSTEM%%"
	echo ^)
) > "%SDKMESSAGE%"

:: Download 7Zip
set "ZIP7ZIP=7z-24.08_Windows.zip"
set "SIZE7ZIP=2,41MB"
set "VERSION7ZIP=23.01"

set "DOWNLOAD7ZIPMESSAGE=DOWNLOAD7ZIPMESSAGE.bat"
(
	echo @echo off
	echo call %%CHECKWINVER%%
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo if "%%WINVER%%" == "10" ^(
	echo 	powershell -command "& {Write-Host '7Zip not found or wrong version :-(' -ForegroundColor Red -BackgroundColor White; Write-Host '' -ForegroundColor Red -BackgroundColor White}; Write-Host 'It is required to unpack the stock ROM.' -ForegroundColor Red -BackgroundColor White; Write-Host 'Do you want to download and install it?' -ForegroundColor Black -BackgroundColor White"
	echo 	call %%YESNO%%
	echo ^) else if "%%WINVER%%" == "6" ^(
	echo 	powershell -command "& {Write-Host '7Zip not found or wrong version :-(' -ForegroundColor Red -BackgroundColor White; Write-Host '' -ForegroundColor Red -BackgroundColor White}; Write-Host 'It is required to unpack the stock ROM.' -ForegroundColor Red -BackgroundColor White; Write-Host 'Do you want to download and install it?' -ForegroundColor Black -BackgroundColor White"
	echo 	call %%YESNO%%
	echo ^) else ^(
    echo 	call %%UNSUPPORTEDSYSTEM%%
	echo ^)
) > "%DOWNLOAD7ZIPMESSAGE%"

:: 7Zip-Package Size

:: Ask for Download 7Zip 
set "ASK7ZIPDOWNLOAD=ASK7ZIPDOWNLOAD.bat"
(
	echo @echo off    
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'It will download and instal 7Zip %%VERSION7ZIP%% (%%SIZE7ZIP%%)' -ForegroundColor Red -BackgroundColor White}
) > "%ASK7ZIPDOWNLOAD%"	

:: Continue?
set "CONTINUE=CONTINUE.bat"
(
	echo powershell -command "& {Write-Host 'Do you want to continue?' -ForegroundColor Black -BackgroundColor White}"
) > "%CONTINUE%"	

:: Yes/No
set "YESNO=YESNO.bat"
(
	echo powershell -command "& {Write-Host '1) Yes' -ForegroundColor Green -BackgroundColor White; Write-Host '2) No' -ForegroundColor Red -BackgroundColor White}"
) > "%YESNO%"

:: Main Menu
set "MAINMENU=MAINMENU.bat"
(
	echo @echo off    
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Select an option what you want:' -ForegroundColor Black -BackgroundColor White}"
) > "%MAINMENU%"

:: Main Menu - Option 1
set "OPTION1=OPTION1.bat"
(
	echo powershell -command "& {Write-Host '1)Going back to Stock-ROM (Android 9 - 516A)' -ForegroundColor Green -BackgroundColor White}"
) > "%OPTION1%"

:: Main Menu - Option 2
set "OPTION2=OPTION2.bat"
(
	echo powershell -command "& {Write-Host '2)Only restore Stock-Partition-Table (For flashing with NOST/OST LA/OSTRemote)' -ForegroundColor DarkYellow -BackgroundColor White}"
) > "%OPTION2%"

:: Download Stock-Rom
set "STOCKROMSIZE=1,48GB"
set "DOWNLOADSTOCKROMMESSAGE=DOWNLOADSTOCKROMMESSAGE.bat"
(
	echo @echo off    
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'It will download the Stock-ROM (%%STOCKROMSIZE%%)' -ForegroundColor Red -BackgroundColor White}"
) > "%DOWNLOADSTOCKROMMESSAGE%"

:: Download GPT-Table
set "GTP0SIZE=44kb"
set "DOWNLOADGPT0MESSAGE=DOWNLOADGPT0MESSAGE.bat"
(
	echo @echo off    
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'It will download the Stock-GPT-Table (%%GTP0SIZE%%)' -ForegroundColor Red -BackgroundColor White}"
) > "%DOWNLOADGPT0MESSAGE%"

:: Flashing
:: Get Serial Number
set "GETSERIALNO=GETSERIALNO.bat" 
(
    echo @echo off
    echo for /f "tokens=2 delims=: " %%%%A in ('powershell -command "(& %%FASTBOOT%% getvar serialno 2>&1 | Select-String 'serialno')"'^) do set "SERIAL=%%%%A" 
) > "%GETSERIALNO%"

:: Check if device is a NB1
set "CHECKDEVICE=CHECKDEVICE.bat"
(
   echo @echo off
   echo for /f "delims=" %%%%I in ^('powershell -command "if ('%%SERIAL%%'.Contains('NB1')) { 'NB1' } else { 'OTHER' }"'^) do set DEVICEIS=%%%%I
   echo if "%%DEVICEIS%%" == "NB1" ^(
   echo 	call %%DEVICEISNB1%%
   echo ^) else ^(
   echo 	call %%DEVICEISNOTNB1%%
   echo ^)
) > "%CHECKDEVICE%"

:: Device is NB1
set "DEVICEISNB1=DEVICEISNB1.bat"
(
	echo @echo off    
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Device is a NB1' -ForegroundColor Green -BackgroundColor White; Write-Host 'We can continue :-)' -ForegroundColor Green -BackgroundColor White}"
    echo timeout /t 5
) > "%DEVICEISNB1%"

:: Device is not NB1
set "DEVICEISNOTNB1=DEVICEISNOTNB1.bat"
(
	echo @echo off    
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Device is not a NB1' -ForegroundColor Red -BackgroundColor White; Write-Host 'We can''t continue :-(' -ForegroundColor Red -BackgroundColor White; Write-Host '' -ForegroundColor Red -BackgroundColor White; Write-Host 'Script will be closed now.' -ForegroundColor Red -BackgroundColor White}"
	echo timeout /t 10
	echo call %%ABORTSCRIPT%%
) > "%DEVICEISNOTNB1%"

:: Check if Bootloader is unlocked
set "BOOTLOADERUNLOCK=BOOTLOADERUNLOCK.bat"
(
    echo @echo off
	echo for /f "tokens=4 delims=: " %%%%A in ('powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% oem device-info 2>&1 | Select-String 'Device unlocked:')"'^) do set "CHECKBOOTLOADERUNLOCK=%%%%A"
) > "%BOOTLOADERUNLOCK%"

:: Check if Bootloader is critical unlocked
set "BOOTLOADERCRITICALUNLOCK=BOOTLOADERCRITICALUNLOCK.bat"
(
	echo @echo off 
	echo for /f "tokens=5 delims=: " %%%%A in ('powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% oem device-info 2>&1 | Select-String 'Device critical unlocked:')"'^) do set "CHECKBOOTLOADERCRITICALUNLOCK=%%%%A"
) > "%BOOTLOADERCRITICALUNLOCK%"

:: Bootloader state
set "UNLOCKED=true"
set "LOCKED=false"

:: Fastboot & Adb
set "FASTBOOT=adb/fastboot.exe"
set "ADB=adb/adb.exe"

:: Flash bootloader
set "FLASHBOOTLOADER=FLASHBOOTLOADER.bat"
(
	echo @echo off    
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Flashing bootloader:' -ForegroundColor Black -BackgroundColor White}"
	echo timeout /t 2
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash abl_a %%ABL%%)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash abl_b %%ABL%%)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash xbl_a %%XBL%%)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash xbl_b %%XBL%%)"
) > "%FLASHBOOTLOADER%"

:: Flash Stock-Images
set "FLASHSTOCKIMAGES=FLASHSTOCKIMAGES.bat"
(
	echo @echo off    
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Flashing Stock ROM:' -ForegroundColor Black -BackgroundColor White}"
	echo timeout /t 2
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash boot_a %%BOOT%%)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash boot_b %%BOOT%%)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash box %%BOX%%)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash cda_a %%CDA%%)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash cda_b %%CDA%%)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash dsp_a %%DSP%%)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash dsp_b %%DSP%%)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash elabel %%ELABEL%%)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash hidden_a %%HIDDEN%%)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash hidden_b %%HIDDEN%%)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash keystore %%KEYSTORE%%)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash logdump %%LOGDUMP%%)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash misc %%MISC%%)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash modem_a %%MODEM%%)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash modem_b %%MODEM%%)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash persist %%PERSIST%%)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash splash2 %%SPLASH2%%)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash ssd %%SSD%%)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash sutinfo %%SUTINFO%%)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash system_a %%SYSTEM%%)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash system_b %%SYSTEMOTHER%%)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash systeminfo_a %%SYSTEMINFO%%)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash systeminfo_b %%SYSTEMINFO%%)"
) > "%FLASHSTOCKIMAGES%"

:: Set boot-slot
set "SETBOOTSLOT=SETBOOTSLOT.bat"
(
	echo @echo off    
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Switching to Slot A' -ForegroundColor Red -BackgroundColor White}"
	echo timeout /t 2
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% --set-active=a)"
) > "%SETBOOTSLOT%"

:: Erase Userdata
set "ERASEUSERDATA=ERASEUSERDATA.bat"
(
	echo @echo off    
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Erasing Userdata' -ForegroundColor Red -BackgroundColor White}"
	echo timeout /t 2
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% -w)"
) > "%ERASEUSERDATA%"

:: Reboot to bootloader
set "REBOOT_BOOTLOADER=REBOOT_BOOTLOADER.bat"
(
	echo @echo off    
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Rebooting device into download mode. DO NOT disconnect your device!' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% reboot bootloader)"
	echo timeout /t 5
) > "%REBOOT_BOOTLOADER%"

:: Reboot to system
set "REBOOT_SYSTEM=REBOOT_SYSTEM.bat"
(
	echo @echo off    
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Rebooting device into system. DO NOT disconnect your device!' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% reboot)"
	echo timeout /t 5
) > "%REBOOT_SYSTEM%"

:: Flash GPT-Table
set "FLASHGPT=FLASHGPT.bat"
(
	echo @echo off    
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Flashing stock partition-table:"' -ForegroundColor Black -BackgroundColor White}"
	echo timeout /t 2
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash partition:0 %%GPT0%%)"
) > "%FLASHGPT%"

:: Check if Bootloader is unlocked message
set "BOOTLOADERUNLOCKMESSAGE=BOOTLOADERUNLOCKMESSAGE.bat"
(
	echo powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Check if bootloader is unlocked:' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
) > "%BOOTLOADERUNLOCKMESSAGE%"


:: Check if Bootloader is critical unlocked message
set "BOOTLOADERCRITICALUNLOCKMESSAGE=BOOTLOADERCRITICALUNLOCKMESSAGE.bat"
(
	echo powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Check if bootloader is critical unlocked:' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
) > "%BOOTLOADERCRITICALUNLOCKMESSAGE%"

:: Welcome Screen
set "WELCOMESCREEN=WELCOMESCREEN.bat"
(
	echo if "%%FLASHMODE%%" == "Stock" ^(
	echo 	call %%UNTREBLELOGO%%
	echo 	powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo 	powershell -command "& {Write-Host 'This will flash the Nokia stock ROM (Android 9 / 516A) on your device.' -ForegroundColor Black -BackgroundColor White}"
	echo	timeout /t 5
	echo ^) else if "%%FLASHMODE%%" == "GPT" ^(
	echo 	call %%UNTREBLELOGO%%
	echo 	powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo 	powershell -command "& {Write-Host 'This will flash the Nokia stock GPT-Table for you for flasing your device with NOST, OST LA, OSTRemote.' -ForegroundColor Black -BackgroundColor White}"
	echo 	timeout /t 5
	echo ^)
) > "%WELCOMESCREEN%"

:: Warning Screen 1
set "WARNINGSCREEN1=WARNINGSCREEN1.bat"
(
	echo if "%%FLASHMODE%%" == "Stock" ^(
	echo 	call %%UNTREBLELOGO%%
	echo 	powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo 	powershell -command "& {Write-Host 'WARNING!' -ForegroundColor Red -BackgroundColor White}"
	echo 	powershell -command "& {Write-Host 'MAKE A BACKUP FROM YOUR DATA!' -ForegroundColor Red -BackgroundColor White}"
	echo 	powershell -command "& {Write-Host 'ALL DATA WILL BE LOST AFTER FLASHING (FACTORY RESET)!' -ForegroundColor Red -BackgroundColor White}"
	echo 	powershell -command "& {Write-Host 'WE ACCEPT NO LIABILITY IF YOU LOSE DATA OR USE THIS TOOL INCORRECTLY!' -ForegroundColor Red -BackgroundColor White}"
	echo 	timeout /t 10
	echo ^) else if "%%FLASHMODE%%" == "GPT" ^(
	echo 	call %%UNTREBLELOGO%%
	echo 	powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo 	powershell -command "& {Write-Host 'WARNING!' -ForegroundColor Red -BackgroundColor White}"
	echo 	powershell -command "& {Write-Host 'MAKE A BACKUP FROM YOUR DATA!' -ForegroundColor Red -BackgroundColor White}"
	echo 	powershell -command "& {Write-Host 'ALL DATA WILL BE LOST AFTER FLASHING (FACTORY RESET)!' -ForegroundColor Red -BackgroundColor White}"
	echo 	powershell -command "& {Write-Host 'WE ACCEPT NO LIABILITY IF YOU LOSE DATA OR USE THIS TOOL INCORRECTLY!' -ForegroundColor Red -BackgroundColor White}"
	echo 	timeout /t 10
	echo ^)
) > "%WARNINGSCREEN1%"

:: Warning Screen 2
set "WARNINGSCREEN2=WARNINGSCREEN2.bat"
(
	echo if "%%FLASHMODE%%" == "Stock" ^(
	echo 	call %%UNTREBLELOGO%%
	echo 	powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo 	powershell -command "& {Write-Host 'WARNING!' -ForegroundColor Red -BackgroundColor White}"
	echo 	powershell -command "& {Write-Host 'FLASHING SOME PARTITIONS CAN TAKE SOME TIME (ABOUT 5 MINUTES).' -ForegroundColor Red -BackgroundColor White}"
	echo 	powershell -command "& {Write-Host 'DO NOT UNPLUG THE USB-CABLE OR CLOSE CMD OR YOU WILL BRICK YOUR DEVICE!!!' -ForegroundColor Red -BackgroundColor White}"
	echo 	powershell -command "& {Write-Host 'SOMETIMES CMD SEEMS TO BE FREZZING. DO NOT ABORT THE PROCESS AND STILL WAITING UNTIL THE PROCESS IS DONE.' -ForegroundColor Red -BackgroundColor White}"
	echo 	timeout /t 10
	echo ^)
) > "%WARNINGSCREEN2%"

:: Ask for flash Stock
set "ASKFORSTOCK=ASKFORSTOCK.bat"
(
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Are you sure you want to flash Stock ROM?' -ForegroundColor Black -BackgroundColor White}"
) >"%ASKFORSTOCK%"
	
:: Ask for flash GPT
set "ASKFORGPT=ASKFORGPT.bat"
(
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Are you sure you want to flash the stock GPT-Table?' -ForegroundColor Black -BackgroundColor White}"
) >"%ASKFORGPT%"

:: Ask for sure flash
set "FLASHSSURE=FLASHSSURE.bat"
(
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Have you read and understand the warnings and are you sure you want to proceed?' -ForegroundColor Black -BackgroundColor White}"
) >"%FLASHSSURE%"

:: Instruction
set "INSTRUCTION=INSTRUCTION.bat"
(
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Boot your device into download-mode (Vol- & Plug-in USB-cable) and connect it to your PC.' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Be sure your device is recognized correctly.' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Enter ' -ForegroundColor Black -BackgroundColor White -NoNewline}"
	echo powershell -command "& {Write-Host '[f] ' -ForegroundColor Red -BackgroundColor White -NoNewline}"
	echo powershell -command "& {Write-Host 'when your device is in download-mode and connected to your PC to proceed.' -ForegroundColor Black -BackgroundColor White}"
) >"%INSTRUCTION%"

:: Last warning - Flash Stock
set "LASTWARNINGSTOCK=LASTWARNINGSTOCK.bat"
(
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'ATTENTION!!!' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'THE WHOLE FLASHING PROCESS CAN TAKE UP TO 10 MINUTES.' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'LEAN BACK AND LET IT FLASHING.' -ForegroundColor Red -BackgroundColor White}"
	echo timeout /t 10
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Let''s flash and revert back to Stock-ROM :-)' -ForegroundColor Black -BackgroundColor White}"
	echo timeout /t 5
) >"%LASTWARNINGSTOCK%"

:: Last warning - Flash GPT
set "LASTWARNINGGPT=LASTWARNINGGPT.bat"
(
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Let''s flash and revert back to Stock-GPT-Table :-)' -ForegroundColor Black -BackgroundColor White}"
	echo timeout /t 5
) >"%LASTWARNINGGPT%"

:: Well done
set "WELLDONE=WELLDONE.bat"
(
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Green -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Well done xD' -ForegroundColor Green -BackgroundColor White}"
	echo timeout /t 5
) >"%WELLDONE%"

:: Finish flash Stock-ROM
set "FINISHSTOCK=FINISHSTOCK.bat"
(
	echo call %%NOKIALOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Green -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'You are back to Stock ROM successfully.' -ForegroundColor Green -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Your device will boot into the ROM now.' -ForegroundColor Green -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Enjoy your time travel to the ancient times xD' -ForegroundColor Green -BackgroundColor White}"
	echo powershell -command "& {Write-Host '' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'You can unplug your device now :-)' -ForegroundColor Red -BackgroundColor White}"
	echo timeout /t 10
	echo cls
	echo color 0F
	echo %%CLEANUP%% ^&^& exit 0
) >"%FINISHSTOCK%"

:: Finish flash GPT-Table
set "FINISHGPT=FINISHGPT.bat"
(
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Green -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Partition-Table successfully flashed :-)' -ForegroundColor Green -BackgroundColor White}"
	echo powershell -command "& {Write-Host '' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'You need to flash a Stock-Firmware with NOST or OST LA to boot your device!!!' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'I don''t recommend using OSTRemote or it will brick your device :-(' -ForegroundColor Red -BackgroundColor White}"
	echo timeout /t 10
	echo cls
	echo color 0F
	echo %%CLEANUP%% ^&^& exit 0
) >"%FINISHGPT%"

:: Ask for check for updates
set "ASKFORCHECKUPDATE=ASKFORCHECKUPDATE.bat"
(
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Do you want to check for updates?' -ForegroundColor Black -BackgroundColor White}"
	echo call %%YESNO%%
) >"%ASKFORCHECKUPDATE%"

:: Check for Update
set "CHECKFORUPDATE=CHECKFORUPDATE.bat"
(
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Checking for updates...' -ForegroundColor Black -BackgroundColor White}"
	echo timeout /t 2
	echo curl -L --connect-timeout 10 %%UNGHRAWURL%%/%%UNGHREPO%%/%%UNGHUPDURL%%/%%UNGHBRANCH%%/%%UNGHUPDFILE%% --output temp.bat
) >"%CHECKFORUPDATE%"

:: Compare Scripts
set "COMPAREUPDATE=COMPAREUPDATE.bat"
(
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 'untreble.bat' | Select-Object -ExpandProperty Hash"`^) do set REVERTOLD=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 'temp.bat' | Select-Object -ExpandProperty Hash"`^) do set REVERTNEW=%%%%A
) >"%COMPAREUPDATE%"

:: Ask for Update
set "ASKFORUPDATE=ASKFORUPDATE.bat"
(
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Update found!!!' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Do you want update?' -ForegroundColor Black -BackgroundColor White}"
	echo call %%YESNO%%
) >"%ASKFORUPDATE%"

:: When no update is selected
set "SELCECTNOUPDATE=SELCECTNOUPDATE.bat"
(
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Don''t cry when something is not working.' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Joke xD' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'When something is not working check for Updates.' -ForegroundColor Red -BackgroundColor White}"
	echo del temp.bat
	echo timeout /t 5
) >"%SELCECTNOUPDATE%"

:: When no updated found
set "NOUPDATEFOUND=NOUPDATEFOUND.bat"
(
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Green -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Untreble is already up-to-date :-)' -ForegroundColor Green -BackgroundColor White}"
	echo powershell -command "& {Write-Host '' -ForegroundColor Green -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Untreble will continue now.' -ForegroundColor Black -BackgroundColor White}"
	echo del temp.bat
	echo timeout /t 5
) >"%NOUPDATEFOUND%"

:: Update Untreble
set "UPDATE=UPDATE.bat"
(
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Updating Untreble...' -ForegroundColor Red -BackgroundColor White}"
	echo timeout /t 5
    echo del untreble.bat
    echo ren temp.bat untreble.bat
	echo call %%AFTERUPDATE%%
	echo start /b untreble.bat
	echo exit 0
) >"%UPDATE%"

:: After Update
set "AFTERUPDATE=AFTERUPDATE.bat"
(
	echo call %%UNTREBLELOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Green -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Update successfully :-)' -ForegroundColor Green -BackgroundColor White}"
	echo powershell -command "& {Write-Host '' -ForegroundColor Green -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Untreble will restart now.' -ForegroundColor Black -BackgroundColor White}"
	echo timeout /t 5
) >"%AFTERUPDATE%"

:: Remove Sub-Scripts
set "CLEANUP=CLEANUP.bat"
(
:: Reset variables
	echo set "ABL="
	echo set "ABORTSCRIPT="
	echo set "ADB="
	echo set "AFTERUPDATE="
	echo set "ASK7ZIPDOWNLOAD="
	echo set "askflashsure="
	echo set "ASKFORGPT="
	echo set "ASKFORSTOCK="
	echo set "ASKFORUPDATE="
	echo set "askromgpt="
	echo set "ASKFORCHECKUPDATE="
	echo set "askusertosearchupdate="
	echo set "askusertoupdate="
	echo set "BOOT="
	echo set "BOOTLOADERCRITICALUNLOCK="
	echo set "BOOTLOADERCRITICALUNLOCKMESSAGE="
	echo set "BOOTLOADERUNLOCK="
	echo set "BOOTLOADERUNLOCKMESSAGE="
	echo set "BOX="
	echo set "BROKEN7ZARCHIVE="
	echo set "BROKENADBTOOLS="
	echo set "BROKENARCHIVE="
	echo set "BROKENGPT="
	echo set "BROKENSTOCK="
	echo set "CDA="
	echo set "CHECKADBTOOLS="
	echo set "CHECKARCH="
	echo set "CHECKDEVICE="
	echo set "CHECKFORUPDATE="
	echo set "CHECKSTOCKIMAGES="
	echo set "CHECKSUM="
	echo set "CHECKWINVER="
	echo set "CLEANUP="
	echo set "COMPAREUPDATE="
	echo set "CONTINUE="
	echo set "DEVICEIS="
	echo set "DEVICEISNB1="
	echo set "DEVICEISNOTNB1="
	echo set "DOWNLOAD7ZIPMESSAGE="
	echo set "DOWNLOADGPT0MESSAGE="
	echo set "DOWNLOADSTOCKROMMESSAGE="
	echo set "downloadstockselect="
	echo set "DSP="
	echo set "ELABEL="
	echo set "ERASEUSERDATA="
	echo set "FASTBOOT="
	echo set "FASTBOOTNEEDED="
	echo set "FINISHGPT="
	echo set "FINISHSTOCK="
	echo set "FLASHBOOTLOADER="
	echo set "FLASHGPT="
	echo set "FLASHMODE="
	echo set "FLASHREADY="
	echo set "FLASHSSURE="
	echo set "FLASHSTOCKIMAGES="
	echo set "GETABL="
	echo set "GETBOOT="
	echo set "GETBOX="
	echo set "GETCDA="
	echo set "GETDSP="
	echo set "GETELABEL="
	echo set "GETGPT0="
	echo set "GETHIDDEN="
	echo set "GETKEYSTORE="
	echo set "GETLOGDUMP="
	echo set "GETMISC="
	echo set "GETMODEM="
	echo set "GETPERSIST="
	echo set "GETSERIALNO="
	echo set "GETSHA256SUMABL="
	echo set "GETSHA256SUMBOOT="
	echo set "GETSHA256SUMBOX="
	echo set "GETSHA256SUMCDA="
	echo set "GETSHA256SUMDSP="
	echo set "GETSHA256SUMELABEL="
	echo set "GETSHA256SUMGPT0="
	echo set "GETSHA256SUMHIDDEN="
	echo set "GETSHA256SUMKEYSTORE="
	echo set "GETSHA256SUMLOGDUMP="
	echo set "GETSHA256SUMMISC="
	echo set "GETSHA256SUMMODEM="
	echo set "GETSHA256SUMPERSIST="
	echo set "GETSHA256SUMSPLASH2="
	echo set "GETSHA256SUMSSD="
	echo set "GETSHA256SUMSUTINFO="
	echo set "GETSHA256SUMSYSTEM="
	echo set "GETSHA256SUMSYSTEMINFO="
	echo set "GETSHA256SUMSYSTEMOTHER="
	echo set "GETSHA256SUMXBL="
	echo set "GETSPLASH2="
	echo set "GETSSD="
	echo set "GETSUTINFO="
	echo set "GETSYSTEM="
	echo set "GETSYSTEMINFO="
	echo set "GETSYSTEMOTHER="
	echo set "GETXBL="
	echo set "GOODGPT="
	echo set "GOODSTOCK="
	echo set "GPT0="
	echo set "gpt0downloadquestion="
	echo set "GPT="
	echo set "GTP0SIZE="
	echo set "HIDDEN="
	echo set "INSTRUCTION="
	echo set "ISARCH="
	echo set "KEYSTORE="
	echo set "LASTWARNINGGPT="
	echo set "LASTWARNINGSTOCK="
	echo set "LOGDUMP="
	echo set "logo1="
	echo set "logo2="
	echo set "logo3="
	echo set "logo4="
	echo set "logo5="
	echo set "UNTREBLELOGO="
	echo set "MAINMENU="
	echo set "MISC="
	echo set "MODEM="
	echo set "nokia1="
	echo set "nokia2="
	echo set "nokia3="
	echo set "nokia4="
	echo set "nokia5="
	echo set "nokia6="
	echo set "nokia7="
	echo set "NOKIALOGO="
	echo set "NOSDK="
	echo set "NOUPDATEFOUND="
	echo set "OPTION1="
	echo set "OPTION2="
	echo set "optionselect="
	echo set "PERSIST="
	echo set "proceedflash="
	echo set "REBOOT_BOOTLOADER="
	echo set "REBOOT_SYSTEM="
	echo set "REVERTNEW="
	echo set "REVERTOLD="
	echo set "sdkchoice="
	echo set "SDKMESSAGE="
	echo set "SDKSIZE="
	echo set "SDKZIP="
	echo set "SEARCHEDFORUPDATE="
	echo set "SELCECTNOUPDATE="
	echo set "SERIAL=" 
	echo set "SETBOOTSLOT="
	echo set "SHA256SUMABL="
	echo set "SHA256SUMBOOT="
	echo set "SHA256SUMBOX="
	echo set "SHA256SUMCDA="
	echo set "SHA256SUMDSP="
	echo set "SHA256SUMELABEL="
	echo set "SHA256SUMGPT0="
	echo set "SHA256SUMHIDDEN="
	echo set "SHA256SUMKEYSTORE="
	echo set "SHA256SUMLOGDUMP="
	echo set "SHA256SUMMISC="
	echo set "SHA256SUMMODEM="
	echo set "SHA256SUMPERSIST="
	echo set "SHA256SUMSPLASH2="
	echo set "SHA256SUMSSD="
	echo set "SHA256SUMSUTINFO="
	echo set "SHA256SUMSYSTEM="
	echo set "SHA256SUMSYSTEMINFO="
	echo set "SHA256SUMSYSTEMOTHER="
	echo set "SHA256SUMXBL="
	echo set "SIZE7ZIP="
	echo set "SPLASH2="
	echo set "SSD="
	echo set "STOCKGETSHA="
	echo set "STOCKGPTGETSHA="
	echo set "STOCKIMAGES="
	echo set "STOCKROMSIZE="
	echo set "SUTINFO="
	echo set "SYSTEM="
	echo set "SYSTEMINFO="
	echo set "SYSTEMOTHER="
	echo set "UNGHBRANCH="
	echo set "UNGHDLURL="
	echo set "UNGHREPO="
	echo set "UNGHTAG="
	echo set "UNGHURL="
	echo set "UNLOCKED1="
	echo set "UNLOCKED2="
	echo set "UNSUPPORTEDSYSTEM="
	echo set "UPDATE="
	echo set "VERSION7ZIP="
	echo set "WARNINGSCREEN1="
	echo set "WARNINGSCREEN2="
	echo set "WELCOMESCREEN="
	echo set "WELLDONE="
	echo set "WINVER="
	echo set "WRONG7ZIP="
	echo set "WRONGADBTOOLS="
	echo set "WRONGARCHITECTURE="
	echo set "XBL="	
	echo set "YESNO="
	echo set "Z7ZIPCHECKSHA="
	echo set "ZIP7ZIP="
	echo set "ZIP7ZIPCHECKSHA="
	echo set "ZIP7ZIPNEEDED="
	echo set "ZIP7ZIPSHA="
	echo set "zipdownloadquestion="
	echo set "zipquestion="	
:: Remove Sub-Scripts
	echo del AFTERUPDATE.bat
	echo del ASK7ZIPDOWNLOAD.bat
	echo del ASKFORGPT.bat
	echo del ASKFORSTOCK.bat
	echo del ASKFORUPDATE.bat
	echo del ASKFORCHECKUPDATE.bat
	echo del BOOTLOADERCRITICALUNLOCK.bat
	echo del BOOTLOADERCRITICALUNLOCKMESSAGE.bat
	echo del BOOTLOADERUNLOCK.bat
	echo del BOOTLOADERUNLOCKMESSAGE.bat
	echo del BROKEN7ZARCHIVE.bat
	echo del BROKENADBTOOLS.bat
	echo del BROKENARCHIVE.bat
	echo del BROKENGPT.bat
	echo del BROKENSTOCK.bat
	echo del CHECK7ZIP.bat
	echo del CHECKADBTOOLS.bat
	echo del CHECKDEVICE.bat
	echo del CHECKFORUPDATE.bat
	echo del CHECKSTOCKIMAGES.bat
	echo del CHECKWINVER.bat
	echo del COMPAREUPDATE.bat
	echo del CONTINUE.bat
	echo del DEVICEISNB1.bat
	echo del DEVICEISNOTNB1.bat
	echo del DOWNLOAD7ZIPMESSAGE.bat
	echo del DOWNLOADGPT0MESSAGE.bat
	echo del DOWNLOADSTOCKROMMESSAGE.bat
	echo del ERASEUSERDATA.bat
	echo del FINISHGPT.bat
	echo del FINISHSTOCK.bat
	echo del FLASHBOOTLOADER.bat
	echo del FLASHGPT.bat
	echo del FLASHSSURE.bat
	echo del FLASHSTOCKIMAGES.bat
	echo del GETSERIALNO.bat
	echo del GOODGPT.bat
	echo del GOODSTOCK.bat
	echo del INSTRUCTION.bat
	echo del LASTWARNINGGPT.bat
	echo del LASTWARNINGSTOCK.bat
	echo del UNTREBLELOGO.bat
	echo del MAINMENU.bat
	echo del NOKIALOGO.bat
	echo del NOSDK.bat
	echo del NOUPDATEFOUND.bat
	echo del OPTION1.bat
	echo del OPTION2.bat
	echo del REBOOT_BOOTLOADER.bat
	echo del REBOOT_SYSTEM.bat
	echo del SDKMESSAGE.bat
	echo del SELCECTNOUPDATE.bat
	echo del SETBOOTSLOT.bat
	echo del STOCKGETSHA.bat
	echo del STOCKGPTGETSHA.bat
	echo del STOCKIMAGES.bat
	echo del UNSUPPORTEDSYSTEM.bat
	echo del UPDATE.bat
	echo del WARNINGSCREEN1.bat
	echo del WARNINGSCREEN2.bat
	echo del WELCOMESCREEN.bat
	echo del WELLDONE.bat
	echo del WRONG7ZIP.bat
	echo del WRONGADBTOOLS.bat
	echo del WRONGARCHITECTURE.bat
	echo del YESNO.bat
	echo del ZIP7ZIPCHECKSHA.bat
:: Remove Abortscript & Cleanup at the End	
	echo del ABORTSCRIPT.bat
	echo del CLEANUP.bat
) >"%CLEANUP%"
::-------------------------------------------------------------------------------------------------------------------------------------	
:: Start Untreble
:: Prepare
:: Ask for checking for Update
call %ASKFORCHECKUPDATE%
choice /n /c:12 %1
if errorlevel 1 set "askusertosearchupdate=1"
if errorlevel 2 set "askusertosearchupdate=2"

if "%askusertosearchupdate%" == "1" (
	call %CHECKFORUPDATE%
	call %COMPAREUPDATE%
	set "SEARCHEDFORUPDATE=1"
) else if "%askusertosearchupdate%" == "2" (
	call %SELCECTNOUPDATE%
)
  
:: Ask for Update
if "%SEARCHEDFORUPDATE%" == "1" (
	if not "%REVERTOLD%" == "%REVERTNEW%" (
		call %ASKFORUPDATE%
		choice /n /c:12 %1
		if errorlevel 1 set "askusertoupdate=1"
		if errorlevel 2 set "askusertoupdate=2"
	) else if "%REVERTOLD%" == "%REVERTNEW%" (
		call %NOUPDATEFOUND%
	)
)

:: Update Untreble
if "%askusertoupdate%" == "1" (
	%UPDATE%
) else if "%askusertoupdate%" == "2" (
	call %SELCECTNOUPDATE%%
)

:: Check architecture
if "%CHECKARCH%" == "%ISARCH%" (
	timeout /t 0
) else if not "%CHECKARCH%" == "%ISARCH%" ( 
	call %WRONGARCHITECTURE%
)

:: Check if Android-SDK-Platform-Tools are installed
call %CHECKADBTOOLS%

if "%FASTBOOTNEEDED%" == "yes" (
	call %NOSDK%
	choice /n /c:12 %1
	if errorlevel 1 set "sdkchoice=1"
	if errorlevel 2 set "sdkchoice=2"
)

:: Check which package manager is used 
:: What is a package-manager ??? XD

:: Check Windows Version
if "%FASTBOOTNEEDED%" == "yes" (
	if "%sdkchoice%" == "1" (
		call %CHECKWINVER%
	) else if "%sdkchoice%" == "2" (
		call %ABORTSCRIPT%
	)
)

:: Asking for downloading ADB-Tools
if "%FASTBOOTNEEDED%" == "yes" (
	if "%sdkchoice%" == "1" (
		call %SDKMESSAGE%
		choice /n /c:12 %1
		if errorlevel 1 set "sdkdownloadchoice=1"
		if errorlevel 2 set "sdkdownloadchoice=2"
	)
)

:: Download ADB-Tools
if "%FASTBOOTNEEDED%" == "yes" (
	if "%sdkchoice%" == "1" (
		if "%sdkdownloadchoice%" == "1" (
			if "%WINVER%" == "6" (
				call %UNTREBLELOGO%
				powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
				curl -L --connect-timeout 10 %UNGHURL%/%UNGHREPO%/%UNGHDLURL%/%UNGHTAG%/%SDKZIP% --output %SDKZIP%
				set "CHECKSUM=D076031AF58F4413B373E055737340528B8C0A68FA39DF62B3FBFA361D93AD87"
				for /f "usebackq" %%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%SDKZIP%' | Select-Object -ExpandProperty Hash"`) do set GETCHECKSUM=%%A
			) else if "%WINVER%" == "10" (
				call %UNTREBLELOGO%
				powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
				curl -L --connect-timeout 10 %UNGHURL%/%UNGHREPO%/%UNGHDLURL%/%UNGHTAG%/%SDKZIP% --output %SDKZIP%
				set "CHECKSUM=D076031AF58F4413B373E055737340528B8C0A68FA39DF62B3FBFA361D93AD87"
				for /f "usebackq" %%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%SDKZIP%' | Select-Object -ExpandProperty Hash"`) do set GETCHECKSUM=%%A
			)
		) else if "%sdkdownloadchoice%" == "2" (
			call %ABORTSCRIPT%
		)
	)
)

:: Install ADB-Tools
if "%FASTBOOTNEEDED%" == "yes" (
	if "%sdkchoice%" == "1" (
		if "%sdkdownloadchoice%" == "1" (
			if "%CHECKSUM%" == "%GETCHECKSUM%" (
				if "%WINVER%" == "6" (
					call %UNTREBLELOGO%
					powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
					powershell -command "Expand-Archive -Path '%SDKZIP%' -DestinationPath 'adb'"
					del %SDKZIP% 
				) else if "%WINVER%" == "10" (
					call %UNTREBLELOGO%
					powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
					powershell -command "Expand-Archive -Path '%SDKZIP%' -DestinationPath 'adb'"
					del %SDKZIP%
				)
			) else if not "%CHECKSUM%" == "%GETCHECKSUM%" (
				call %BROKENADBTOOLS%
				timeout /t 10
				call %ABORTSCRIPT%
			)
		)
	)
)

:: Check if Android-SDK-Platform-Tools are installed sucessfully
call %CHECKADBTOOLS%

if "%FASTBOOTNEEDED%" == "no" (
	timeout /t0
) else if "%FASTBOOTNEEDED%" == "yes" (
	call %WRONGADBTOOLS%
	timeout /t 10
	call %ABORTSCRIPT%
)
:: -------------------------------------------------------------------------------------------------------------------------------------
:: Main
:: Welcome Screen (Main Menu)
if "%FASTBOOTNEEDED%" == "no" (
	call %MAINMENU%
	call %OPTION1%
	call %OPTION2%
	choice /n /c:12 %1
	if errorlevel 1 set "optionselect=1"
	if errorlevel 2 set "optionselect=2"
)

:: Check if the Stock-ROM-images or GPT-Table are already exists
if "%FASTBOOTNEEDED%" == "no" (
	if "%optionselect%" == "1" (
		call %STOCKIMAGES%
		call %CHECKSTOCKIMAGES%
	) else if "%optionselect%" == "2" (
		call %STOCKIMAGES%
		call %CHECKSTOCKIMAGES%
	)
)	

:: Ask for download Stock-ROM if not exist
if "%FASTBOOTNEEDED%" == "no" (
	if "%optionselect%" == "1" (
		if "%ABL%" == "%GETABL%" (
			if "%BOOT%" == "%GETBOOT%" (
				if "%BOX%" == "%GETBOX%" (
					if "%CDA%" == "%GETCDA%" (
						if "%DSP%" == "%GETDSP%" (
							if "%ELABEL%" == "%GETELABEL%" (
								if "%GPT0%" == "%GETGPT0%" (
									if "%HIDDEN%" == "%GETHIDDEN%" (
										if "%KEYSTORE%" == "%GETKEYSTORE%" (
											if "%LOGDUMP%" == "%GETLOGDUMP%" (
												if "%MISC%" == "%GETMISC%" (
													if "%MODEM%" == "%GETMODEM%" (
														if "%PERSIST%" == "%GETPERSIST%" (
															if "%SPLASH2%" == "%GETSPLASH2%" (
																if "%SSD%" == "%GETSSD%" (
																	if "%SUTINFO%" == "%GETSUTINFO%" (
																		if "%SYSTEM%" == "%GETSYSTEM%" (
																			if "%SYSTEMOTHER%" == "%GETSYSTEMOTHER%" (
																				if "%SYSTEMINFO%" == "%GETSYSTEMINFO%" (
																					if "%XBL%" == "%GETXBL%" (
																						timeout /t 0 
																					) else if not "%XBL%" == "%GETXBL%" (
																						call %DOWNLOADSTOCKROMMESSAGE%
																						call %CONTINUE%
																						call %YESNO%
																						choice /n /c:12 %1
																						if errorlevel 1 set "downloadstockselect=1"
																						if errorlevel 2 set "downloadstockselect=2"
																					)
																				) else if not "%SYSTEMINFO%" == "%GETSYSTEMINFO%" (
																					call %DOWNLOADSTOCKROMMESSAGE%
																					call %CONTINUE%
																					call %YESNO%
																					choice /n /c:12 %1
																					if errorlevel 1 set "downloadstockselect=1"
																					if errorlevel 2 set "downloadstockselect=2"
																				)
																			) else if not "%SYSTEMOTHER%" == "%GETSYSTEMOTHER%" (
																				call %DOWNLOADSTOCKROMMESSAGE%
																				call %CONTINUE%
																				call %YESNO%
																				choice /n /c:12 %1
																				if errorlevel 1 set "downloadstockselect=1"
																				if errorlevel 2 set "downloadstockselect=2"
																			)
																		) else if not "%SYSTEM%" == "%GETSYSTEM%" (
																			call %DOWNLOADSTOCKROMMESSAGE%
																			call %CONTINUE%
																			call %YESNO%
																			choice /n /c:12 %1
																			if errorlevel 1 set "downloadstockselect=1"
																			if errorlevel 2 set "downloadstockselect=2"
																		)
																	) else if not "%SUTINFO%" == "%GETSUTINFO%" (
																		call %DOWNLOADSTOCKROMMESSAGE%
																		call %CONTINUE%
																		call %YESNO%
																		choice /n /c:12 %1
																		if errorlevel 1 set "downloadstockselect=1"
																		if errorlevel 2 set "downloadstockselect=2"
																	)
																) else if not "%SSD%" == "%GETSSD%" (
																	call %DOWNLOADSTOCKROMMESSAGE%
																	call %CONTINUE%
																	call %YESNO%
																	choice /n /c:12 %1
																	if errorlevel 1 set "downloadstockselect=1"
																	if errorlevel 2 set "downloadstockselect=2"
																)
															) else if not "%SPLASH2%" == "%GETSPLASH2%" (
																call %DOWNLOADSTOCKROMMESSAGE%
																call %CONTINUE%
																call %YESNO%
																choice /n /c:12 %1
																if errorlevel 1 set "downloadstockselect=1"
																if errorlevel 2 set "downloadstockselect=2"
															)
														) else if not "%PERSIST%" == "%GETPERSIST%" (
															call %DOWNLOADSTOCKROMMESSAGE%
															call %CONTINUE%
															call %YESNO%
															choice /n /c:12 %1
															if errorlevel 1 set "downloadstockselect=1"
															if errorlevel 2 set "downloadstockselect=2"
														)
													) else if not "%MODEM%" == "%GETMODEM%" (
														call %DOWNLOADSTOCKROMMESSAGE%
														call %CONTINUE%
														call %YESNO%
														choice /n /c:12 %1
														if errorlevel 1 set "downloadstockselect=1"
														if errorlevel 2 set "downloadstockselect=2"
													)
												) else if not "%MISC%" == "%GETMISC%" (
													call %DOWNLOADSTOCKROMMESSAGE%
													call %CONTINUE%
													call %YESNO%
													choice /n /c:12 %1
													if errorlevel 1 set "downloadstockselect=1"
													if errorlevel 2 set "downloadstockselect=2"
												)
											) else if not "%LOGDUMP%" == "%GETLOGDUMP%" (
												call %DOWNLOADSTOCKROMMESSAGE%
												call %CONTINUE%
												call %YESNO%
												choice /n /c:12 %1
												if errorlevel 1 set "downloadstockselect=1"
												if errorlevel 2 set "downloadstockselect=2"
											)
										) else if not "%KEYSTORE%" == "%GETKEYSTORE%" (
											call %DOWNLOADSTOCKROMMESSAGE%
											call %CONTINUE%
											call %YESNO%
											choice /n /c:12 %1
											if errorlevel 1 set "downloadstockselect=1"
											if errorlevel 2 set "downloadstockselect=2"
										)
									) else if not "%HIDDEN%" == "%GETHIDDEN%" (
										call %DOWNLOADSTOCKROMMESSAGE%
										call %CONTINUE%
										call %YESNO%
										choice /n /c:12 %1
										if errorlevel 1 set "downloadstockselect=1"
										if errorlevel 2 set "downloadstockselect=2"
									)
								) else if not "%GPT0%" == "%GETGPT0%" (
									call %DOWNLOADSTOCKROMMESSAGE%
									call %CONTINUE%
									call %YESNO%
									choice /n /c:12 %1
									if errorlevel 1 set "downloadstockselect=1"
									if errorlevel 2 set "downloadstockselect=2"
								)
							) else if not "%ELABEL%" == "%GETELABEL%" (
								call %DOWNLOADSTOCKROMMESSAGE%
								call %CONTINUE%
								call %YESNO%
								choice /n /c:12 %1
								if errorlevel 1 set "downloadstockselect=1"
								if errorlevel 2 set "downloadstockselect=2"
							)
						) else if not "%DSP%" == "%GETDSP%" (
							call %DOWNLOADSTOCKROMMESSAGE%
							call %CONTINUE%
							call %YESNO%
							choice /n /c:12 %1
							if errorlevel 1 set "downloadstockselect=1"
							if errorlevel 2 set "downloadstockselect=2"
						)
					) else if not "%CDA%" == "%GETCDA%" (
						call %DOWNLOADSTOCKROMMESSAGE%
						call %CONTINUE%
						call %YESNO%
						choice /n /c:12 %1
						if errorlevel 1 set "downloadstockselect=1"
						if errorlevel 2 set "downloadstockselect=2"
					)
				) else if not "%BOX%" == "%GETBOX%" (
					call %DOWNLOADSTOCKROMMESSAGE%
					call %CONTINUE%
					call %YESNO%
					choice /n /c:12 %1
					if errorlevel 1 set "downloadstockselect=1"
					if errorlevel 2 set "downloadstockselect=2"
				)
			) else if not "%BOOT%" == "%GETBOOT%" (
				call %DOWNLOADSTOCKROMMESSAGE%
				call %CONTINUE%
				call %YESNO%
				choice /n /c:12 %1
				if errorlevel 1 set "downloadstockselect=1"
				if errorlevel 2 set "downloadstockselect=2"
			)
		) else if not "%ABL%" == "%GETABL%" (
			call %DOWNLOADSTOCKROMMESSAGE%
			call %CONTINUE%
			call %YESNO%
			choice /n /c:12 %1
			if errorlevel 1 set "downloadstockselect=1"
			if errorlevel 2 set "downloadstockselect=2"
		)
	)
)

:: Check if 7Zip is installed
:: Check which package manager is used
:: Whats a package manager?? xD
:: But we need to check windows Version
if "%FASTBOOTNEEDED%" == "yes" (
	if "%optionselect%" == "1" (
		if "%downloadstockselect%" == "1" (
			if not "%ABL%" == "%GETABL%" (
				call %CHECKWINVER%
			) else if not "%BOOT%" == "%GETBOOT%" (
				call %CHECKWINVER%
			) else if not "%BOX%" == "%GETBOX%" (
				call %CHECKWINVER%
			) else if not "%CDA%" == "%GETCDA%%" (
				call %CHECKWINVER%
			) else if not "%DSP%" == "%GETDSP%" (
				call %CHECKWINVER%
			) else if not "%ELABEL%" == "%GETELABEL%" (
				call %CHECKWINVER%
			) else if not "%GPT0%" == "%GETGPT0%" (
				call %CHECKWINVER%
			) else if not "%HIDDEN%" == "%GETHIDDEN%" (
				call %CHECKWINVER%
			) else if not "%KEYSTORE%" == "%GETKEYSTORE%" (
				call %CHECKWINVER%
			) else if not "%LOGDUMP%" == "%GETLOGDUMP%" (
				call %CHECKWINVER%
			) else if not "%MISC%" == "%GETMISC%" (
				call %CHECKWINVER%
			) else if not "%MODEM%" == "%GETMODEM%" (
				call %CHECKWINVER%
			) else if not "%PERSIST%" == "%GETPERSIST%" (
				call %CHECKWINVER%
			) else if not "%SPLASH2%" == "%GETSPLASH2%" (
				call %CHECKWINVER%
			) else if not "%SSD%" == "%GETSSD%" (
				call %CHECKWINVER%
			) else if not "%SUTINFO%" == "%GETSUTINFO%" (
				call %CHECKWINVER%
			) else if not "%SYSTEM%" == "%SYSTEM%" (
				call %CHECKWINVER%
			) else if not "%SYSTEMOTHER%" == "%GETSYSTEMOTHER%" (
				call %CHECKWINVER%
			) else if not "%SYSTEMINFO%" == "%GETSYSTEMINFO%" (
				call %CHECKWINVER%
			) else if not "%XBL%" == "%GETXBL%" (
				call %CHECKWINVER%
			)
		) else if "%downloadstockselect%" == "2" (
			if not "%ABL%" == "%GETABL%" (
				call %ABORTSCRIPT%
			) else if not "%BOOT%" == "%GETBOOT%" (
				call %ABORTSCRIPT%
			) else if not "%BOX%" == "%GETBOX%" (
				call %ABORTSCRIPT%
			) else if not "%CDA%" == "%GETCDA%%" (
				call %ABORTSCRIPT%
			) else if not "%DSP%" == "%GETDSP%" (
				call %ABORTSCRIPT%
			) else if not "%ELABEL%" == "%GETELABEL%" (
				call %ABORTSCRIPT%
			) else if not "%GPT0%" == "%GETGPT0%" (
				call %ABORTSCRIPT%
			) else if not "%HIDDEN%" == "%GETHIDDEN%" (
				call %ABORTSCRIPT%
			) else if not "%KEYSTORE%" == "%GETKEYSTORE%" (
				call %ABORTSCRIPT%
			) else if not "%LOGDUMP%" == "%GETLOGDUMP%" (
				call %ABORTSCRIPT%
			) else if not "%MISC%" == "%GETMISC%" (
				call %ABORTSCRIPT%
			) else if not "%MODEM%" == "%GETMODEM%" (
				call %ABORTSCRIPT%
			) else if not "%PERSIST%" == "%GETPERSIST%" (
				call %ABORTSCRIPT%
			) else if not "%SPLASH2%" == "%GETSPLASH2%" (
				call %ABORTSCRIPT%
			) else if not "%SSD%" == "%GETSSD%" (
				call %ABORTSCRIPT%
			) else if not "%SUTINFO%" == "%GETSUTINFO%" (
				call %ABORTSCRIPT%
			) else if not "%SYSTEM%" == "%SYSTEM%" (
				call %ABORTSCRIPT%
			) else if not "%SYSTEMOTHER%" == "%GETSYSTEMOTHER%" (
				call %ABORTSCRIPT%
			) else if not "%SYSTEMINFO%" == "%GETSYSTEMINFO%" (
				call %ABORTSCRIPT%
			) else if not "%XBL%" == "%GETXBL%" (
				call %ABORTSCRIPT%
			)
		)
	)
)

:: Check 7-Zip version
if "%FASTBOOTNEEDED%" == "no" (
	if "%optionselect%" == "1" (
		if "%downloadstockselect%" == "1" (
			call %ZIP7ZIPCHECKSHA%
			call %CHECK7ZIP%
		)
	)
)

:: Ask for download & install 7Zip
if "%ZIP7ZIPNEEDED%" == "yes" (
	call %DOWNLOAD7ZIPMESSAGE%
	choice /n /c:12 %1
	if errorlevel 1 set "zipquestion=1"
	if errorlevel 2 set "zipquestion=2"
)

:: Asking for downloading 7Zip when needed
if "%ZIP7ZIPNEEDED%" == "yes" (
	if "%zipquestion%" == "1" (
		call "%ASK7ZIPDOWNLOAD%"
		call "%CONTINUE%"
		call "%YESNO%"
		choice /n /c:12 %1
		if errorlevel 1 set "zipdownloadquestion=1"
		if errorlevel 2 set "zipdownloadquestion=2"
	) else  if "%zipquestion%" == "2" (	
		call %WRONG7ZIP%
		timeout /t 10
		call %ABORTSCRIPT%
	)
)

:: Download 7Zip
if "%ZIP7ZIPNEEDED%" == "yes" (
	if "%zipquestion%" == "1" (
		if "%zipdownloadquestion%" == "1" (
			if "%WINVER%" == "6" (
				call %UNTREBLELOGO%
				powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"	
				curl -L --connect-timeout 10 %UNGHURL%/%UNGHREPO%/%UNGHDLURL%/%UNGHTAG%/%ZIP7ZIP% --output %ZIP7ZIP%
				set "CHECKSUM=80C8DDB819A6EC7EE4D71D1F8D4650F757D6B85A792AC76F22511C8BBB30BF3A"
				for /f "usebackq" %%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%ZIP7ZIP%' | Select-Object -ExpandProperty Hash"`) do set GETCHECKSUM=%%A
			) else if "%WINVER%" == "10" (
				call %UNTREBLELOGO%
				powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"	
				curl -L --connect-timeout 10 %UNGHURL%/%UNGHREPO%/%UNGHDLURL%/%UNGHTAG%/%ZIP7ZIP% --output %ZIP7ZIP%
				set "CHECKSUM=80C8DDB819A6EC7EE4D71D1F8D4650F757D6B85A792AC76F22511C8BBB30BF3A"
				for /f "usebackq" %%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%ZIP7ZIP%' | Select-Object -ExpandProperty Hash"`) do set GETCHECKSUM=%%A
			)
		) else if "%zipdownloadquestion%" == "2" (
			call %WRONG7ZIP%
			timeout /t 10
			call %ABORTSCRIPT%
		)	
	)
)


:: Install 7Zip
if "%ZIP7ZIPNEEDED%" == "yes" (
    if "%zipquestion%" == "1" (
        if "%zipdownloadquestion%" == "1" (
            if "%CHECKSUM%" == "%GETCHECKSUM%" (
                if "%WINVER%" == "6" (
                    call %UNTREBLELOGO%
                    powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"	
                    powershell -command "Expand-Archive -Path '%ZIP7ZIP%' -DestinationPath '7zip'"
					del %ZIP7ZIP%
                )else if "%WINVER%" == "10" (
                    call %UNTREBLELOGO%
                    powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"	
                    powershell -command "Expand-Archive -Path '%ZIP7ZIP%' -DestinationPath '7zip'"
					del %ZIP7ZIP%
                )
            ) else if not "%CHECKSUM%" == "%GETCHECKSUM%" (
				call "%BROKEN7ZARCHIVE%"
				timeout /t 10
				call "%ABORTSCRIPT%"
			)
        )
    )
)

:: Check if 7Zip is installed sucessfully
if "%ZIP7ZIPNEEDED%" == "yes" (
    if "%zipquestion%" == "1" (
        if "%zipdownloadquestion%" == "1" (
			call %ZIP7ZIPCHECKSHA%
			call %CHECK7ZIP%
		)
	)
)

if "%downloadstockselect%" == "1" (
	if "%ZIP7ZIPNEEDED%" == "no" (
		timeout /t 0
	) else if "%ZIP7ZIPNEEDED%" == "yes" ( 
		call "%WRONG7ZIP%"
		timeout /t 10
		call %ABORTSCRIPT%
	)
)

:: Download Stock-ROM-Images 
if "%downloadstockselect%" == "1" (
	if "%ZIP7ZIPNEEDED%" == "no" (
		call %UNTREBLELOGO%
		powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"	
		curl -L --connect-timeout 10 %UNGHURL%/%UNGHREPO%/%UNGHDLURL%/%UNGHTAG%/Stock.7z --output Stock.7z
		set "CHECKSUM=371D7C8555064E1D00936C5EA605979EB1547B87C42D43EB959328C75A3D06A7"
		for /f "usebackq" %%A in (`powershell -command "Get-FileHash -Algorithm SHA256 'Stock.7z' | Select-Object -ExpandProperty Hash"`) do set GETCHECKSUM=%%A
	)
)

:: Check & unpack Stock-ROM
if "%downloadstockselect%" == "1" (
	if "%ZIP7ZIPNEEDED%" == "no" (
		if "%CHECKSUM%" == "%GETCHECKSUM%" (
			rmdir /s /q ROM
			powershell -command "7zip/7z.exe x 'Stock.7z' -oROM
			call %CHECKSTOCKIMAGES%
			del Stock.7z
		) else if not "%CHECKSUM%" == "%GETCHECKSUM%" (
			call %BROKENARCHIVE%
			timeout /t 5
			call %ABORTSCRIPT%
		)
	)
)	


:: Ask for download GPT-Table
if "%optionselect%" == "2" (			
	if "%GPT0%" == "%GETGPT0%" (
		timeout /t 0
	) else if not "%GPT0%" == "%GETGPT0%" (
		call "%DOWNLOADGPT0MESSAGE%"
		call "%CONTINUE%"
		call "%YESNO%"
		choice /n /c:12 %1
		if errorlevel 1 set "gpt0downloadquestion=1"
		if errorlevel 2 set "gpt0downloadquestion=2"
	)	
)		

:: Download GPT-Table
if "%optionselect%" == "2" (			
	if "%GPT0%" == "%GETGPT0%" (
		timeout /t 0
	) else if not "%GPT0%" == "%GETGPT0%" (
		if "%gpt0downloadquestion%" == "1" (
			call "%UNTREBLELOGO%"
			mkdir ROM
			powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"	
			curl -L --connect-timeout 10 %UNGHURL%/%UNGHREPO%/%UNGHDLURL%/%UNGHTAG%/gpt_both0_Stock.bin --output ROM/gpt_both0.bin
		) else if "%gpt0downloadquestion%" == "2" (
			call %ABORTSCRIPT%
		)
	)	
)	
	
:: Check GPT-Table for corruption
if "%optionselect%" == "2" (
	call %STOCKGPTGETSHA%
)

if "%optionselect%" == "2" (
	if "%SHA256SUMGPT0%" == "%GETSHA256SUMGPT0%" (
		call %GOODGPT%
		timeout /t 5
		set "FLASHMODE=GPT"
	) else if not "%SHA256SUMGPT0%" == "%GETSHA256SUMGPT0%" (
		call "%BROKENGPT%
		timeout /t 10
		call %ABORTSCRIPT
	)
)	

:: Check Stock-ROM files
if "%optionselect%" == "1" (
	if "%ABL%" == "%GETABL%" (
		if "%BOOT%" == "%GETBOOT%" (
			if "%BOX%" == "%GETBOX%" (
				if "%CDA%" == "%GETCDA%" (
					if "%DSP%" == "%GETDSP%" (
						if "%ELABEL%" == "%GETELABEL%" (
							if "%GPT0%" == "%GETGPT0%" (
								if "%HIDDEN%" == "%GETHIDDEN%" (
									if "%KEYSTORE%" == "%GETKEYSTORE%" (
										if "%LOGDUMP%" == "%GETLOGDUMP%" (
											if "%MISC%" == "%GETMISC%" (
												if "%MODEM%" == "%GETMODEM%" (
													if "%PERSIST%" == "%GETPERSIST%" (
														if "%SPLASH2%" == "%GETSPLASH2%" (
															if "%SSD%" == "%GETSSD%" (
																if "%SUTINFO%" == "%GETSUTINFO%" (
																	if "%SYSTEM%" == "%GETSYSTEM%" (
																		if "%SYSTEMOTHER%" == "%GETSYSTEMOTHER%" (
																			if "%SYSTEMINFO%" == "%GETSYSTEMINFO%" (
																				if "%XBL%" == "%GETXBL%" (
																					call %GOODSTOCK%
																					set "FLASHMODE=Stock"
																					timeout /t 5
																				) else if not "%XBL%" == "%GETXBL%" (
																					call %BROKENSTOCK%
																					timeout /t 10
																					call %ABORTSCRIPT%
																				)
																			) else if not "%SYSTEMINFO%" == "%GETSYSTEMINFO%" (
																				call %BROKENSTOCK%
																				timeout /t 10
																				call %ABORTSCRIPT%
																			)
																		) else if not "%SYSTEMOTHER%" == "%GETSYSTEMOTHER%" (
																			call %BROKENSTOCK%
																			timeout /t 10
																			call %ABORTSCRIPT%
																		)
																	) else if not "%SYSTEM%" == "%GETSYSTEM%" (
																		call %BROKENSTOCK%
																		timeout /t 10
																		call %ABORTSCRIPT%
																	)
																) else if not "%SUTINFO%" == "%GETSUTINFO%" (
																	call %BROKENSTOCK%
																	timeout /t 10
																	call %ABORTSCRIPT%
																)
															) else if not "%SSD%" == "%GETSSD%" (
																call %BROKENSTOCK%
																timeout /t 10
																call %ABORTSCRIPT%
															)
														) else if not "%SPLASH2%" == "%GETSPLASH2%" (
															call %BROKENSTOCK%
															timeout /t 10
															call %ABORTSCRIPT%
														)
													) else if not "%PERSIST%" == "%GETPERSIST%" (
														call %BROKENSTOCK%
														timeout /t 10
														call %ABORTSCRIPT%
													)
												) else if not "%MODEM%" == "%GETMODEM%" (
													call %BROKENSTOCK%
													timeout /t 10
													call %ABORTSCRIPT%
												)
											) else if not "%MISC%" == "%GETMISC%" (
												call %BROKENSTOCK%
												timeout /t 10
												call %ABORTSCRIPT%
											)
										) else if not "%LOGDUMP%" == "%GETLOGDUMP%" (
											call %BROKENSTOCK%
											timeout /t 10
											call %ABORTSCRIPT%
										)
									) else if not "%KEYSTORE%" == "%GETKEYSTORE%" (
										call %BROKENSTOCK%
										timeout /t 10
										call %ABORTSCRIPT%
									)
								) else if not "%HIDDEN%" == "%GETHIDDEN%" (
									call %BROKENSTOCK%
									timeout /t 10
									call %ABORTSCRIPT%
								)
							) else if not "%GPT0%" == "%GETGPT0%" (
								call %BROKENSTOCK%
								timeout /t 10
								call %ABORTSCRIPT%
							)
						) else if not "%ELABEL%" == "%GETELABEL%" (
							call %BROKENSTOCK%
							timeout /t 10
							call %ABORTSCRIPT%
						)
					) else if not "%DSP%" == "%GETDSP%" (
						call %BROKENSTOCK%
						timeout /t 10
						call %ABORTSCRIPT%
					)
				) else if not "%CDA%" == "%GETCDA%" (
					call %BROKENSTOCK%
					timeout /t 10
					call %ABORTSCRIPT%
				)
			) else if not "%BOX%" == "%GETBOX%" (
				call %BROKENSTOCK%
				timeout /t 10
				call %ABORTSCRIPT%
			)
		) else if not "%BOOT%" == "%GETBOOT%" (
			call %BROKENSTOCK%
			timeout /t 10
			call %ABORTSCRIPT%
		)
	) else if not "%ABL%" == "%GETABL%" (
		call %BROKENSTOCK%
		timeout /t 10
		call %ABORTSCRIPT%
	) 	
)																					

:: Welcome-Screen
call %WELCOMESCREEN%

:: Warning-Screen 1
call %WARNINGSCREEN1%

:: Warning screen 2
call %WARNINGSCREEN2%

:: Ask for flash Stock-ROM // GPT-Table
if "%FLASHMODE%" == "Stock" (
	call %ASKFORSTOCK%
	call %YESNO%
	choice /n /c:12 %1
	if errorlevel 1 set "askromgpt=1"
	if errorlevel 2 set "askromgpt=2"
) else if "%FLASHMODE%" == "GPT" (
	call %ASKFORGPT%
	call %YESNO%
	choice /n /c:12 %1
	if errorlevel 1 set "askromgpt=1"
	if errorlevel 2 set "askromgpt=2"
)

:: Ask for be sure to flash Stock-ROM //GPT-Table
if "%askromgpt%" == "1" (
	if "%FLASHMODE%" == "Stock" (
		call %FLASHSSURE%
		call %YESNO%
		choice /n /c:12 %1
		if errorlevel 1 set "askflashsure=1"
		if errorlevel 2 set "askflashsure=2"
	) else if "%FLASHMODE%" == "GPT" (
		call %FLASHSSURE%
		call %YESNO%
		choice /n /c:12 %1
		if errorlevel 1 set "askflashsure=1"
		if errorlevel 2 set "askflashsure=2"
	)	
) else if "%askromgpt%" == "2" (
	call %ABORTSCRIPT%
)

:: Instruction
if "%askromgpt%" == "1" (
	if "%askflashsure%" == "1" (
		if "%FLASHMODE%" == "Stock" (
			call %INSTRUCTION%
			choice /n /c:F %1
			if errorlevel 1 set "proceedflash=F"
		) else if "%FLASHMODE%" == "GPT" (
			call %INSTRUCTION%
			choice /n /c:F %1
			if errorlevel 1 set "proceedflash=F"
		)
	)	
)

:: Last warning screen
if "%askromgpt%" == "1" (
	if "%askflashsure%" == "1" (
		if "%proceedflash%" == "F" (
			if "%FLASHMODE%" == "Stock" (
				set "FLASHREADY=yes"
				call %LASTWARNINGSTOCK%
			) else if "%FLASHMODE%" == "GPT" (
				set "FLASHREADY=yes"
				call %LASTWARNINGGPT%
			)
		)
	)
)

:: Get Serialnumber
if "%FLASHMODE%" == "Stock" (
	if "%FLASHREADY%" == "yes" (
		call %GETSERIALNO%
	)
) else 	if "%FLASHMODE%" == "GPT" (
	if "%FLASHREADY%" == "yes" (
		call %GETSERIALNO%
	)
)

:: Check if device if NB1
if "%FLASHREADY%" == "yes" (
	if "%FLASHMODE%" == "Stock" (	
		call %CHECKDEVICE%
	) else if "%FLASHMODE%" == "GPT" (
		call %CHECKDEVICE%
	)	
)		

:: Check if bootloader is unlocked
if "%DEVICEIS%" == "NB1" (
	if "%FLASHREADY%" == "yes" (
		if "%FLASHMODE%" == "Stock" (
			call %BOOTLOADERUNLOCK%
		) else if "%FLASHMODE%" == "GPT" (
			call %BOOTLOADERUNLOCK%
		)	
	)
)

if "%DEVICEIS%" == "NB1" (
	if "%FLASHREADY%" == "yes" (
		if "%FLASHMODE%" == "Stock" (
			if "%CHECKBOOTLOADERUNLOCK%" == "%UNLOCKED%" (
				call %UNTREBLELOGO%
				call %BOOTLOADERUNLOCKMESSAGE%
				timeout /t 2
				powershell -command "& {Write-Host 'Bootloader is unlocked :-)' -ForegroundColor Green -BackgroundColor White}"
				timeout /t 3
			) else if "%CHECKBOOTLOADERUNLOCK%" == "%LOCKED%" (
				call %UNTREBLELOGO%
				call %BOOTLOADERUNLOCKMESSAGE%
				timeout /t 2
				powershell -command "& {Write-Host 'Bootloader is locked :-(' -ForegroundColor Red -BackgroundColor White}"
				timeout /t 3
				call %ABORTSCRIPT%
			)	
		)  else if "%FLASHMODE%" == "GPT" (
			if "%CHECKBOOTLOADERUNLOCK%" == "%UNLOCKED%" (
				call %UNTREBLELOGO%
				call %BOOTLOADERUNLOCKMESSAGE%
				timeout /t 2
				powershell -command "& {Write-Host 'Bootloader is unlocked :-)' -ForegroundColor Green -BackgroundColor White}"
				timeout /t 3
			) else if "%CHECKBOOTLOADERUNLOCK%" == "%LOCKED%" (
				call %UNTREBLELOGO%
				call %BOOTLOADERUNLOCKMESSAGE%
				timeout /t 2
				powershell -command "& {Write-Host 'Bootloader is locked :-(' -ForegroundColor Red -BackgroundColor White}"
				timeout /t 3
				call %ABORTSCRIPT%
			)	
		)	
	)
) 

:: Check if bootloader is critical unlocked
if "%DEVICEIS%" == "NB1" (
	if "%FLASHREADY%" == "yes" (
		if "%CHECKBOOTLOADERUNLOCK%" == "%UNLOCKED%" (
			if "%FLASHMODE%" == "Stock" (
				call %BOOTLOADERCRITICALUNLOCK%
			) else if "%FLASHMODE%" == "GPT" (
				call %BOOTLOADERCRITICALUNLOCK%
			)	
		)
	)	
)		

if "%FLASHREADY%" == "yes" (
	if "%FLASHMODE%" == "Stock" (
		if "%CHECKBOOTLOADERCRITICALUNLOCK%" == "%UNLOCKED%" (
			call %UNTREBLELOGO%
			call %BOOTLOADERCRITICALUNLOCKMESSAGE%
			timeout /t 2
			powershell -command "& {Write-Host 'Bootloader is critical unlocked :-)' -ForegroundColor Green -BackgroundColor White}"
			timeout /t 3
			set "UNLOCKED=yes"
		) else if "%CHECKBOOTLOADERCRITICALUNLOCK%" == "%LOCKED%" (
			call %UNTREBLELOGO%
			call %BOOTLOADERCRITICALUNLOCKMESSAGE%
			timeout /t 2
			powershell -command "& {Write-Host 'Bootloader is critical locked :-(' -ForegroundColor Red -BackgroundColor White}"
			timeout /t 3			
			call %ABORTSCRIPT%
		)
	) else if "%FLASHMODE%" == "GPT" (
		if "%CHECKBOOTLOADERCRITICALUNLOCK%" == "%UNLOCKED%" (
			call %UNTREBLELOGO%
			call %BOOTLOADERCRITICALUNLOCKMESSAGE%
			timeout /t 2
			powershell -command "& {Write-Host 'Bootloader is critical unlocked :-)' -ForegroundColor Green -BackgroundColor White}"
			timeout /t 3
			set "UNLOCKED=yes"
		) else if "%CHECKBOOTLOADERCRITICALUNLOCK%" == "%LOCKED%" (
			call %UNTREBLELOGO%
			call %BOOTLOADERCRITICALUNLOCKMESSAGE%
			timeout /t 2
			powershell -command "& {Write-Host 'Bootloader is critical locked :-(' -ForegroundColor Red -BackgroundColor White}"
			timeout /t 3			
			call %ABORTSCRIPT%
		)
	)
)

:: Flash bootloader
if "%FLASHMODE%" == "Stock" (
	if "%FLASHREADY%" == "yes" (
		if "%UNLOCKED%" == "yes" (
			call %FLASHBOOTLOADER%
		)	
	)
)	

:: Reboot to bootloader after flashing Bootloader
if "%FLASHMODE%" == "Stock" (
	if "%FLASHREADY%" == "yes" (
		if "%UNLOCKED%" == "yes" (
			call %REBOOT_BOOTLOADER%
		)
	)
)

:: Flash GPT-Table
if "%FLASHREADY%" == "yes" (
	if "%UNLOCKED%" == "yes" (
		if "%FLASHMODE%" == "Stock" (
			call %FLASHGPT%
		) else if "%FLASHMODE%" == "GPT" (
			call %FLASHGPT%
		)
	)
)

:: Reboot to bootloader after flashing Bootloader
if "%FLASHREADY%" == "yes" (
	if "%UNLOCKED%" == "yes" (
		if "%FLASHMODE%" == "Stock" (
			call %REBOOT_BOOTLOADER%
		) else if "%FLASHMODE%" == "GPT" (
			call %REBOOT_BOOTLOADER%
		)
	)
)

:: Flash Stock-ROM-Images
if "%FLASHMODE%" == "Stock" (
	if "%FLASHREADY%" == "yes" (
		if "%UNLOCKED%" == "yes" (
			call %FLASHSTOCKIMAGES%
		)
	)
)

:: Well done
if "%FLASHREADY%" == "yes" (
	if "%UNLOCKED%" == "yes" (
		if "%FLASHMODE%" == "Stock" (
			call %WELLDONE%
		) else if "%FLASHMODE%" == "GPT" (
			call %WELLDONE%
		)
	)
)

:: Set boot-slot to slot A
if "%FLASHREADY%" == "yes" (
	if "%UNLOCKED%" == "yes" (
		if "%FLASHMODE%" == "Stock" (
			call %SETBOOTSLOT%
		) else if "%FLASHMODE%" == "GPT" (
			call %SETBOOTSLOT%
		)
	)
)

:: Erase Userdata
if "%FLASHMODE%" == "Stock" (
	if "%FLASHREADY%" == "yes" (
		if "%UNLOCKED%" == "yes" (
			call %ERASEUSERDATA%
		)
	)
)	

:: Reboot to system after flashing images
if "%FLASHMODE%" == "Stock" (
	if "%FLASHREADY%" == "yes" (
		if "%UNLOCKED%" == "yes" (
			call %REBOOT_SYSTEM%
		)
	)
)	

:: Finish :-D
if "%FLASHREADY%" == "yes" (
	if "%UNLOCKED%" == "yes" (
		if "%FLASHMODE%" == "Stock" (
			call %FINISHSTOCK%
		) else if "%FLASHMODE%" == "GPT" (
			call %FINISHGPT%
		)
	)
)
