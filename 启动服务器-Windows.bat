@echo off
chcp 65001 >nul
cd /d "%~dp0"
set PORT=8080
title 巡星记 · 局域网访问服务器

cls
echo ==================================================
echo           巡星记 . 局域网访问服务器
echo ==================================================
echo.

set IP=
for /f "tokens=2 delims=:" %%i in ('ipconfig ^| findstr /C:"IPv4"') do set IP=%%i
if defined IP set IP=%IP: =%

if defined IP (
  echo   在平板的浏览器里，输入下面这个地址，然后回车：
  echo.
  echo        http://%IP%:%PORT%
  echo.
) else (
  echo   [!] 没找到局域网 IP。
  echo       请先确认这台电脑已经连上家里的 Wi-Fi。
  echo.
)

echo   --------------------------------------------------
echo   这个窗口要一直开着；关掉它，服务就停了。
echo   --------------------------------------------------
echo.

where python >nul 2>nul
if %errorlevel%==0 (
  python -m http.server %PORT%
  goto end
)

where py >nul 2>nul
if %errorlevel%==0 (
  py -m http.server %PORT%
  goto end
)

echo   [x] 没有找到 Python。
echo       请到 https://www.python.org 下载安装，
echo       安装第一步务必勾选 "Add Python to PATH"，装完再运行本文件。
echo.

:end
echo.
pause
