@echo off
setlocal enabledelayedexpansion

REM web-search.bat - 在默认浏览器中打开 Google 搜索
REM 用法: web-search.bat "搜索关键词"

if "%~1"=="" (
    set /p QUERY="请输入搜索关键词: "
    if "!QUERY!"=="" (
        echo 未输入搜索关键词!
        exit /b 1
    )
) else (
    set QUERY=%*
)

REM 构建 URL - PowerShell 会自动处理编码
set URL=https://www.google.com/search?q=!QUERY!

echo 正在搜索: !QUERY!

REM 使用 PowerShell 打开 URL (自动处理 URL 编码)
powershell -Command "[System.Diagnostics.Process]::Start('!URL!')" 2>nul
if errorlevel 1 (
    start "" "!URL!"
)

echo 浏览器已打开
endlocal
