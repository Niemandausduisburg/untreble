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
:: Not working :-(
REM mode con: cols=105 lines=30

:: LOGOS
:: T-Virus Logo
set "LOGO=LOGO.bat"
(
	echo cls
	echo setlocal enabledelayedexpansion
	echo set "logo1=___________     ____   ____.__                      ________     _______   "
	echo set "logo2=\__    ___/     \   \ /   /|__|______ __ __  ______ \_____  \    \   _  \  "
	echo set "logo3=  |    |  ______ \   Y   / |  \_  __ \  |  \/  ___/   _(__  <    /  /_\  \ "
	echo set "logo4=  |    | /_____/  \     /  |  ||  | \/  |  /\___ \   /       \   \  \_/   \"
	echo set "logo5=  |____|           \___/   |__||__|  |____//____  > /______  / /\ \_____  /"
	echo set "logo6=                                                \/         \/  \/       \/ "
	echo for %%%%T in ^(logo1 logo2 logo3 logo4 logo5 logo6^) do ^(powershell -command "& {Write-Host '!%%%%T!' -ForegroundColor Magenta -BackgroundColor White}"^)
	echo endlocal
) > "%LOGO%"

set "NOKIALOGO=NOKIALOGO.bat"
(	
	echo cls
	echo setlocal enabledelayedexpansion
	echo set "nokia1=░▒▓███████▓▒░ ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓██████▓▒░ " 
	echo set "nokia2=░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░" 
	echo set "nokia3=░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░" 
	echo set "nokia4=░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓█▓▒░▒▓████████▓▒░" 
	echo set "nokia5=░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░" 
	echo set "nokia6=░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░" 
	echo set "nokia7=░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░"
	echo for %%%%N in ^(nokia1 nokia2 nokia3 nokia4 nokia5 nokia6 nokia7^) do ^(powershell -command "& {Write-Host '!%%%%N!' -ForegroundColor Magenta -BackgroundColor White}"^)
	echo endlocal
) > "%NOKIALOGO%"

:: T-Virus-Github-Repo
set "TGHURL=https://github.com/Niemandausduisburg"
set "TGHREPO=t-virus-3.0"
set "TGHDLURL=releases/download"
set "TGHTAG=tvirus3.0-NB1-files"

:: Exit Script Variable
set "ABORTSCRIPT=ABORTSCRIPT.bat"
(
    echo @echo off
	echo color 0F
    echo cls
    echo exit 1
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
    echo set "CHECKWINVER=%%%%A"
	echo ^)
	echo if "%%CHECKWINVER%%"=="6" ^(
	echo set "WINVER=6"
	echo ^) else if "%%CHECKWINVER%%"=="10" ^(
	echo set "WINVER=10"
	echo ^)
) > "%CHECKWINVER%"

:: Check if Android-SDK-Tools are installed
set "ADBTOOLS=ADBTOOLS.bat"
(
	echo set "FASTBOOTPATH=adb/%%FASTBOOT%%"
	echo set "ADBPATH=adb/%%ADB%%"
	echo set "CHECKFASTBOOTPATH=if exist "adb/fastboot.exe"	
	echo set "CHECKADBPATH=if exist "adb/adb.exe"
) > "%ADBTOOLS%"

set "CHECKADBTOOLS=CHECKADBTOOLS.bat"
(
    echo @echo off
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Check if Android-SDK-Platform-Tools are installed.' -ForegroundColor Black -BackgroundColor White}"
	echo if exist "adb/adb.exe" ^(
	echo 	if exist "adb/fastboot.exe" ^(
	echo 		set "FASTBOOTNEEDED=no"
	echo 	^) else ^(
	echo			set "FASTBOOTNEEDED=yes"
	echo		^)
	echo ^) else ^(
	echo 	set "FASTBOOTNEEDED=yes"
	echo ^)
) > "%CHECKADBTOOLS%"

