@echo off
echo ================================================
echo   DIAGNOSTIC CHECK - Supabase Integration
echo ================================================
echo.

echo [1/3] Checking Supabase CLI...
supabase --version 2>nul && (
    echo   OK - CLI installed
) || (
    echo   NOT FOUND - Install from https://supabase.com/docs/guides/cli
)
echo.

echo [2/3] Checking project status...
cd supabase
supabase projects list 2>nul && (
    echo   OK - Project connected
) || (
    echo   ERROR - Not connected
)
cd ..
echo.

echo [3/3] Checking migrations...
supabase migration list 2>nul && (
    echo   OK - Migrations synced
) || (
    echo   ERROR - Migrations not synced
)
echo.

echo ================================================
echo.
echo If all checks passed, run the app with:
echo   run_with_supabase.bat
echo.
echo If checks failed, read:
echo   SUPABASE_INTEGRATION.md
echo   TROUBLESHOOTING.md
echo.
echo ================================================
pause
