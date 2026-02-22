---
description: Flujo de trabajo estándar para llevar cualquier nueva funcionalidad desde la concepción hasta el código probado y documentado
---

# 🚀 Workflow: New Feature Lifecycle

Este flujo define el proceso estandarizado para la "Fábrica de Software" de Antigravity. Garantiza que el trabajo pase de un experto a otro sin lagunas de contexto ni errores arquitectónicos.

---

### 🔄 Etapa 1: Definición de Negocio
- **Actor:** Project Strategist (Gema / Humano)
- **Input:** Ideas de Hadercode / Notas del cliente / Necesidad de Negocio.
- **Proceso:** Realizar mapa de producto, Benchmark Global, y listar explícitamente los **Casos de Borde (Edge Cases)**.
- **Output:** Documento `functional-requirement.md` (Guardado en `docs/requirements/`).

---

### 🗄️ Etapa 2: Diseño de Base de Datos
- **Actor:** Agente `db-architect`
- **Input:** `functional-requirement.md`.
- **Proceso:** 
  1. Leer requerimientos.
  2. Proponer esquema relacional, redundancias para reportes (Shadow Tables) y reglas de auditoría.
  3. Esperar aprobación de Hadercode.
- **Output:** Archivos de migración SQL/Prisma y Diccionario de Datos (`db-dictionary.md`).

---

### ⚙️ Etapa 3: Lógica de Backend (Clean Architecture)
- **Actor:** Agente `backend-architect`
- **Input:** `db-dictionary.md` + `functional-requirement.md`.
- **Proceso:** 
  1. Diseñar la nueva Feature aislando el Dominio (Vertical Slices).
  2. Implementar repositorios, casos de uso (ACID Transactions) y Controladores Web.
  3. Generar eventos para comunicación asíncrona si amerita.
- **Output:** Código fuente del API y el contrato `api-contract.md` exportado para el frontend.

---

### 🎨 Etapa 4: Interfaz de Usuario (React)
- **Actor:** Agente `react-architect`
- **Input:** `api-contract.md`.
- **Proceso:** 
  1. Leer contrato API.
  2. Generar interfaces TypeScript exactas.
  3. Crear custom hooks con TanStack Query y construir los componentes UI reusables.
- **Output:** Vistas integradas, tipadas y consumiendo el Backend real.

---

### 🧪 Etapa 5: Calidad y Blindaje (QA)
- **Actor:** Agente `qa-engineer`
- **Input:** Código de Backend y Frontend recién generado.
- **Proceso:** 
  1. Cruce del código contra los "Casos de Borde" del `functional-requirement.md`.
  2. Escribir tests (Jest/Vitest) enfocándose en precisión contable (Decimales) y reglas de oro.
- **Output:** Test Suite aprobada y **Reporte de Riesgos** obligatorio (Critical Path & Side Effects).

---

### 📖 Etapa 6: Cierre y Documentación Técnica
- **Actor:** Agente `doc-writer`
- **Input:** Código final aprobado + `functional-requirement.md`.
- **Proceso:** 
  1. Dibujar diagramas Mermaid (Secuencia / ERD).
  2. Actualizar README técnico en la ruta respectiva.
  3. Generar borrador del manual de usuario (Español) y actualizar versionado.
- **Output:** `CHANGELOG.md` actualizado y documentación lista en `/docs/`.

---

> 💡 **Cómo invocar este workflow en Antigravity:**
> Escribe en el chat: *"Inicia el workflow de feature nueva para el módulo X. Ejecuta la Etapa 2 usando el skill db-architect basándote en este archivo [ruta_del_doc]"*.