:: Stockimages
set "ABL=ROM/abl.elf"
set "BOOT=ROM/boot.img"
set "BOX=ROM/box.bin"
set "CDA=ROM/cda.img"
set "DSP=ROM/dsp.bin"
set "ELABEL=ROM/elabel.bin"
set "GPT0=ROM/gpt_both0.bin"
set "HIDDEN=ROM/hidden.img"
set "KEYSTORE=ROM/keystore.bin"
set "LOGDUMP=ROM/logdump.bin"
set "MISC=ROM/misc.bin"
set "MODEM=ROM/modem.bin"
set "PERSIST=ROM/persist.img"
set "SPLASH2=ROM/splash2.img"
set "SSD=ROM/ssd.bin"
set "SUTINFO=ROM/sutinfo.img"
set "SYSTEM=ROM/system.img"
set "SYSTEMOTHER=ROM/system_other.img"
set "SYSTEMINFO=ROM/systeminfo.img"
set "XBL=ROM/xbl.elf"

:: GPT
:: Should
set "GPTSTOCK=ROM/gpt_both0.bin"
:: Get
set "GETGPTSTOCK=if exist "ROM/gpt_both0.bin"

:: Stockimages destinations
set "CHECKSTOCKIMAGES=CHECKSTOCKIMAGES.bat"
(
	echo @echo off
	echo if exist "ROM/abl.elf" set "GETABL=ROM/abl.elf"
	echo if exist "ROM/boot.img" set "GETBOOT=ROM/boot.img"
	echo if exist "ROM/box.bin" set "GETBOX=ROM/box.bin"
	echo if exist "ROM/cda.img" set "GETCDA=ROM/cda.img"
	echo if exist "ROM/dsp.bin" set "GETDSP=ROM/dsp.bin"
	echo if exist "ROM/elabel.bin" set "GETELABEL=ROM/elabel.bin"
	echo if exist "ROM/gpt_both0.bin" set "GETGPT0=ROM/gpt_both0.bin"
	echo if exist "ROM/hidden.img" set "GETHIDDEN=ROM/hidden.img"
	echo if exist "ROM/keystore.bin" set "GETKEYSTORE=ROM/keystore.bin"
	echo if exist "ROM/logdump.bin" set "GETLOGDUMP=ROM/logdump.bin"
	echo if exist "ROM/misc.bin" set "GETMISC=ROM/misc.bin"
	echo if exist "ROM/modem.bin" set "GETMODEM=ROM/modem.bin"
	echo if exist "ROM/persist.img" set "GETPERSIST=ROM/persist.img"
	echo if exist "ROM/splash2.img" set "GETSPLASH2=ROM/splash2.img"
	echo if exist "ROM/ssd.bin" set "GETSSD=ROM/ssd.bin"
	echo if exist "ROM/sutinfo.img" set "GETSUTINFO=ROM/sutinfo.img"
	echo if exist "ROM/system.img" set "GETSYSTEM=ROM/system.img"
	echo if exist "ROM/system_other.img" set "GETSYSTEMOTHER=ROM/system_other.img"
	echo if exist "ROM/systeminfo.img" set "GETSYSTEMINFO=ROM/systeminfo.img"
	echo if exist "ROM/xbl.elf" set "GETXBL=ROM/xbl.elf"
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
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%ABL%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMABL=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%BOOT%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMBOOT=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%BOX%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMBOX=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%CDA%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMCDA=%%%%A
    echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%DSP%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMDSP=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%ELABEL%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMELABEL=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%GPT0%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMGPT0=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%HIDDEN%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMHIDDEN=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%KEYSTORE%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMKEYSTORE=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%LOGDUMP%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMLOGDUMP=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%MISC%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMMISC=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%MODEM%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMMODEM=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%PERSIST%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMPERSIST=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%SPLASH2%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMSPLASH2=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%SSD%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMSSD=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%SUTINFO%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMSUTINFO=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%SYSTEM%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMSYSTEM=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%SYSTEMOTHER%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMSYSTEMOTHER=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%SYSTEMINFO%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMSYSTEMINFO=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%XBL%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMXBL=%%%%A
) > "%STOCKGETSHA%"

