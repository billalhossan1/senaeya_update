# PowerShell script to fix R8 file locking issues

Write-Host "Step 1: Stopping Gradle Daemon..." -ForegroundColor Yellow
Set-Location "D:\billal_projects\senaeya\fahad_alfayez_senaeya\android"
.\gradlew --stop

Write-Host "`nStep 2: Cleaning Flutter build..." -ForegroundColor Yellow
Set-Location "D:\billal_projects\senaeya\fahad_alfayez_senaeya"
flutter clean

Write-Host "`nStep 3: Removing build directories..." -ForegroundColor Yellow
if (Test-Path ".\build") {
    Remove-Item -Path ".\build" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Removed .\build"
}
if (Test-Path ".\android\.gradle") {
    Remove-Item -Path ".\android\.gradle" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Removed .\android\.gradle"
}
if (Test-Path ".\android\app\build") {
    Remove-Item -Path ".\android\app\build" -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "Removed .\android\app\build"
}

Write-Host "`nStep 4: Getting Flutter dependencies..." -ForegroundColor Yellow
flutter pub get

Write-Host "`nStep 5: Building release bundle..." -ForegroundColor Yellow
Write-Host "This may take several minutes..." -ForegroundColor Cyan
flutter build appbundle --release

Write-Host "`nBuild process completed!" -ForegroundColor Green

