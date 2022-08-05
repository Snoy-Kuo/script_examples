@echo off
setlocal EnableDelayedExpansion
set var=0
echo init var=%var%
echo loop start
for %%a in (1 1 1 1 1) do (
	set /a var+=%%a
	echo var=!var!
)
echo loop end
echo current var=%var%