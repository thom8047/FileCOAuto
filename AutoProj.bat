@echo off

::license
              
echo     [96m----- _____ ----------------------------------------
echo     -----^|   __^|----------------------------------------
echo     -----^|  ^|_   _________ -----------------------------
echo     -----^|   _^| ^|___   ___^|-----------------------------
echo     -----^|  ^|__-----^| ^|---------------------------------
echo     -----^|_____^|----^| ^|---------------------------------
echo     ----------------^| ^|---------------------------------
echo     ----------------^|_^|--------------------------------- [0m
echo     Copyright 2021-08-15 Edward Kyle Thomas Jr.
echo     This program is free software: you can redistribute it and/or modify
echo     it under the terms of the GNU General Public License as published by
echo     the Free Software Foundation, either version 3 of the License, or
echo     (at your option) any later version.
echo                                                                   -
echo     This program is distributed in the hope that it will be useful,
echo     but WITHOUT ANY WARRANTY; without even the implied warranty of
echo     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
echo     GNU General Public License for more details.
echo                                                                   -
echo     You should have received a copy of the GNU General Public License
echo     along with this program.  If not, see ^<https://www.gnu.org/licenses/^>.
echo                                                                   -
echo     Along with the above resourses, one can find original GNU Licensing
echo     at the original GitHub repository ^<https://github.com/thom8047/FileCOAuto/^>. 
echo     [91m------------------------------------------------------------------------[0m 

goto :after_color_comment
    [90mWhite[0m
    [91mRed[0m
    [92mGreen[0m
    [93mYellow[0m
    [94mBlue[0m
    [95mMagenta[0m
    [96mCyan[0m
    [97mWhite[0m
    special characters [91mRed[0m
:after_color_comment

:: Set global variables

for /f "tokens=*" %%g in ('powershell -sta "add-type -as System.Windows.Forms; [windows.forms.clipboard]::GetText()"') do (set clip_board=%%g)
set "origin=C:\Users\kedwa\Desktop\NDrive\"Web Service"\"
set /p carrier="Enter carrier name: "
set /p st="Enter State Abbrv: "
set /p _ct="Enter County: "

cd /d "%origin%%carrier%\%st%"
set "_path=%cd%"

if defined _ct ( goto :check_for_county )

:: Begin 

goto :start

:GetUserInputs
    setlocal
        set "value="
        set /p user_input="%~1"

        ::echo %user_input%

        if "%user_input%" == "Y" ( set "value=y" )
        if "%user_input%" == "y" ( set "value=y" )
        if "%user_input%" == "N" ( set "value=n" )
        if "%user_input%" == "n" ( set "value=n" )

        if defined value (
            if "%value%"=="y" ( goto :yes ) 
            if "%value%"=="n" ( goto :no )
        ) else (
            echo [91mInvalid response[0m
            echo -            
            goto :try
        )

    endlocal

:CreateFile
    setlocal ENABLEDELAYEDEXPANSION

    echo Project ID: [92m%clip_board%[0m does not have a corresponding file. Would you like to create one?

    :try
    call :GetUserInputs "Enter [Y/N]: "

    :yes
    set /p ct="Enter County: "
    set /a county_number=0
    set "county="

    for /f "delims=" %%C in ( 'dir "%_path%" /b ^| findstr /i %ct%' ) do (
        echo [96m%%C[0m
        set /a "county_number+=1"
        set "county=%%C"
    )
    if %county_number%==0 ( 
        echo Did not find matching directory. Please try again...
        goto :yes 
    ) 
    if %county_number%==1 ( 
        cd %county% 
        cd "projects"
        echo This is your current path: [93m!cd![0m
        echo This will be your project folders name: "[4m[92mM%clip_board%[0m"

        echo [91m~-~-~ NOTES ~-~-~[0m
        echo Please view the current path listed, if the path is wrong
        echo just exit out of window. If the path is correct, but the naming 
        echo convention is wrong, continue on and rename the folder
        echo as needed.
        echo [91m----- NOTES -----[0m

        pause
        mkdir "M%clip_board%" && cd "M%clip_board%"
        start %SystemRoot%\explorer.exe "!cd!"
    ) 
    if %county_number% gtr 1 ( 
        echo The user-entered county [92m"%ct%"[0m returned [91m%county_number%[0m matches. 
        echo Please specify more detail by viewing the above directory names.
        goto :yes
    ) 
    
    exit

    :no
    echo n

    EXIT

    endlocal

exit /b 0

:check_recursive
set /p _ct="Enter County: "
set /a _county_number=0
set "_county="

:: 12345678

:check_for_county

for /f "delims=" %%B in ( 'dir "%_path%" /b ^| findstr /i %_ct%' ) do (
    echo [96m%%B[0m
    set /a "_county_number+=1"
    set "_county=%%B"
)

if %_county_number%==1 ( 
    cd %_county%
    goto :start
) else (
    if %_county_number%==0 ( 
        echo Did not find matching directory. Please try again...
    ) else (
        echo The user-entered county [92m"%_ct%"[0m returned [91m%_county_number%[0m matches. 
        echo Please specify more detail by viewing the above directory names.
    )
    goto :check_recursive
)

:start

for /f "delims=" %%D in ( 'dir "%_path%" /s /b ^| findstr /i %clip_board%' ) do (
    if exist %%D (
        echo %%D 
        start %SystemRoot%\explorer.exe %%D 
        exit
    )
)

if not defined _county call :CreateFile

echo %cd%

pause
echo FOR TESTING