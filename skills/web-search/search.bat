@echo off
REM search - 快速搜索命令
REM 用法: search 搜索关键词

if "%~1"=="" (
    set /p QUERY="请输入搜索关键词: "
) else (
    set QUERY=%*
)

echo 正在搜索: %QUERY%
powershell -Command "Start-Process 'https://www.google.com/search?q=%QUERY%'" 2>nul
echo 浏览器已打开
