:: Check for directory in projects

:: Use parameter as clip_board

for /F "tokens=*" %%E in (C:\Users\ethomas\Desktop\WrkFolder\projects.txt) do (
	echo %%E | findstr /i /l "%clip_board%" && for /f "delims= :" %%G in ( "%%E" ) do ( 
		start %SystemRoot%\explorer.exe "%%G"
		pause
		exit
	)
)