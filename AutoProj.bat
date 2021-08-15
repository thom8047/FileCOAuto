@echo off

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

cd /d "%origin%%carrier%\%st%"
set "_path=%cd%"

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
        echo The user-entered county [92m"%ct%"[0m returned [91m%county_number%[0m matches. Please specify more detail by viewing the above directory names.
        goto :yes
    ) 
    
    exit

    :no
    echo n

    EXIT

    endlocal

exit /b 0

:start

:: 1234567

for /f "delims=" %%D in ( 'dir "%_path%" /s /b ^| findstr /i %clip_board%' ) do (
    if exist %%D (
        echo %%D 
        start %SystemRoot%\explorer.exe %%D 
        exit
    )
)

call :CreateFile

pause
echo FOR TESTING