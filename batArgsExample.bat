@echo off
setlocal enabledelayedexpansion

REM enter: $ batArgsExample -a 1 -bc 23 -def 456 
REM it should print:
REM Number of processed arguments: 6, 3 SETs
REM [0] -a:1
REM [1] -bc:23
REM [2] -def:456

set argCount=0
set argRow=0
for %%x in (%*) do (
   set /a argRow=argCount / 2
   set /a argCol=argCount %% 2
	if !argCol! == 0 (
		set "argKeyVec[!argRow!]=%%~x"
	) else (
		set "argValVec[!argRow!]=%%~x"
	)
	set /A argCount+=1
	REM echo argCount=!argCount!, argRow=!argRow!, argCol=!argCol!, x=%%~x
)

set /A rowCount=argRow + 1
echo Number of processed arguments: %argCount%, %rowCount% SETs
for /L %%i in (0,1,%argRow%) do echo [%%i] !argKeyVec[%%i]!:!argValVec[%%i]!

setlocal DisableDelayedExpansion