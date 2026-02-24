Clear-Host
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
Write-Host "==============================================" -ForegroundColor Cyan
Write-Host "   🚀 HADERCODE PROJECT INITIALIZER   " -ForegroundColor Cyan
Write-Host "==============================================" -ForegroundColor Cyan
Write-Host ""

# Solicitar el nombre de forma dinámica
$projectName = Read-Host "👉 Introduce el nombre del nuevo proyecto"

if ([string]::IsNullOrWhiteSpace($projectName)) {
    Write-Host "❌ Error: El nombre del proyecto no puede estar vacío." -ForegroundColor Red
    exit
}

# Definir la ruta base
$basePath = Join-Path (Get-Location) $projectName

Write-Host "Creating structure in: $basePath..." -ForegroundColor Gray

# Crear la carpeta raíz del proyecto
if (!(Test-Path $basePath)) {
    New-Item -ItemType Directory -Path $basePath -Force | Out-Null
}

# 1. Crear carpetas principales
$folders = @(
    "docs/contracts",
    "docs/database",
    "docs/manuals",
    "docs/postman",
    "docs/requeriments"
)

foreach ($folder in $folders) {
    $fullPath = Join-Path $basePath $folder
    if (!(Test-Path $fullPath)) {
        New-Item -ItemType Directory -Path $fullPath -Force | Out-Null
        # Crear un archivo .gitkeep para que Git no ignore las carpetas vacías
        New-Item -ItemType File -Path (Join-Path $fullPath ".gitkeep") -Force | Out-Null
    }
}

Write-Host ""
Write-Host "==============================================" -ForegroundColor Green
Write-Host " ✅ ¡PROYECTO '$projectName' CREADO CON ÉXITO! " -ForegroundColor Green
Write-Host "==============================================" -ForegroundColor Green
Write-Host "Próximos pasos:" -ForegroundColor White
Write-Host " 1. cd $projectName" -ForegroundColor White
Write-Host " 2. Abre Antigravity y ejecuta c:\ai-agents-hub\install-hub.ps1." -ForegroundColor White
Write-Host " 3. Ahora puedes empezar a usar Discovery con tu Gema de PM." -ForegroundColor White
exit