:: StockGPT get SHA256SUM
set "STOCKGPTGETSHA=STOCKGPTGETSHA.bat"
(
	echo @echo off
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '%GPT0%' | Select-Object -ExpandProperty Hash"`^) do set GETSHA256SUMGPT0=%%%%A
) > "%STOCKGPTGETSHA%"

:: Check 7Zip Version
set "ZIP7ZIPSHA=de46f5ce87c3733bde1236b9f40171cd16dbbb37f234034540c9fb0311c442af"
set "Z7ZIPSHA=Z7ZIPSHA.bat"
(
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 '7zip/7z.exe' | Select-Object -ExpandProperty Hash"`^) do set ZIP7ZIPCHECKSHA=%%%%A
) > "%Z7ZIPSHA%"

set "CHECK7ZIP=CHECK7ZIP.bat"
(
	echo if "%%ZIP7ZIPSHA%%" == "%%ZIP7ZIPCHECKSHA%%" (
    echo set "ZIP7ZIPNEEDED=no"
	echo ^) else ^(
    echo set "ZIP7ZIPNEEDED=yes"
	echo ^)
) > "%CHECK7ZIP%"

set "WRONGARCHITECTURE=WRONGARCHITECTURE.bat"
(
    echo @echo off
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Wrong architecture :-(' -ForegroundColor Red -BackgroundColor White; Write-Host 'T-Virus is only for x86_64 (64Bit) architecture.' -ForegroundColor Red -BackgroundColor White; Write-Host '' -ForegroundColor Red -BackgroundColor White; Write-Host 'T-Virus will be closed after 10 seconds.' -ForegroundColor Red -BackgroundColor White}"
	echo timeout /t 10
	echo call %%ABORTSCRIPT%%
) > "%WRONGARCHITECTURE%"

:: Unsupported system
set "UNSUPPORTEDSYSTEM=UNSUPPORTEDSYSTEM.bat"
(
	echo @echo off
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Unsupported system detected :-(' -ForegroundColor Red -BackgroundColor White; Write-Host '' -ForegroundColor Magenta -BackgroundColor White; Write-Host 'Please report it here to get support:' -ForegroundColor Red -BackgroundColor White; Write-Host 'https://t.me/HMD_Nokia_8' -ForegroundColor Blue -BackgroundColor White}"
	echo timeout /t 10
	echo call %%ABORTSCRIPT%%
) > "%UNSUPPORTEDSYSTEM%"

:: Aptitude not supported
:: Windows is currently thinking what is Aptitude?

:: Broken Stock-ROM-Archive
set "BROKENARCHIVE=BROKENARCHIVE.bat"
(
	echo @echo off
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Seems like the Stock-ROM-archive is broken  :-(' -ForegroundColor Red -BackgroundColor White; Write-Host 'Please download it again.' -ForegroundColor Red -BackgroundColor White}"
) > "%BROKENARCHIVE%"

:: Broken 7Zip Archive
set "BROKEN7ZARCHIVE=BROKEN7ZARCHIVE.bat"
(
	echo @echo off
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host '7Zip installation package is broken :-(' -ForegroundColor Red -BackgroundColor White; Write-Host 'Please download it again.' -ForegroundColor Red -BackgroundColor White}"
) > "%BROKEN7ZARCHIVE%"

:: 7Zip Archive not able to install
set "WRONG7ZIP=WRONG7ZIP.bat"
(
	echo @echo off
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Could not install 7Zip which is required for T-Virus :-(' -ForegroundColor Red -BackgroundColor White; Write-Host 'Please try it again.' -ForegroundColor Red -BackgroundColor White}"
) > "%WRONG7ZIP%"

:: ADB-TOOLS not able to install
set "WRONGADBTOOLS=WRONGADBTOOLS.bat"
(
	echo @echo off
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Could not install Android-SDK-Platform-Tools which are required for T-Virus :-(' -ForegroundColor Red -BackgroundColor White; Write-Host 'Please try it again.' -ForegroundColor Red -BackgroundColor White}"
) > "%WRONGADBTOOLS%"

:: Broken ADB-Tools Archive
set "BROKENADBTOOLS=BROKENADBTOOLS.bat"
(
	echo @echo off
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Android-SDK-Platform-Tools installation package is broken :-(' -ForegroundColor Red -BackgroundColor White; Write-Host 'Please download it again.' -ForegroundColor Red -BackgroundColor White}"
) > "%BROKENADBTOOLS%"

:: Broken files in Stock-ROM
set "BROKENSTOCK=BROKENSTOCK.bat"
(
	echo @echo off
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Seems like some files from Stock-ROM are broken :-(' -ForegroundColor Red -BackgroundColor White; Write-Host 'Please delete the ROM folder and download the package again.' -ForegroundColor Red -BackgroundColor White}"
) > "%BROKENSTOCK%"

:: All files in Stock-ROM are fine
set "GOODSTOCK=GOODSTOCK.bat"
(
	echo @echo off
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'All files from Stock-ROM are fine :-)' -ForegroundColor Green -BackgroundColor White; Write-Host 'We can continue.' -ForegroundColor Green -BackgroundColor White}"
) > "%GOODSTOCK%"

:: Good GPT-Table
set "GOODGPT=GOODGPT.bat"
(
	echo @echo off
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'GPT-Table is fine:-)' -ForegroundColor Green -BackgroundColor White; Write-Host 'We can continue.' -ForegroundColor Green -BackgroundColor White}"
) > "%GOODGPT%"

:: Broken GPT-Table
set "BROKENGPT=BROKENGPT.bat"
(
	echo @echo off
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Seems like GPT-Table is broken :-(' -ForegroundColor Red -BackgroundColor White; Write-Host 'Please remove gpt_both0.bin in ROM folder and download it again.' -ForegroundColor Red -BackgroundColor White}"
) > "%BROKENGPT%"

:: SDK missing
set "NOSDK=NOSDK.bat"
(
	echo @echo off
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Android-SDK-Platform-Tools not found :-(' -ForegroundColor Red -BackgroundColor White; Write-Host ''; Write-Host 'They are required to use T-Virus.' -ForegroundColor Red -BackgroundColor White; Write-Host 'Do you want to download and install it?' -ForegroundColor Black -BackgroundColor White}"
	echo call %%YESNO%%
) > "%NOSDK%"

:: Download SDK
set "SDKSIZE=6,39MB"
set "SDKZIP=platform-tools_r35.0.2-windows.zip"

set "SDKMESSAGE=SDKMESSAGE.bat"
(
	echo @echo off
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo if "%%WINVER%%" == "%%CHECKWINVER%%" (
	echo powershell -command "& {Write-Host 'It will download and install Android-SDK-Platform-Tools ("%%SDKSIZE%%")' -ForegroundColor Red -BackgroundColor White}"
	echo call %%CONTINUE%%
	echo call %%YESNO%%
	echo ^) else ^(
    echo call "%%UNSUPPORTEDSYSTEM%%"
	echo ^)
) > "%SDKMESSAGE%"

:: Download 7Zip
set "DOWNLOAD7ZIPMESSAGE=DOWNLOAD7ZIPMESSAGE.bat"
(
	echo @echo off
	echo call %%CHECKWINVER%%
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo if "%%WINVER%%" == "%%CHECKWINVER%%" (
	echo powershell -command "& {Write-Host '7Zip not found or wrong version :-(' -ForegroundColor Red -BackgroundColor White; Write-Host '' -ForegroundColor Red -BackgroundColor White}; Write-Host 'It is required to unpack the stock ROM.' -ForegroundColor Red -BackgroundColor White; Write-Host 'Do you want to download and install it?' -ForegroundColor Black -BackgroundColor White"
	echo call %%YESNO%%
	echo ^) else ^(
    echo call %%UNSUPPORTEDSYSTEM%%
	echo ^)
) > "%DOWNLOAD7ZIPMESSAGE%"

:: 7Zip-Package Size
set "ZIP7ZIP=7z-24.08_Windows.zip"
set "SIZE7ZIP=2,41MB"

:: Ask for Download 7Zip 
set "ASK7ZIPDOWNLOAD=ASK7ZIPDOWNLOAD.bat"
(
	echo @echo off    
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'It will download and instal 7Zip 23.01 %%SIZE7ZIP%%' -ForegroundColor Red -BackgroundColor White}
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
	echo call %%LOGO%%
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
set "DOWNLAODSTOCKMESSAGE=DOWNLAODSTOCKMESSAGE.bat"
(
	echo @echo off    
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'It will download the Stock-ROM %%STOCKROMSIZE%%' -ForegroundColor Red -BackgroundColor White}"
) > "%DOWNLAODSTOCKMESSAGE%"

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
   echo call %%DEVICEISNB1%%
   echo ^) else ^(
   echo call %%DEVICEISNOTNB1%%
   echo ^)
) > "%CHECKDEVICE%"

:: Device is NB1
set "DEVICEISNB1=DEVICEISNB1.bat"
(
	echo @echo off    
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Device is a NB1' -ForegroundColor Green -BackgroundColor White; Write-Host 'We can continue :-)' -ForegroundColor Green -BackgroundColor White}"
    echo timeout /t 5
) > "%DEVICEISNB1%"

:: Device is not NB1
set "DEVICEISNOTNB1=DEVICEISNOTNB1.bat"
(
	echo @echo off    
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Device is not a NB1' -ForegroundColor Red -BackgroundColor White; Write-Host 'We can''t continue :-(' -ForegroundColor Red -BackgroundColor White; Write-Host '' -ForegroundColor Red -BackgroundColor White; Write-Host 'Script will be closed now.' -ForegroundColor Red -BackgroundColor White}"
	echo timeout /t 10
	echo call %%ABORTSCRIPT%%
) > "%DEVICEISNOTNB1%"

:: Check if Bootloader is unlocked
set "BOOTLOADERUNLOCK=BOOTLOADERUNLOCK.bat"
(
    echo @echo off
	echo for /f "tokens=2 delims=: " %%%%A in ('powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% getvar unlocked 2>&1 | Select-String 'unlockeded: yes')"'^) do set "BOOTLOADERUNLOCK=%%%%A"
) > "%BOOTLOADERUNLOCK%"

:: Check if Bootloader is critical unlocked
set "BOOTLOADERCRITICALUNLOCK=BOOTLOADERCRITICALUNLOCK.bat"
(
	echo @echo off 
	echo for /f "usebackq tokens=*" %%%%A in (`powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flashing unlock_critical 2>&1 | ForEach-Object { $_ -replace '\s+', '' } | Select-String 'Devicealready:unlocked')"`^) do set "BOOTLOADERCRITICALUNLOCK=%%%%A"
) > "%BOOTLOADERCRITICALUNLOCK%"

:: Bootloader state
set "UNLOCKED1=unlocked: yes"
set "UNLOCKED2=FAILED(remote:'Devicealready:unlocked')"

:: Fastboot & Adb
set "FASTBOOT=adb/fastboot.exe"
set "ADB=adb/adb.exe"

:: Flash bootloader
set "FLASHBOOTLOADER=FLASHBOOTLOADER.bat"
(
	echo @echo off    
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Flashing bootloader' -ForegroundColor Black -BackgroundColor White}"
	echo timeout /t 2
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash abl_a ROM/abl.elf)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash xbl_a ROM/xbl.elf)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash abl_b ROM/abl.elf)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash xbl_b ROM/xbl.elf)"
) > "%FLASHBOOTLOADER%"

