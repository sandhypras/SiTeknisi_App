# Fix Invalid API Key - PowerShell

Write-Host "================================================" -ForegroundColor Red
Write-Host "  FIX: Invalid API Key Error" -ForegroundColor Yellow
Write-Host "================================================" -ForegroundColor Red
Write-Host ""
Write-Host "This script will:" -ForegroundColor Cyan
Write-Host "  1. Stop Flutter processes"
Write-Host "  2. Clean build cache"
Write-Host "  3. Get dependencies"
Write-Host "  4. Prepare for fresh start"
Write-Host ""
Read-Host "Press Enter to continue"

Write-Host ""
Write-Host "[1/4] Stopping Flutter processes..." -ForegroundColor Yellow
Stop-Process -Name dart -Force -ErrorAction SilentlyContinue
Stop-Process -Name flutter -Force -ErrorAction SilentlyContinue
Write-Host "  Done." -ForegroundColor Green

Write-Host ""
Write-Host "[2/4] Cleaning build cache..." -ForegroundColor Yellow
flutter clean
Write-Host "  Done." -ForegroundColor Green

Write-Host ""
Write-Host "[3/4] Getting dependencies..." -ForegroundColor Yellow
flutter pub get
Write-Host "  Done." -ForegroundColor Green

Write-Host ""
Write-Host "[4/4] Ready to start!" -ForegroundColor Green
Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Now run the app with:" -ForegroundColor Yellow
Write-Host ""
Write-Host "  .\run_supabase.ps1" -ForegroundColor Green
Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "IMPORTANT: After app starts, check console!" -ForegroundColor Red
Write-Host "Must show: 'Supabase Integration Active'" -ForegroundColor Green
Write-Host ""
Read-Host "Press Enter to exit"
