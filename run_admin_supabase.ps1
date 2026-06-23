# SiTeknisi Admin Dashboard Runner (Supabase)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  SiTeknisi Admin Dashboard (Supabase)" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$env:SUPABASE_URL = "https://rnofcprjnlvfvgwdynmc.supabase.co"
$env:SUPABASE_ANON_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJub2ZjcHJqbmx2ZnZnd2R5bm1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYzMjU2ODMsImV4cCI6MjA1MTkwMTY4M30.yn10nCyasi6Y0-kLhQO9xH_cQ-5TaHfN7L_SdMeORAo"
$env:APP_MODE = "admin"

Write-Host "Starting Admin Dashboard..." -ForegroundColor Green
Write-Host "URL: http://localhost:8080" -ForegroundColor Yellow
Write-Host ""

flutter run -d chrome `
  --dart-define=SUPABASE_URL=$env:SUPABASE_URL `
  --dart-define=SUPABASE_ANON_KEY=$env:SUPABASE_ANON_KEY `
  --dart-define=APP_MODE=admin `
  --web-port=8080

Write-Host ""
Write-Host "Dashboard stopped." -ForegroundColor Red