:: Flash Stock-Images
set "FLASHSTOCKIMAGES=FLASHSTOCKIMAGES.bat"
(
	echo @echo off    
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Flashing Stock ROM' -ForegroundColor Black -BackgroundColor White}"
	echo timeout /t 2
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash boot_a ROM/boot.img)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash boot_b ROM/boot.img)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash box ROM/box.bin)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash cda_a ROM/cda.img)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash cda_b ROM/cda.img)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash dsp_a ROM/dsp.bin)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash dsp_b ROM/dsp.bin)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash elabel ROM/elabel.bin)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash hidden_a ROM/hidden.img)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash hidden_b ROM/hidden.img)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash keystore ROM/keystore.bin)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash logdump ROM/logdump.bin)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash misc ROM/misc.bin)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash modem_a ROM/modem.bin)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash modem_b ROM/modem.bin)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash persist ROM/persist.img)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash splash2 ROM/splash2.img)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash ssd ROM/ssd.bin)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash sutinfo ROM/sutinfo.img)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash system_a ROM/system.img)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash system_b ROM/system_other.img)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash systeminfo_a ROM/systeminfo.img)"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash systeminfo_b ROM/systeminfo.img)"
) > "%FLASHSTOCKIMAGES%"

