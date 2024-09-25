@echo off
chcp 65001
setlocal enabledelayedexpansion
color F0
cls


:: LOGO
:: Define the logo lines
set "logo1=___________     ____   ____.__                      ________     _______   "
set "logo2=\__    ___/     \   \ /   /|__|______ __ __  ______ \_____  \    \   _  \  "
set "logo3=  |    |  ______ \   Y   / |  \_  __ \  |  \/  ___/   _(__  <    /  /_\  \ "
set "logo4=  |    | /_____/  \     /  |  ||  | \/  |  /\___ \   /       \   \  \_/   \"
set "logo5=  |____|           \___/   |__||__|  |____//____  > /______  / /\ \_____  /"
set "logo6=                                                \/         \/  \/       \/ "

:: Output the T-Virus Logo
for %%A in (logo1 logo2 logo3 logo4 logo5 logo6) do (
powershell -command "& {Write-Host '!%%A!' -ForegroundColor Magenta -BackgroundColor White}"
)

:: Nokia Logo
:: Define the ASCII art lines
set "nokia1=░▒▓███████▓▒░ ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓██████▓▒░ " 
set "nokia2=░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░" 
set "nokia3=░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░" 
set "nokia4=░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓███████▓▒░░▒▓█▓▒░▒▓████████▓▒░" 
set "nokia5=░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░" 
set "nokia6=░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░" 
set "nokia7=░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░"

:: Output the NOKIA Logo
REM for %%N in (nokia1 nokia2 nokia3 nokia4 nokia5 nokia6 nokia7) do (
REM  powershell -command "& {Write-Host '!%%N!' -ForegroundColor Magenta -BackgroundColor White}"
REM     echo !%%N!
)

:: T-Virus-Github-Repo
set "TGHURL=https://github.com/Niemandausduisburg"
set "TGHREPO=t-virus-3.0"
set "TGHDLURL=releases/download"
set "TGHTAG=tvirus3.0-NB1-files"

:AbortScript
:: Create a temporary batch file with the abort commands
set "abort=%TEMP%\abortScript.bat"
(
    echo @echo off
	echo color 0F
    echo cls
    echo exit 1
) > "%abort%"

:: Check architecture
for /f "tokens=*" %%i in ('wmic OS get OSArchitecture ^| findstr /i "64-bit"') do (
    set "CHECKARCH=%%i"
)
:: Remove leading and trailing spaces from CHECKARCH
set "CHECKARCH=%CHECKARCH:~0,6%"
set "ISARCH=64-bit"

if "%CHECKARCH%" == "%ISARCH%" (
timeout /t 1
cls
for %%A in (logo1 logo2 logo3 logo4 logo5 logo6) do (
powershell -command "& {Write-Host '!%%A!' -ForegroundColor Magenta -BackgroundColor White}"
)
powershell -command "& {Write-Host '64-Bit system detected' -ForegroundColor Green -BackgroundColor White}
timeout /t 5 
) else (
timeout /t 1
cls
for %%A in (logo1 logo2 logo3 logo4 logo5 logo6) do (
powershell -command "& {Write-Host '!%%A!' -ForegroundColor Magenta -BackgroundColor White}"
)
powershell -command "& {Write-Host 'Wrong architecture :-(' -ForegroundColor Red -BackgroundColor White}
powershell -command "& {Write-Host 'T-Virus is only for x86_64 (64Bit) architecture.' -ForegroundColor Red -BackgroundColor White}
timeout /t 10
call "%abort%"
)

:: Check if Android-SDK-Tools are installed
:: Create a temporary batch file with the adb-tools check commands
set "checkfastboot=check_fastboot.bat"

(
    echo @echo off
    echo cls
    echo for %%%%A in ^(logo1 logo2 logo3 logo4 logo5 logo6^) do ^(
    echo powershell -command "& {Write-Host '!%%%%A!' -ForegroundColor Magenta -BackgroundColor White}"
    echo ^)
    echo powershell -command "& {Write-Host 'Check if Android-SDK-Platform-Tools are installed.' -ForegroundColor Black -BackgroundColor White}"
    echo timeout /t 3
    echo if exist "adb/fastboot.exe" ^(
    echo     set "FASTBOOTNEEDED=no"
    echo ^) else ^(
    echo     set "FASTBOOTNEEDED=yes"
    echo ^)
    echo if exist "adb/adb.exe" ^(
    echo     set "FASTBOOTNEEDED=no"
    echo ^) else ^(
    echo     set "FASTBOOTNEEDED=yes"
    echo ^)
) > "%checkfastboot%"

