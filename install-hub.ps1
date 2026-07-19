<#
.SYNOPSIS
Instala el AI Agents Hub (Skills y Workflows) en el proyecto actual de Antigravity.

.DESCRIPTION
Este script crea enlaces (Junctions de Windows) que apuntan al repositorio centralizado
de Skills y configuraciones del usuario en la carpeta '.agents' del proyecto actual.
De esta manera, no necesitas copiar el código cada vez que inicies un nuevo proyecto, 
y tus cambios también se reflejarán en tu repositorio centralizado de forma inmediata.

.EXAMPLE
.\install-hub.ps1
#>

$HubPath = "C:\ai-agents-hub"
$AgentFolder = ".\.agents"

# Verificar si el Hub existe
if (-not (Test-Path -Path $HubPath)) {
    Write-Host "[!] El Hub no se encuentra en $HubPath. Clónalo allí primero." -ForegroundColor Red
    exit 1
}

# Crear carpeta .agents si no existe en el proyecto
if (-not (Test-Path -Path $AgentFolder)) {
    New-Item -ItemType Directory -Path $AgentFolder | Out-Null
    Write-Host "[+] Carpeta .agents creada en el directorio actual." -ForegroundColor Green
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

# Obtener dinámicamente todos los directorios que representan habilidades en el Hub
# Excluimos directorios del sistema como .git, carpetas ocultas y el propio proyecto de destino si está dentro del Hub
$CurrentProjectFullPath = (Get-Item .).FullName
$Skills = Get-ChildItem -Path $HubPath -Directory | Where-Object { 
    $_.Name -notlike ".*" -and 
    $_.FullName -ne $CurrentProjectFullPath
}

Write-Host "Enlazando habilidades del hub..." -ForegroundColor Cyan
foreach ($Skill in $Skills) {
    Invoke-LinkHubFolder $Skill.Name
}

# Vincular o copiar el archivo de reglas AGENTS.md
$HubAgentsFile = Join-Path -Path $HubPath -ChildPath "AGENTS.md"
$DestAgentsFile = Join-Path -Path $AgentFolder -ChildPath "AGENTS.md"

if (Test-Path -Path $HubAgentsFile) {
    if (-not (Test-Path -Path $DestAgentsFile)) {
        # Intentar crear un enlace físico (Hard Link) para que los cambios se reflejen mutuamente
        cmd /c "mklink /H `"$DestAgentsFile`" `"$HubAgentsFile`"" > $null
        if ($LASTEXITCODE -eq 0) {
            Write-Host "[OK] Enlace físico creado para AGENTS.md." -ForegroundColor Green
        } else {
            # Si falla (por ejemplo, cruce de unidades de disco), simplemente copiar
            Copy-Item -Path $HubAgentsFile -Destination $DestAgentsFile -Force
            Write-Host "[+] Archivo AGENTS.md copiado a la carpeta .agents." -ForegroundColor Green
        }
    } else {
        Write-Host "[-] El archivo AGENTS.md ya existe en $DestAgentsFile. Saltando." -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "¡Instalación de AI Agents Hub completada exitosamente!" -ForegroundColor Cyan
Write-Host "Los skills y workflows centrales ahora están disponibles en la carpeta .agents del proyecto actual." -ForegroundColor Cyan
Write-Host ""
