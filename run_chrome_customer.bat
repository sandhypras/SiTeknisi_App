@echo off
echo ================================================
echo   SiTeknisi - CHROME CUSTOMER MODE
echo ================================================
echo.
echo Project: Siteknisi_App
echo Mode: Customer/Mobile App (not Admin)
echo Platform: Chrome Browser
echo.
echo Starting...
echo.
echo ================================================
echo.

flutter run -d chrome ^
  --dart-define=SUPABASE_URL=https://rnofcprjnlvfvgwdynmc.supabase.co ^
  --dart-define=SUPABASE_PUBLISHABLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJub2ZjcHJqbmx2ZnZnd2R5bm1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIwNTE1NTMsImV4cCI6MjA5NzYyNzU1M30.cWtixmnnA8o07Si-qqk_iEo_ddT6vnB4VCfr-FSduy4 ^
  --dart-define=APP_MODE=mobile

echo.
echo After Chrome opens, press F12 and Ctrl+Shift+M for mobile view.