:: Set boot-slot
set "SETBOOTSLOT=SETBOOTSLOT.bat"
(
	echo @echo off    
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Switching to Slot A' -ForegroundColor Red -BackgroundColor White}"
	echo timeout /t 2
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% --set-active=a)"
) > "%SETBOOTSLOT%"

:: Erase Userdata
set "ERASEUSERDATA=ERASEUSERDATA.bat"
(
	echo @echo off    
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Erasing Userdata' -ForegroundColor Red -BackgroundColor White}"
	echo timeout /t 2
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% -w)"
) > "%ERASEUSERDATA%"

:: Reboot to bootloader
set "REBOOT_BOOTLOADER=REBOOT_BOOTLOADER.bat"
(
	echo @echo off    
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Rebooting device into download mode. DO NOT disconnect your device!' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% reboot bootloader)"
	echo timeout /t 5
) > "%REBOOT_BOOTLOADER%"

:: Reboot to system
set "REBOOT_SYSTEM=REBOOT_SYSTEM.bat"
(
	echo @echo off    
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Rebooting device into system. DO NOT disconnect your device!' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% reboot)"
	echo timeout /t 5
) > "%REBOOT_SYSTEM%"

:: Flash GPT-Table
set "FLASHGPT=FLASHGPT.bat"
(
	echo @echo off    
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Flashing stock partition-table"' -ForegroundColor Black -BackgroundColor White}"
	echo timeout /t 2
	echo powershell -command "(& %%FASTBOOT%% -s %%SERIAL%% flash partition:0 ROM/gpt_both0.bin)"
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
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'This will flash the Nokia stock ROM (Android 9 / 516A) on your device.' -ForegroundColor Black -BackgroundColor White}"
	echo timeout /t 5
	echo ^) else ^(
	if "%%FLASHMODE%%" == "GPT" ^(
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'This will flash the Nokia stock GPT-Table for you for flasing your device with NOST, OST LA, OSTRemote.' -ForegroundColor Black -BackgroundColor White}"
	echo timeout /t 5
	echo ^)
) > "%WELCOMESCREEN%"

