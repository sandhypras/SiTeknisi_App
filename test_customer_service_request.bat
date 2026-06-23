@echo off
echo ========================================
echo   Test: Customer Service Request
echo ========================================
echo.
echo Fitur yang akan ditest:
echo - Form pengajuan service request
echo - Upload foto kerusakan
echo - Validasi input
echo - Integrasi database Supabase
echo.
echo Port: 8081
echo URL: http://localhost:8081
echo.
echo Login sebagai CUSTOMER untuk testing
echo.
pause

flutter run -d chrome ^
  --dart-define=SUPABASE_URL=https://rnofcprjnlvfvgwdynmc.supabase.co ^
  --dart-define=SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJub2ZjcHJqbmx2ZnZnd2R5bm1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYzMjU2ODMsImV4cCI6MjA1MTkwMTY4M30.yn10nCyasi6Y0-kLhQO9xH_cQ-5TaHfN7L_SdMeORAo ^
  --web-port=8081

echo.
echo Test selesai.
pause