call "%checkfastboot%"

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
set "checkgpt=check_gpt.bat"
(
    echo @echo off
	echo set "GPTSTOCK=ROM/gpt_both0.bin"
	echo if exist "ROM/gpt_both0.bin" ^(
	echo set "GPT=Stock"
	echo ^)
) > "%checkgpt%"

:: Stockimages destinations
set "checkstockimages=check_stock.bat"
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
) > "%checkstockimages%"

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
set "stockgetsha=stockgetsha.bat"
(
	echo @echo off
	echo FOR /F "usebackq" %%%%A IN (`powershell -command "Get-FileHash -Algorithm SHA256 '%ABL%' | Select-Object -ExpandProperty Hash"`^) DO SET GETSHA256SUMABL=%%%%A
	echo FOR /F "usebackq" %%%%A IN (`powershell -command "Get-FileHash -Algorithm SHA256 '%BOOT%' | Select-Object -ExpandProperty Hash"`^) DO SET GETSHA256SUMBOOT=%%%%A
	echo FOR /F "usebackq" %%%%A IN (`powershell -command "Get-FileHash -Algorithm SHA256 '%BOX%' | Select-Object -ExpandProperty Hash"`^) DO SET GETSHA256SUMBOX=%%%%A
	echo FOR /F "usebackq" %%%%A IN (`powershell -command "Get-FileHash -Algorithm SHA256 '%CDA%' | Select-Object -ExpandProperty Hash"`^) DO SET GETSHA256SUMCDA=%%%%A
    echo FOR /F "usebackq" %%%%A IN (`powershell -command "Get-FileHash -Algorithm SHA256 '%DSP%' | Select-Object -ExpandProperty Hash"`^) DO SET GETSHA256SUMDSP=%%%%A
	echo FOR /F "usebackq" %%%%A IN (`powershell -command "Get-FileHash -Algorithm SHA256 '%ELABEL%' | Select-Object -ExpandProperty Hash"`^) DO SET GETSHA256SUMELABEL=%%%%A
	echo FOR /F "usebackq" %%%%A IN (`powershell -command "Get-FileHash -Algorithm SHA256 '%GPT0%' | Select-Object -ExpandProperty Hash"`^) DO SET GETSHA256SUMGPT0=%%%%A
	echo FOR /F "usebackq" %%%%A IN (`powershell -command "Get-FileHash -Algorithm SHA256 '%HIDDEN%' | Select-Object -ExpandProperty Hash"`^) DO SET GETSHA256SUMHIDDEN=%%%%A
	echo FOR /F "usebackq" %%%%A IN (`powershell -command "Get-FileHash -Algorithm SHA256 '%KEYSTORE%' | Select-Object -ExpandProperty Hash"`^) DO SET GETSHA256SUMKEYSTORE=%%%%A
	echo FOR /F "usebackq" %%%%A IN (`powershell -command "Get-FileHash -Algorithm SHA256 '%LOGDUMP%' | Select-Object -ExpandProperty Hash"`^) DO SET GETSHA256SUMLOGDUMP=%%%%A
	echo FOR /F "usebackq" %%%%A IN (`powershell -command "Get-FileHash -Algorithm SHA256 '%MISC%' | Select-Object -ExpandProperty Hash"`^) DO SET GETSHA256SUMMISC=%%%%A
	echo FOR /F "usebackq" %%%%A IN (`powershell -command "Get-FileHash -Algorithm SHA256 '%MODEM%' | Select-Object -ExpandProperty Hash"`^) DO SET GETSHA256SUMMODEM=%%%%A
	echo FOR /F "usebackq" %%%%A IN (`powershell -command "Get-FileHash -Algorithm SHA256 '%PERSIST%' | Select-Object -ExpandProperty Hash"`^) DO SET GETSHA256SUMPERSIST=%%%%A
	echo FOR /F "usebackq" %%%%A IN (`powershell -command "Get-FileHash -Algorithm SHA256 '%SPLASH2%' | Select-Object -ExpandProperty Hash"`^) DO SET GETSHA256SUMSPLASH2=%%%%A
	echo FOR /F "usebackq" %%%%A IN (`powershell -command "Get-FileHash -Algorithm SHA256 '%SSD%' | Select-Object -ExpandProperty Hash"`^) DO SET GETSHA256SUMSSD=%%%%A
	echo FOR /F "usebackq" %%%%A IN (`powershell -command "Get-FileHash -Algorithm SHA256 '%SUTINFO%' | Select-Object -ExpandProperty Hash"`^) DO SET GETSHA256SUMSUTINFO=%%%%A
	echo FOR /F "usebackq" %%%%A IN (`powershell -command "Get-FileHash -Algorithm SHA256 '%SYSTEM%' | Select-Object -ExpandProperty Hash"`^) DO SET GETSHA256SUMSYSTEM=%%%%A
	echo FOR /F "usebackq" %%%%A IN (`powershell -command "Get-FileHash -Algorithm SHA256 '%SYSTEMOTHER%' | Select-Object -ExpandProperty Hash"`^) DO SET GETSHA256SUMSYSTEMOTHER=%%%%A
	echo FOR /F "usebackq" %%%%A IN (`powershell -command "Get-FileHash -Algorithm SHA256 '%SYSTEMINFO%' | Select-Object -ExpandProperty Hash"`^) DO SET GETSHA256SUMSYSTEMINFO=%%%%A
	echo FOR /F "usebackq" %%%%A IN (`powershell -command "Get-FileHash -Algorithm SHA256 '%XBL%' | Select-Object -ExpandProperty Hash"`^) DO SET GETSHA256SUMXBL=%%%%A
) > "%stockgetsha%"

