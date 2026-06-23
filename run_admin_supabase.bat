@echo off
echo ========================================
echo   SiTeknisi Admin Dashboard (Supabase)
echo ========================================
echo.

flutter run -d chrome ^
  --dart-define=SUPABASE_URL=https://rnofcprjnlvfvgwdynmc.supabase.co ^
  --dart-define=SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJub2ZjcHJqbmx2ZnZnd2R5bm1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYzMjU2ODMsImV4cCI6MjA1MTkwMTY4M30.yn10nCyasi6Y0-kLhQO9xH_cQ-5TaHfN7L_SdMeORAo ^
  --dart-define=APP_MODE=admin ^
  --web-port=8080

echo.
echo Dashboard stopped.
pause
