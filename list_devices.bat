@echo off
echo ================================================
echo   Available Devices
echo ================================================
echo.

flutter devices

echo.
echo ================================================
echo.
echo To run on specific device:
echo   flutter run -d [device-id] --dart-define=...
echo.
echo Or use:
echo   run_android_supabase.bat (for Android)
echo   run_with_supabase.bat (for Windows/Desktop)
echo.
pause
