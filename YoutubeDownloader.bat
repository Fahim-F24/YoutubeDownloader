@echo off
setlocal enabledelayedexpansion

REM === VALIDATE REQUIRED TOOLS ===
where yt-dlp >nul 2>&1 || (
    echo [ERROR] yt-dlp not found. Make sure it's in your PATH or in the same folder.
    pause
    exit /b
)

where ffmpeg >nul 2>&1 || (
    echo [ERROR] ffmpeg not found. Make sure it's in your PATH or in the same folder.
    pause
    exit /b
)

where ffprobe >nul 2>&1 || (
    echo [ERROR] ffprobe not found. Make sure it's in your PATH or in the same folder.
    pause
    exit /b
)


REM === CONFIGURATION ===
set "BASE_DIR=%~dp0"
set "BASE_DIR=%BASE_DIR:~0,-1%"
set "DOWNLOAD_DIR=%BASE_DIR%\Downloads"
set "TEMP_DIR=%DOWNLOAD_DIR%\video"
set "FFPROBE=ffprobe"
set "FFMPEG=ffmpeg"

REM Create folders if missing
if not exist "%TEMP_DIR%" mkdir "%TEMP_DIR%"

REM Get URL from argument or prompt
if "%~1"=="" (
    set /p URL=Enter playlist or video URL:
) else (
    set URL=%*
)

REM === VALIDATE REQUIRED TOOLS ===
where yt-dlp >nul 2>&1 || (
    echo [ERROR] yt-dlp not found. Make sure it's in your PATH or in the same folder.
    pause
    exit /b
)


echo [INFO] Downloading videos from: %URL%
echo [INFO] Download folder: %TEMP_DIR%

REM Run yt-dlp (config file should specify format and output)
yt-dlp -P "%TEMP_DIR%" %URL%

REM Conversion phase
set /a converted=0
set /a skipped=0

for %%f in ("%TEMP_DIR%\*.mp4") do (
    set "codec="
    for /f "usebackq delims=" %%a in (`%FFPROBE% -v error -select_streams a:0 -show_entries stream^=codec_name -of default^=noprint_wrappers^=1:nokey^=1 "%%~f"`) do (
        set "codec=%%a"
    )
    if /i "!codec!"=="opus" (
        echo [ACTION] Converting audio to AAC for: %%~nxf
        set "tempfile=%TEMP_DIR%\TEMP_%%~nxf"
        %FFMPEG% -y -i "%%~f" -c:v copy -c:a aac -b:a 192k "!tempfile!" >nul 2>&1
        if exist "!tempfile!" (
            del "%%~f"
            ren "!tempfile!" "%%~nxf"
            set /a converted+=1
        ) else (
            echo [ERROR] Conversion failed for: %%~nxf
        )
    ) else (
        set /a skipped+=1
    )
)

REM Move all mp4 files back to Downloads root folder
echo Moving converted files back to %DOWNLOAD_DIR%...
for %%v in ("%TEMP_DIR%\*.mp4") do (
    if not exist "%%v" (
        echo [WARN] File not found: %%~nxf
    ) else if not exist "%DOWNLOAD_DIR%\%%~nxf" (
        move "%%v" "%DOWNLOAD_DIR%\" >nul
    ) else (
        echo [WARN] Duplicate found, renaming: %%~nxf
        set "basename=%%~nv"
        set "ext=%%~xv"
        set /a count=1
        :unique_loop
        if exist "%DOWNLOAD_DIR%\!basename!_!count!!ext!" (
            set /a count+=1
            goto :unique_loop
        )
        move "%%v" "%DOWNLOAD_DIR%\!basename!_!count!!ext!" >nul
    )
)

REM Delete temp folder
rd /s /q "%TEMP_DIR%"

echo.
echo [SUMMARY] Converted audio in %converted% files, skipped %skipped% files.
echo Video Download Completed!
start "" "%DOWNLOAD_DIR%"
pause
