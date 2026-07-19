# AI Agents Hub

Este es tu repositorio centralizado de **Skills** y **Workflows** para Antigravity.
Al usar este repositorio, puedes mantener tu entorno de desarrollo exactamente igual sin importar en qué computadora estés trabajando.

## Estructura Actual

El repositorio contiene las siguientes habilidades y configuraciones en la raíz:

- **Habilidades (Skills):**
  - `backend-arquitect/`: Habilidad para la implementación backend en Clean Architecture.
  - `db-architect/`: Habilidad para el diseño físico de bases de datos PostgreSQL.
  - `devops-cloud-architect/`: Habilidad para tareas de despliegue y nube.
  - `doc-writer/`: Habilidad para redactar documentación técnica.
  - `git-release-architect/`: Habilidad para gestionar ramas de Git, Commits Convencionales y Releases.
  - `laravel-domain-architect/`: Habilidad para arquitectura basada en Laravel.
  - `qa-engineer/`: Habilidad para aseguramiento de calidad y pruebas.
  - `react-architect/`: Habilidad para la implementación frontend en React Enterprise.
  - `software-architect-spec-generator/`: Habilidad para generación de especificaciones técnicas y contratos de API.
- **Configuración Global:**
  - `AGENTS.md`: Define la guía de workflows (Feature y Fix) y reglas de comportamiento del agente en el proyecto.
  - `install-hub.ps1`: Script para vincular este repositorio central a un proyecto de desarrollo local.
  - `init-project.ps1`: Script auxiliar para inicializar la estructura base de un nuevo proyecto.

## Cómo usar este repositorio

### 1. Conéctalo a tu GitHub

Sube este repositorio a tu GitHub asociado a tu cuenta de Gmail:

```bash
git add .
git commit -m "Initial commit of AI Agents Hub"
git branch -M main
git remote add origin https://github.com/TU_USUARIO/ai-agents-hub.git
git push -u origin main
```

### 2. Configura tu otra computadora

En tu segunda laptop, simplemente clona el repositorio en la misma ubicación que usas normalmente (por ejemplo, en `C:\ai-agents-hub`):

```bash
git clone https://github.com/TU_USUARIO/ai-agents-hub.git C:\ai-agents-hub
```

### 3. Instala los Skills en un Proyecto Nuevo

Para que Antigravity tenga acceso a estos skills y workflows en cualquier proyecto local en el que estés trabajando:

1. Abre una terminal en la raíz de tu proyecto de desarrollo.
2. Ejecuta el script de instalación provisto en este repositorio:

```powershell
C:\ai-agents-hub\install-hub.ps1
```

> **¿Qué hace el script?**
> El script crea de forma automática enlaces de directorio (Junctions de Windows) dentro de la carpeta `.agents/` de tu proyecto apuntando a las habilidades de este Hub central. Además, vincula el archivo [AGENTS.md](file:///c:/ai-agents-hub/AGENTS.md) mediante un enlace físico (Hard Link). 
> De esta forma, Antigravity puede ver, usar y actualizar las reglas y habilidades sin necesidad de duplicarlas en cada proyecto.

### ¿Cómo actualizar o agregar algo nuevo?

1. Agrega una nueva carpeta de skill directamente en la raíz de `C:\ai-agents-hub\` (asegurándote de incluir su archivo `SKILL.md`).
2. Haz `git add`, `git commit` y `git push`.
3. En tu otra computadora haz `git pull` dentro del directorio `C:\ai-agents-hub`.
4. Vuelve a ejecutar `C:\ai-agents-hub\install-hub.ps1` en tus proyectos locales activos para vincular la nueva habilidad (el script detectará la nueva carpeta dinámicamente y la enlazará).

