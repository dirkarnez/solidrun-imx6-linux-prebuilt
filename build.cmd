@echo off
if not exist "dist" (
    md dist
)

docker compose up --build && docker compose down
pause