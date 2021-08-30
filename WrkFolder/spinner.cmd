@echo off

echo start spin
set /a num=1

:LOOP
set /a num+=1
if %num% EQU 15 ( goto :END )
cscript //nologo vbsEcho.vbs "\"
cscript //nologo vbsEcho.vbs "|"
cscript //nologo vbsEcho.vbs "/"
cscript //nologo vbsEcho.vbs "-"
goto :LOOP

:END
pause