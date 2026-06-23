# SiTeknisi - Supabase Mode (PowerShell)

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "  SiTeknisi - SUPABASE MODE" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Project: Siteknisi_App"
Write-Host "Region: Sydney, Oceania"
Write-Host "URL: https://rnofcprjnlvfvgwdynmc.supabase.co"
Write-Host ""
Write-Host "Starting with Supabase integration..." -ForegroundColor Yellow
Write-Host ""
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

$env:SUPABASE_URL = "https://rnofcprjnlvfvgwdynmc.supabase.co"
$env:SUPABASE_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJub2ZjcHJqbmx2ZnZnd2R5bm1jIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODIwNTE1NTMsImV4cCI6MjA5NzYyNzU1M30.cWtixmnnA8o07Si-qqk_iEo_ddT6vnB4VCfr-FSduy4"

flutter run `
  --dart-define=SUPABASE_URL=$env:SUPABASE_URL `
  --dart-define=SUPABASE_PUBLISHABLE_KEY=$env:SUPABASE_KEY
