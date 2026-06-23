@echo off
setlocal EnableDelayedExpansion

echo ================================================
echo   SiTeknisi - GUARANTEED SUPABASE MODE
echo ================================================
echo.

REM Set credentials as environment variables for this session
set SUPABASE_URL=https://rnofcprjnlvfvgwdynmc.supabase.co
set SUPABASE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJub2ZjcHJqbmx2ZnZnd2R5bm1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIwNTE1NTMsImV4cCI6MjA5NzYyNzU1M30.cWtixmnnA8o07Si-qqk_iEo_ddT6vnB4VCfr-FSduy4

echo Project: Siteknisi_App
echo Region: Sydney, Oceania
echo URL: !SUPABASE_URL!
echo Key: !SUPABASE_KEY:~0,30!...
echo.
echo ================================================
echo.
echo Starting Flutter with verified credentials...
echo.
echo CRITICAL: After app starts, CHECK CONSOLE for:
echo   "URL: ✓ https://rnofcprjnlvfvgwdynmc.supabase.co"
echo   "Configured: ✓ TRUE"
echo.
echo If you see "MOCK MODE" or "KOSONG", STOP and run:
echo   fix_invalid_api_key.bat
echo.
echo ================================================
echo.

flutter run ^
  --dart-define=SUPABASE_URL=%SUPABASE_URL% ^
  --dart-define=SUPABASE_PUBLISHABLE_KEY=%SUPABASE_KEY%

endlocal
