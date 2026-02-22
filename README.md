# AI Agents Hub

Este es tu repositorio centralizado de **Skills** y **Workflows** para Antigravity.
Al usar este repositorio, puedes mantener tu entorno de desarrollo exactamente igual sin importar en qué computadora estés trabajando.

## Estructura

- `skills/`: Contiene tus "habilidades" personalizadas o de terceros (cada una en su carpeta con un `SKILL.md`).
- `workflows/`: Contiene flujos de trabajo detallados `.md` sobre cómo realizar tareas específicas.

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

Para que Antigravity tenga acceso a estos skills globales en cualquier proyecto en el que estés trabajando, abre una terminal en la raíz de tu proyecto y ejecuta el script de instalación provisto en este repositorio.

```powershell
C:\ai-agents-hub\install-hub.ps1
```

> **¿Qué hace el script?**
> El script crea de forma automática "enlaces simbólicos" (Accesos directos reales de Windows) en tu proyecto (`.agent/skills` y `.agent/workflows`) apuntando a esta carpeta central. De esta forma, Antigravity puede ver y usar todo el contenido de este Hub sin necesidad de duplicarlo en cada proyecto.

### ¿Cómo actualizar o agregar algo nuevo?

1. Agrega una nueva carpeta de skill en `C:\ai-agents-hub\skills\`.
2. Haz `git add`, `git commit` y `git push`.
3. En tu otra computadora haz `git pull` dentro del directorio `C:\ai-agents-hub`.
4. ¡Listo! Ya estará disponible en todos tus proyectos en ambos equipos.

