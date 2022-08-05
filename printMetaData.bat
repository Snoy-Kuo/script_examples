@echo off
REM enter: $ printMetaData someapp.apk 
REM it should print:
REM [someapp.apk] show meta-data
REM META-KEY1:	META-VALUE1
REM META-KEY2:	META-VALUE2
REM ...
setlocal enabledelayedexpansion
CALL :printMetaData %%~1
setlocal DisableDelayedExpansion
EXIT /B %ERRORLEVEL%

REM add "apkanalyzer.bat" path to env PATH, 
REM if you install cmdline-tools via Android Studio, it should be %userprofile%\AppData\Local\Android\Sdk\cmdline-tools\latest\bin

REM "xpath.bat" can be find here: https://github.com/npocmaka/batch.scripts/blob/master/hybrids/jscript/xpath.bat
REM  put it in %cd%\lib\

REM %~1:apk file path
:printMetaData
	REM print apk file name
	echo [%~nx1] show meta-data
	
	if exist %cd%\tmp\MetaData.xml (
		del %cd%\tmp\MetaData.xml
	)
	echo.
	if not exist "%cd%\tmp\" mkdir %cd%\tmp\
	CALL apkanalyzer manifest print %~1 >%cd%\tmp\MetaData.xml
	set MetaDataKey=""
	set MetaDataValue=""
	set MetaDataAttrCounter=0
	FOR /F "usebackq tokens=* delims=" %%A in (`%cd%\lib\xpath %cd%\tmp\MetaData.xml "/manifest/application/meta-data/@*" `) DO (
		set /a MetaDataAttrCounter+=1
		set /a MetaDataAttrCol=MetaDataAttrCounter %% 2
		if !MetaDataAttrCol! == 1 (
			set MetaDataKey=%%A
		) else if !MetaDataKey! NEQ "" (
			set MetaDataValue=%%A
			echo !MetaDataKey!:	!MetaDataValue!
		)
	)
EXIT /B 0