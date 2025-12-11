@echo off
if not exist "dist" (
    md dist
)

docker compose up --build 
@REM && docker compose down
pause