:: Warning Screen 1
set "WARNINGSCREEN1=WARNINGSCREEN1.bat"
(
	echo if "%%FLASHMODE%%" == "Stock" ^(
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'WARNING!' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'MAKE A BACKUP FROM YOUR DATA!' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'ALL DATA WILL BE LOST AFTER FLASHING (FACTORY RESET)!' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'WE ACCEPT NO LIABILITY IF YOU LOSE DATA OR USE THIS TOOL INCORRECTLY!' -ForegroundColor Red -BackgroundColor White}"
	echo timeout /t 10
	echo ^) else if "%%FLASHMODE%%" == "GPT" ^(
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'WARNING!' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'MAKE A BACKUP FROM YOUR DATA!' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'ALL DATA WILL BE LOST AFTER FLASHING (FACTORY RESET)!' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'WE ACCEPT NO LIABILITY IF YOU LOSE DATA OR USE THIS TOOL INCORRECTLY!' -ForegroundColor Red -BackgroundColor White}"
	echo timeout /t 10
	echo ^)
) > "%WARNINGSCREEN1%"

:: Warning Screen 2
set "WARNINGSCREEN2=WARNINGSCREEN2.bat"
(
	echo if "%%FLASHMODE%%" == "Stock" ^(
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'WARNING!' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'FLASHING SOME PARTITIONS CAN TAKE SOME TIME (ABOUT 5 MINUTES).' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'DO NOT UNPLUG THE USB-CABLE OR CLOSE CMD OR YOU WILL BRICK YOUR DEVICE!!!' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'SOMETIMES CMD SEEMS TO BE FREZZING. DO NOT ABORT THE PROCESS AND STILL WAITING UNTIL THE PROCESS IS DONE.' -ForegroundColor Red -BackgroundColor White}"
	echo timeout /t 10
	echo ^)
) > "%WARNINGSCREEN2%"

