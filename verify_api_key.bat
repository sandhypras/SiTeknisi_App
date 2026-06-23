@echo off
echo ================================================
echo   Testing Supabase API Key
echo ================================================
echo.
echo Project: rnofcprjnlvfvgwdynmc
echo.

echo Fetching fresh API keys from Supabase...
echo.

cd supabase
supabase projects api-keys --project-ref rnofcprjnlvfvgwdynmc

echo.
echo ================================================
echo.
echo Compare the "anon" key above with the key in:
echo   .vscode\launch.json
echo   run_with_supabase.bat
echo   run_android_supabase.bat
echo.
echo They must match exactly!
echo.
pause
