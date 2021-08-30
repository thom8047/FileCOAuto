@echo off

goto start

:GetUserInputs
    setlocal
        set "value="
        set /p user_input="%~1"
	for %%A in ("create-folder" "open-folder" "open-excel" "excel" "cell" "baw" "psap" "1" "2" "3" "4" "5" "6" "7") do (
		if "%user_input%" == %%A ( set "value=true" )
	)
	
	if defined value (
		echo True
	) else (
            echo [91mInvalid response[0m
            echo(
            goto try
        )

    endlocal

:start

echo [93m ----------------------------------------------------[91m  Main Menu [0m [93m----------------------------------------------------[0m
echo(
echo Interactive shell meant to help with the automation of job tasks.
echo(
echo Please select one of the following options:
echo(
echo Create Project Folder: 	create-folder	^|	1
echo Open Project Folder: 	open-folder	^|	2
echo Append Excel Data: 	open-excel	^|	3
echo Open Excel:		excel		^|	4
echo Open Cell Grid: 	cell		^|	5
echo Open BAW:		baw		^|	6
echo Open PSAP Page:		psap		^|	7
echo(
echo(
echo(
echo(
echo(
echo(
echo(
echo(
echo(
echo(
echo(
echo(
echo(
echo(
echo(
echo(

:try
call :GetUserInputs "Enter Selection: "





pause