:: Ask for flash Stock
set "ASKFORSTOCK=ASKFORSTOCK.bat"
(
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Are you sure you want to flash Stock ROM?' -ForegroundColor Black -BackgroundColor White}"
) >"%ASKFORSTOCK%"
	
:: Ask for flash GPT
set "ASKFORGPT=ASKFORGPT.bat"
(
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Are you sure you want to flash the stock GPT-Table?' -ForegroundColor Black -BackgroundColor White}"
) >"%ASKFORGPT%"

:: Ask for sure flash
set "FLASHSSURE=FLASHSSURE.bat"
(
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Have you read and understand the warnings and are you sure you want to proceed?' -ForegroundColor Black -BackgroundColor White}"
) >"%FLASHSSURE%"

:: Instruction
set "INSTRUCTION=INSTRUCTION.bat"
(
	echo call %%LOGO%%
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
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'ATTENTION!!!' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'THE WHOLE FLASHING PROCESS CAN TAKE UP TO 10 MINUTES.' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'LEAN BACK AND LET IT FLASHING.' -ForegroundColor Red -BackgroundColor White}"
	echo timeout /t 10
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Let''s flash and revert back to Stock-ROM :-)' -ForegroundColor Black -BackgroundColor White}"
	echo timeout /t 5
) >"%LASTWARNINGSTOCK%"

:: Last warning - Flash GPT
set "LASTWARNINGGPT=LASTWARNINGGPT.bat"
(
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Black -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Let''s flash and revert back to Stock-GPT-Table :-)' -ForegroundColor Black -BackgroundColor White}"
	echo timeout /t 5
) >"%LASTWARNINGGPT%"

:: Well done
set "WELLDONE=WELLDONE.bat"
(
	echo call %%LOGO%%
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
	echo exit 0
) >"%FINISHSTOCK%"

:: Finish flash GPT-Table
set "FINISHGPT=FINISHGPT.bat"
(
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Green -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Partition-Table successfully flashed :-)' -ForegroundColor Green -BackgroundColor White}"
	echo powershell -command "& {Write-Host '' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'You need to flash a Stock-Firmware with NOST or OST LA to boot your device!!!' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'I don''t recommend using OSTRemote or it will destroy your device :-(' -ForegroundColor Red -BackgroundColor White}"
	echo timeout /t 10
	echo cls
	echo color 0F
	echo exit 0
) >"%FINISHGPT%"

:: Ask for check for updates
set "ASKUPDATE=ASKUPDATE.bat"
(
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Green -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Do you want to check for updates?' -ForegroundColor Black -BackgroundColor White}"
	echo call %%YESNO%%
) >"%ASKUPDATE%"

