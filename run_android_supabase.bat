@echo off
echo ================================================
echo   SiTeknisi - ANDROID MODE (Supabase)
echo ================================================
echo.
echo Project: Siteknisi_App
echo Region: Sydney, Oceania
echo URL: https://rnofcprjnlvfvgwdynmc.supabase.co
echo.
echo Starting Android app with Supabase integration...
echo.
echo ================================================
echo.

flutter run -d android ^
  --dart-define=SUPABASE_URL=https://rnofcprjnlvfvgwdynmc.supabase.co ^
  --dart-define=SUPABASE_PUBLISHABLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJub2ZjcHJqbmx2ZnZnd2R5bm1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIwNTE1NTMsImV4cCI6MjA5NzYyNzU1M30.cWtixmnnA8o07Si-qqk_iEo_ddT6vnB4VCfr-FSduy4
