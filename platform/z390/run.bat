@echo off
REM =====================================================
REM  ZKVS run script for z390
REM  Zane Hambly, 2026
REM
REM  Usage: run.bat [load|read|both]
REM    load  - assemble and run ZKVSLOAD (writes records)
REM    read  - assemble and run ZKVSSEQ  (reads them back)
REM    both  - load then read
REM =====================================================

set Z390=C:\dev\emulators\Hopper\z390
set SRC=C:\dev\vintage\hlasm-db\SRC
set MACDIR=C:\dev\vintage\hlasm-db\SRC\macros
set DATADIR=C:\dev\vintage\hlasm-db\platform\z390\data

REM z390 maps DDNAME (ILY JCL) to file via environment variable
REM DCB says DDNAME=ZKVSDATA, so we SET ZKVSDATA=path
set ZKVSDATA=%DATADIR%\ZKVSDATA.DAT

REM create data directory if it doesn't exist
if not exist "%DATADIR%" mkdir "%DATADIR%"

if /I "%1"=="" goto usage
if /I "%1"=="load" goto load
if /I "%1"=="read" goto read
if /I "%1"=="both" goto both
if /I "%1"=="key" goto key
goto usage

:load
echo ========================================
echo  ZKVSLOAD - Writing records
echo ========================================
call %Z390%\bat\ASMLG.BAT %SRC%\ZKVSLOAD sysmac(+%MACDIR%)
if %ERRORLEVEL% NEQ 0 (
    echo ZKVSLOAD failed with RC=%ERRORLEVEL%
    goto done
)
echo ZKVSLOAD completed OK
goto done

:read
echo ========================================
echo  ZKVSSEQ - Reading records
echo ========================================
call %Z390%\bat\ASMLG.BAT %SRC%\ZKVSSEQ sysmac(+%MACDIR%)
if %ERRORLEVEL% NEQ 0 (
    echo ZKVSSEQ failed with RC=%ERRORLEVEL%
    goto done
)
echo ZKVSSEQ completed OK
goto done

:key
echo ========================================
echo  ZKVSKEY - Keyed search
echo ========================================
call %Z390%\bat\ASMLG.BAT %SRC%\ZKVSKEY sysmac(+%MACDIR%)
if %ERRORLEVEL% NEQ 0 (
    echo ZKVSKEY failed with RC=%ERRORLEVEL%
    goto done
)
echo ZKVSKEY completed OK
goto done

:both
call :load
if %ERRORLEVEL% NEQ 0 goto done
call :read
goto done

:usage
echo Usage: run.bat [load^|read^|both^|key]
echo   load  - write sample records
echo   read  - read them back sequentially
echo   both  - load then read
echo   key   - search by key (REC002)

:done