:: Check for Update
set "CHECKFORUPDATE=CHECKFORUPDATE.bat"
(
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Green -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Check for updates' -ForegroundColor Black -BackgroundColor White}"
	echo timeout /t 2
	echo set "UPDTGHURL=https://raw.githubusercontent.com/Niemandausduisburg"
	echo set "UPDTGHREPO=untreble"
	echo set "UPDTGHDLURL=refs/heads"
	echo set "UPDTGHBRANCH=main"
	echo set "UPDTGHFILE=revert.bat"
	echo curl -L --connect-timeout 10 %%UPDTGHURL%%/%%UPDTGHREPO%%/%%UPDTGHDLURL%%/%%UPDTGHBRANCH%%/%%UPDTGHFILE%% --output temp.bat
) >"%CHECKFORUPDATE%"

:: Compare Scripts
set "COMPAREUPDATE=COMPAREUPDATE.bat"
(
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 'revert.bat' | Select-Object -ExpandProperty Hash"`^) do set REVERTOLD=%%%%A
	echo for /f "usebackq" %%%%A in (`powershell -command "Get-FileHash -Algorithm SHA256 'temp.bat' | Select-Object -ExpandProperty Hash"`^) do set REVERTNEW=%%%%A
) >"%COMPAREUPDATE%"

:: Ask for Update
set "ASKFORUPDATE=ASKFORUPDATE.bat"
(
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Green -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Do you want update?' -ForegroundColor Black -BackgroundColor White}"
	echo call %%YESNO%%
) >"%ASKFORUPDATE%"

:: After Update
set "AFTERUPDATE=AFTERUPDATE.bat"
(
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Green -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Update successfully :-)' -ForegroundColor Green -BackgroundColor White}"
	echo powershell -command "& {Write-Host '' -ForegroundColor Green -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'T-Virus will restart now.' -ForegroundColor Black -BackgroundColor White}"
	echo timeout /t 5
) >"%AFTERUPDATE%"

:: When no update is selected
set "SELCECTNOUPDATE=SELCECTNOUPDATE.bat"
(
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Don''t cry when something is not working.' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Joke xD' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'When something is not working check for Updates.' -ForegroundColor Red -BackgroundColor White}"
	echo timeout /t 5
) >"%SELCECTNOUPDATE%"

:: When no updated found
set "NOUPDATEFOUND=NOUPDATEFOUND.bat"
(
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'T-Virus is already up-to-date :-)' -ForegroundColor Green -BackgroundColor White}"
	echo powershell -command "& {Write-Host '' -ForegroundColor Green -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'T-Virus will continue now.' -ForegroundColor Black -BackgroundColor White}"
	echo timeout /t 5
) >"%NOUPDATEFOUND%"

:: Update T-Virus
set "UPDATE=UPDATE.bat"
(
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Update T-Virus...' -ForegroundColor Red -BackgroundColor White}"
	echo timeout /t 5
	echo rm revert.bat
	echo ren temp.bat revert.bat
	echo call %%LOGO%%
	echo powershell -command "& {Write-Host '' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Update done :-)' -ForegroundColor Green -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'T-Virus will restart now' -ForegroundColor Red -BackgroundColor White}"
	echo timeout /t 5
	echo start /b revert.bat
	echo exit 0
) >"%UPDATE%"
::-------------------------------------------------------------------------------------------------------------------------------------	
:: Start T-Virus
:: Prepare

:: Ask for checking for Update
call %ASKUPDATE%
choice /n /c:12 %1
if errorlevel 1 set "askusertoupdate=1"
if errorlevel 2 set "askusertoupdate=2"

if "%askusertoupdate%" == "1" (
call %CHECKFORUPDATE%
call %COMPAREUPDATE%
) else if "%askusertoupdate%" == "2" (
call %SELCECTNOUPDATE%
)

:: Ask for Update
echo %REVERTNEW%
echo %REVERTOLD%
pause

if not "%REVERTOLD%" == "%REVERTNEW%" (
call %ASKFORUPDATE%
choice /n /c:12 %1
if errorlevel 1 set "askuserupdate=1"
if errorlevel 2 set "askuserupdate=2"
) else (
call %NOUPDATEFOUND%
)

if "%askuserupdate%" == "1" (
call %Update%
) else (
call %SELCECTNOUPDATE%
)