:: StockGPT get SHA256SUM
set "stockgptgetsha=stockgptgetsha.bat"
(
	echo @echo off
	echo FOR /F "usebackq" %%%%A IN (`powershell -command "Get-FileHash -Algorithm SHA256 '%GPT0%' | Select-Object -ExpandProperty Hash"`^) DO SET GETSHA256SUMGPT0=%%%%A
) > "%stockgptgetsha%"

:: Check 7Zip Version
set "ZIP7ZIPSHA=de46f5ce87c3733bde1236b9f40171cd16dbbb37f234034540c9fb0311c442af"
set "z7zipsha=z7zipsha.bat"
(
	echo FOR /F "usebackq" %%%%A IN (`powershell -command "Get-FileHash -Algorithm SHA256 '7zip/7z.exe' | Select-Object -ExpandProperty Hash"`^) DO SET ZIP7ZIPCHECKSHA=%%%%A
) > "%z7zipsha%"

set "check7zip=check7zip.bat"
(
	echo IF "%%ZIP7ZIPSHA%%" == "%%ZIP7ZIPCHECKSHA%%" (
    echo SET "ZIP7ZIPNEEDED=no"
	echo ^) ELSE ^(
    echo SET "ZIP7ZIPNEEDED=yes"
	echo ^)
) > "%check7zip%"

:: All Messages:
:: Unsupported architecture
set "UNSUPPORTEDSYSTEM=UNSUPPORTEDSYSTEM.bat"
(
    echo @echo off
	echo cls
	echo for %%%%A in ^(logo1 logo2 logo3 logo4 logo5 logo6^) do ^(
	echo powershell -command "& {Write-Host '!%%%%A!' -ForegroundColor Magenta -BackgroundColor White}"
	echo ^)
	echo powershell -command "& {Write-Host '' -ForegroundColor Magenta -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'Wrong architecture :-(' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host 'T-Virus is only for x86_64 (64Bit) architecture.' -ForegroundColor Red -BackgroundColor White}"
	echo powershell -command "& {Write-Host '' -ForegroundColor Red -BackgroundColor White}"
    echo powershell -command "& {Write-Host 'T-Virus will be closed after 10 seconds.' -ForegroundColor Red -BackgroundColor White}"
	echo timeout /t 10
	echo call "%abort%
) > "%UNSUPPORTEDSYSTEM%"

REM call %UNSUPPORTEDSYSTEM%

endlocal
color 0F

