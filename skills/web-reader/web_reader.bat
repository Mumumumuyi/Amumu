@echo off
REM web-reader.bat - 网页内容读取工具（简化版）
REM 用法: web-reader.bat "https://example.com"

setlocal enabledelayedexpansion

set URL=%~1
set FORMAT=md

REM 如果没有提供 URL，提示输入
if "%URL%"=="" (
    set /p "URL=请输入要读取的网页网址: "
    if "!URL!"=="" (
        echo 网址不能为空!
        exit /b 1
    )
)

echo.
echo 🌐 正在读取网页: !URL!

REM 调用 PowerShell 脚本
powershell -ExecutionPolicy Bypass -File "%~dp0web_reader.ps1" -Url "!URL!" -Format "!FORMAT!"

endlocal
