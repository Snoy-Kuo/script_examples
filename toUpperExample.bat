@echo off
setlocal enabledelayedexpansion

set input=-a
CALL :toUpper "!input!" inputToUpper
echo [!input!] to upper = [!inputToUpper!]

set input=-A
CALL :toUpper "!input!" inputToUpper
echo [!input!] to upper = [!inputToUpper!]

set input=Hello World
CALL :toUpper "!input!" inputToUpper
echo [!input!] to upper = [!inputToUpper!]

setlocal DisableDelayedExpansion
EXIT /B %ERRORLEVEL%

rem %~1:original input, %~2 return
:toUpper
	set str=%~1
	for %%A in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
		set "str=!str:%%A=%%A!"
	)
	set "%~2=%str%"
EXIT /B 0