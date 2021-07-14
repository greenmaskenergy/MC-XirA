@echo off


cls
set /a progress=0


echo checking for files!
echo downloading ModListFile
bitsadmin.exe /transfer "|||||  ModListFile (file: mods) ||||||" /priority FOREGROUND http:/onehit.eu/lib/minecraft/New_Era/mods %cd%\mods
setlocal EnableDelayedExpansion
set "cmd=findstr /R /N "^^" %cd%\mods | find /C ":""

for /f %%a in ('!cmd!') do set ModCount=%%a


for /F "tokens=*" %%A in (%cd%\mods) do (
    set /a progress=progress+1
    echo Mod Progress: !progress! / %ModCount%

if not exist %cd%\%%A (
    echo missing: %%A
    bitsadmin.exe /transfer "|||||  Mod:  %%A  || !progress! / !ModCount! ||||||"  /priority FOREGROUND https://github.com/greenmaskenergy/Green-sMinecraftMods/raw/master/%%A %cd%\%%A
) else (
    cls
    echo skipped mod: %%A already exists
)
)
cls
echo Mod Progress: !progress! / %ModCount%
echo update done!
pause