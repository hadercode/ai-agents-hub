<#
.SYNOPSIS
Instala el AI Agents Hub (Skills y Workflows) en el proyecto actual de Antigravity.

.DESCRIPTION
Este script crea un enlace (Junction de Windows) que apunta al repositorio centralizado
de Skills y Workflows del usuario en la carpeta '.agent' del proyecto actual.
De esta manera, no necesitas copiar el código cada vez que inicies un nuevo proyecto, 
y tus cambios también se reflejarán en tu repositorio centralizado de forma inmediata.

.EXAMPLE
.\install-hub.ps1
#>

$HubPath = "C:\ai-agents-hub"
$AgentFolder = ".\.agent"

# Verificar si el Hub existe
if (-not (Test-Path -Path $HubPath)) {
    Write-Host "[!] El Hub no se encuentra en $HubPath. Clónalo allí primero." -ForegroundColor Red
    exit 1
}

# Crear carpeta .agent si no existe en el proyecto
if (-not (Test-Path -Path $AgentFolder)) {
    New-Item -ItemType Directory -Path $AgentFolder | Out-Null
    Write-Host "[+] Carpeta .agent creada en el directorio actual." -ForegroundColor Green
}

# Crear enlaces (Junctions) que no necesitan permisos de Administrador en Windows
function Invoke-LinkHubFolder($FolderName) {
    $TargetFolder = Join-Path -Path $HubPath -ChildPath $FolderName
    $LinkPath = Join-Path -Path $AgentFolder -ChildPath $FolderName

    if (Test-Path -Path $LinkPath) {
        Write-Host "[-] El enlace o carpeta para '$FolderName' ya existe en $LinkPath. Saltando." -ForegroundColor Yellow
        return
    }

    if (-not (Test-Path -Path $TargetFolder)) {
        New-Item -ItemType Directory -Path $TargetFolder | Out-Null
    }

    # Crear el Junction (Enlace a directorio de Windows)
    cmd /c "mklink /J `"$LinkPath`" `"$TargetFolder`"" > $null
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "[OK] Enlace creado exitosamente para '$FolderName'." -ForegroundColor Green
    } else {
        Write-Host "[WARN] No se pudo crear el enlace para '$FolderName'. Verifica que la consola tenga permisos adecuados." -ForegroundColor Red
    }
}

Invoke-LinkHubFolder "skills"
Invoke-LinkHubFolder "workflows"

Write-Host ""
Write-Host "¡Instalación de AI Agents Hub completada exitosamente!" -ForegroundColor Cyan
Write-Host "Los skills y workflows centrales ahora están disponibles para este proyecto local." -ForegroundColor Cyan
Write-Host ""
