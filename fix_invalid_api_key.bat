@echo off
echo ================================================
echo   FIX: Invalid API Key Error
echo ================================================
echo.
echo This script will:
echo   1. Stop all Flutter processes
echo   2. Clean build cache
echo   3. Verify API keys
echo   4. Restart with correct credentials
echo.
echo ================================================
echo.
pause

echo.
echo [1/5] Stopping Flutter processes...
taskkill /F /IM dart.exe 2>nul
taskkill /F /IM flutter.exe 2>nul
echo   Done.

echo.
echo [2/5] Cleaning build cache...
flutter clean
echo   Done.

echo.
echo [3/5] Getting dependencies...
flutter pub get
echo   Done.

echo.
echo [4/5] Verifying API keys...
cd supabase
supabase projects api-keys --project-ref rnofcprjnlvfvgwdynmc | findstr "anon"
cd ..
echo   Done.

echo.
echo [5/5] Ready to start!
echo.
echo ================================================
echo.
echo Now run the app with ONE of these:
echo.
echo   A) Windows Desktop:
echo      run_with_supabase.bat
echo.
echo   B) Android:
echo      run_android_supabase.bat
echo.
echo   C) VS Code:
echo      Press F5 and select "Supabase Mode - Windows"
echo.
echo ================================================
echo.
echo IMPORTANT: After app starts, check console output!
echo Must show: "Supabase Integration Active"
echo.
pause
