# 🧭 Guía de Workflows del Proyecto

Este archivo define las reglas de comportamiento, ejecución de tareas y orden de prioridad del agente para asegurar calidad, consistencia y la confirmación explícita del usuario en acciones consideradas críticas.

---

## 🚀 ACTIVADORES DE TRABAJO (TRIGGERS)

El agente debe iniciar su comportamiento basándose en los siguientes comandos que el usuario colocará al principio de su prompt:

- **`[WORKFLOW: FEATURE]`**: Para diseñar e implementar una nueva funcionalidad completa.
- **`[WORKFLOW: FIX]`**: Para solucionar un bug, aplicar un parche o realizar modificaciones incrementales menores.

---

## 🛠️ WORKFLOW 1: Desarrollo de Nuevas Features (`[WORKFLOW: FEATURE]`)

Este flujo está diseñado para construir funcionalidades desde cero en orden secuencial e incremental. **Ninguna fase puede saltarse o ejecutarse fuera de orden.**

### 📋 Fase 1: Especificación y Contratos (Opcional si ya existe la Spec)
- **Habilidad a utilizar:** [software-architect-spec-generator](file:///c:/Projects/NODE/admin-template-free/.agents/software-architect-spec-generator/SKILL.md).
- **Acción:** 
  - Si el usuario no proporciona un archivo de Spec ya redactado, se recibe la idea rústica y se genera un documento Spec en Markdown con el modelo de datos PostgreSQL lógico, contratos REST API, 3 escenarios de fallo (edge cases) y prototipos visuales en formato ASCII para las pantallas principales.
  - Si el usuario ya provee una Spec física o un path a ella, se lee e inicia directamente en la **Fase 2**.
- **🛑 Checkpoint Crítico 1 (Aprobación de la Spec):** El agente debe detenerse y presentar la Spec (o el análisis de la Spec dada), incluyendo los mockups ASCII propuestos, para que el usuario dé su aprobación.

### 🗄️ Fase 2: Diseño Físico de Base de Datos
- **Habilidad a utilizar:** [db-architect](file:///c:/Projects/NODE/admin-template-free/.agents/db-architect/SKILL.md).
- **Acción:**
  - Definir las tablas físicas, tipos exactos (como `DECIMAL(19,4)` para dinero), relaciones, índices de rendimiento, triggers y políticas de auditoría (`created_at`, `updated_at`, `deleted_at`, `created_by_id`).
- **🛑 Checkpoint Crítico 2 (Aprobación Lógica de BD):** **Punto de Control Obligatorio.** Antes de escribir código SQL o de persistencia (DDL), presentar un resumen de la BD propuesta y esperar la aprobación del usuario.
- **Entregable:** Generar el diccionario de datos en `docs/database/[modulo]-dictionary.md` y los scripts SQL necesarios.

### 🏗️ Fase 3: Implementación Backend (Clean Architecture)
- **Habilidad a utilizar:** [backend-architect](file:///c:/Projects/NODE/admin-template-free/.agents/backend-arquitect/SKILL.md).
- **Acción:**
  - Implementar la lógica por módulos (Vertical Slices: Domain, Application, Infra, Controllers).
  - El código de dominio y de casos de uso debe estar libre de frameworks (Inversión de Dependencias usando `abstract class` para DI).
  - Generar obligatoriamente la documentación de API Contract en `docs/contracts/[modulo].contract.md` y la colección de Postman en `docs/postman/[modulo].postman_collection.json`.
- **🛑 Checkpoint Crítico 3 (Control de Calidad Backend):** Validar la checklist técnica de backend. No proceder a frontend hasta que los contratos y Postman estén confirmados.

### 💻 Fase 4: Implementación Frontend (React Enterprise)
- **Habilidad a utilizar:** [react-architect](file:///c:/Projects/NODE/admin-template-free/.agents/react-architect/SKILL.md).
- **Acción:**
  - Leer el contrato de API creado en la Fase 3.
  - Diseñar componentes reusables, tipos/interfaces TS, hooks de TanStack Query, formularios con Zod y componentes con Skeletons.
  - Implementar la lógica pura desacoplada en `utils/` o `services/`.
- **🛑 Checkpoint Crítico 4 (Completeness Gate):** Ejecutar una auditoría cruzada que asegure que todos los endpoints del backend tienen su flujo correspondiente funcional en frontend.

### 🕵️ Fase 5: Aseguramiento de Calidad (QA Check)
- **Habilidad a utilizar:** [qa-engineer](file:///c:/Projects/NODE/admin-template-free/.agents/qa-engineer/SKILL.md).
- **Acción:**
  - Ejecutar y crear tests para verificar precisión contable, transacciones, y flujos de error.
  - Emitir obligatoriamente el **Reporte de Riesgos Obligatorio** (`Critical Path`, `Potential Side Effects`, `Security Vulnerability`).

### 🤖 Fase 6: Git & Release
- **Habilidad a utilizar:** [git-release-architect](file:///c:/Projects/NODE/admin-template-free/.agents/git-release-architect/SKILL.md).
- **Acción:**
  - Confirmar que los commits siguen el estándar de Commits Convencionales.
  - Estimar la versión SemVer (MAJOR.MINOR.PATCH) y actualizar el `CHANGELOG.md`.

---

## 🐞 WORKFLOW 2: Corrección de Bugs o Ajustes Menores (`[WORKFLOW: FIX]`)

Este flujo se activa ante reportes de errores puntuales o solicitudes de modificaciones incrementales rápidas que no califican como nuevas features de negocio.

### 🔎 Fase 1: Diagnóstico e Investigación
- **Acción:** Localizar el bug, identificar las causas raíz y proponer la solución concreta.
- **🛑 Checkpoint Crítico 1 (Propuesta de Fix):** Presentar un breve resumen técnico del problema y la solución planteada. Esperar confirmación antes de modificar el código.

### 🛠️ Fase 2: Aplicación del Fix
- **Acción:** Realizar el cambio de código cuidando de no romper las convenciones de Clean Architecture o de React Enterprise.

### 🧪 Fase 3: Pruebas de Regresión
- **Habilidad a utilizar:** [qa-engineer](file:///c:/Projects/NODE/admin-template-free/.agents/qa-engineer/SKILL.md).
- **Acción:** Asegurar que el cambio corrige el bug y correr tests locales para verificar que no afecte otros módulos críticos.

### 📦 Fase 4: Registro de Versión
- **Habilidad a utilizar:** [git-release-architect](file:///c:/Projects/NODE/admin-template-free/.agents/git-release-architect/SKILL.md).
- **Acción:** Commit convencional `fix: ...` y actualización de la versión PATCH en `CHANGELOG.md`.

---

## ⚠️ DIRECTRICES GENERALES DE COMPORTAMIENTO

1. **Mantener la Integridad del Código:** Nunca elimines comentarios existentes o lógica no relacionada a menos que sea explícitamente solicitado.
2. **Uso de Enlaces Markdown:** Al mencionar archivos o clases, siempre incluye su link absoluto usando el protocolo `file://` (ej. `[UsuarioController](file:///c:/Projects/NODE/admin-template-free/src/modules/users/controllers/user.controller.ts)`).
3. **No Hardcodear Lógica:** Siempre delega la lógica del controlador a los casos de uso (backend) y no expongas variables de entorno sin encriptar.
