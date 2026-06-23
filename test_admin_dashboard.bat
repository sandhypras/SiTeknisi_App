@echo off
echo ========================================
echo   Test: Admin Dashboard
echo ========================================
echo.
echo Fitur yang akan ditest:
echo - CRUD Services
echo - Verifikasi Teknisi
echo - Monitor Bookings
echo - User Management
echo.
echo Port: 8082
echo URL: http://localhost:8082
echo.
echo Login sebagai ADMIN untuk testing
echo Email: admin@siteknisi.id
echo.
pause

flutter run -d chrome ^
  --dart-define=SUPABASE_URL=https://rnofcprjnlvfvgwdynmc.supabase.co ^
  --dart-define=SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJub2ZjcHJqbmx2ZnZnd2R5bm1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYzMjU2ODMsImV4cCI6MjA1MTkwMTY4M30.yn10nCyasi6Y0-kLhQO9xH_cQ-5TaHfN7L_SdMeORAo ^
  --dart-define=APP_MODE=admin ^
  --web-port=8082

echo.
echo Test selesai.
pause
