@echo off

::license

echo     [93m-----[0m[96m _____[0m [93m----------------------------------------[0m
echo     [93m-----[0m[96m^|   __^|[0m[93m----------------------------------------[0m
echo     [93m-----[0m[96m^|  ^|_   _________[0m [93m-----------------------------[0m
echo     [93m-----[0m[96m^|   _^| ^|___   ___^|[0m[93m-----------------------------[0m
echo     [93m-----[0m[96m^|  ^|__[0m[93m-----[0m[96m^| ^|[0m[93m---------------------------------[0m
echo     [93m-----[0m[96m^|_____^|[0m[93m----[0m[96m^| ^|[0m[93m---------------------------------[0m
echo     [93m----------------[0m[96m^| ^|[0m[93m---------------------------------[0m
echo     [93m----------------[0m[96m^|_^|[0m[93m---------------------------------[0m
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
echo     along with this program.  If not, see ^<[4mhttps://www.gnu.org/licenses/[0m^>.
echo                                                                   -
echo     Along with the above resourses, one can find original GNU Licensing
echo     at the original GitHub repository ^<[4mhttps://github.com/thom8047/FileCOAuto/[0m^>. 
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
    special characters [?m
:after_color_comment

for /f "tokens=*" %%g in ('powershell -sta "add-type -as System.Windows.Forms; [windows.forms.clipboard]::GetText()"') do (set clip_board=%%g)

echo Make sure your Project ID is currently in your clipboard [e.g. Ctrl-C the proj-id]
echo before entering the county below.
echo Current clipboard: "[92m%clip_board%[0m"
echo(

:: Set global variables

set "origin=C:\Users\kedwa\Desktop\NDrive\"Web Service"\"
set /p carrier="Enter Carrier Folder name: "
set /p st="Enter State Folder name: "
set /p _ct="Enter County Folder name: "

for /f "tokens=*" %%g in ('powershell -sta "add-type -as System.Windows.Forms; [windows.forms.clipboard]::GetText()"') do (set clip_board=%%g)

cd /d "%origin%%carrier%\%st%"
set "_path=%cd%"

if defined _ct ( goto :check_for_county ) else ( goto :check_recursive )

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

    echo(
    echo Project ID: [92m%clip_board%[0m does not have a corresponding file. Would you like to create one?
    echo(

    :try
    call :GetUserInputs "Enter [Y/N]: "

    :yes
    echo(

    echo This is your current path: [93m!cd![0m
    echo This will be your project folders name: "[4m[92mM%clip_board%[0m"
    echo(
    echo [91m----- NOTES -----[0m
    echo Please view the current path listed, if the path is wrong
    echo just exit out of window. If the path is correct, but the naming 
    echo convention is wrong, continue on and rename the folder
    echo as needed.
    echo [91m-----------------[0m

    pause
    mkdir "M%clip_board%" && cd "M%clip_board%"

    :: save file to text
    echo %clip_board%:"!cd!" > C:\Users\kedwa\Desktop\tmp_project_loc.txt
    type C:\Users\kedwa\Desktop\project_loc.txt >> C:\Users\kedwa\Desktop\tmp_project_loc.txt
    type C:\Users\kedwa\Desktop\tmp_project_loc.txt > C:\Users\kedwa\Desktop\project_loc.txt

    :: del tmp_file
    del C:\Users\kedwa\Desktop\tmp_project_loc.txt

    start %SystemRoot%\explorer.exe "!cd!"

    goto :checkout

    :no
    echo n

    EXIT

    endlocal

exit /b 0

:check_recursive
set /p _ct="County was not assigned, please enter county: "

:: 123456

:check_for_county

set /a _county_number=0
set "_county="

for /f "delims=" %%B in ( 'dir "%_path%" /a:D /b ^| findstr /i /r /c:"%_ct%"' ) do (
    echo [96m%%B[0m
    set /a "_county_number+=1"
    set "_county=%%B"
)

if %_county_number%==1 ( 
    cd %_county%
    cd "*projects*"
    goto :start
) else (
    if %_county_number%==0 ( 
        echo Did not find matching directory. Please try again...
    ) else (
        echo The user-entered county [92m"%_ct%"[0m returned [91m%_county_number%[0m matches. 
        echo Please specify which folder from the directory names.
    )
    echo(
    goto :check_recursive
)

:start

set "_path=%cd%"

for /f "delims=" %%D in ( 'dir "%_path%" /a:D /b ^| findstr /i %clip_board%' ) do (
    if exist %%D (
        echo %%D 
        start %SystemRoot%\explorer.exe %%D 
        exit
    )
)

call :CreateFile

echo %cd%

:checkout
echo FOR TESTING
exit
