---
name: react-architect
description: Ultimate Enterprise Architect para Elemental ERP. Especializado en desacoplamiento, patrones de objetos en props, refactorización proactiva y mejores prácticas empresariales (Performance, A11y, Error Handling).
---

# 🚀 React Enterprise Architect

## 🏗️ 1. Arquitectura de Componentes Proactiva
- **Reusability First:** El Agente debe analizar el código antes de escribir. Si una pieza de UI (ej: un badge de estatus, un input con icono) se repite o tiene potencial de uso global, el Agente DEBE sugerir extraerlo a `src/shared/components`.
- **Clean Props Pattern:**
    - Si un componente recibe más de 3 parámetros, se DEBEN agrupar en un objeto (ej: `const MyComponent = ({ data, config, handlers }) => ...`).
    - Priorizar el paso de objetos de configuración para facilitar la escalabilidad sin cambiar la firma del componente.

## 🔗 2. Desacoplamiento Extremo (Framework Agnostic Logic)
Para facilitar una transición futura o actualizaciones mayores:
- **Logic Isolation:** La lógica compleja NO debe conocer la existencia de React. Se debe escribir en funciones puras de JavaScript/TypeScript dentro de `utils/` o `services/`.
- **Hook Bridges:** Los Custom Hooks actúan como el único puente entre la lógica pura y la UI de React.
- **Dependency Injection:** Los componentes deben recibir sus dependencias (como funciones de API) a través de hooks o props, nunca importarlas directamente desde el "mundo exterior" si son críticas.

## 📝 3. Stack Tecnológico Mandatorio
- **Forms:** `react-hook-form` (con validación Zod).
- **Server State:** `TanStack Query` (para el 90% de la data).
- **Client State:** `Redux Toolkit` (solo para UI global y Auth).
- **CSS:** Preguntar siempre: **Tailwind** o **Bootstrap**.

## 📂 4. Estructura de Directorios
- `src/features/[name]/api/services.ts`: Peticiones puras (sin hooks).
- `src/features/[name]/hooks/`: Hooks que unen TanStack Query con la UI.
- `src/features/[name]/components/`: UI específica del dominio.

## 🔌 5. Integración Basada en API Contracts
- **API First Approach:** Cuando se requiera crear o actualizar una feature que consuma una API, el Agente DEBE primero leer el contrato de la API en el backend (por ejemplo: `docs/api/contracts/[recurso].md` o equivalente).
- **Generación Automática:** A partir del contrato leído, el Agente construirá:
    1. Las interfaces o tipos de TypeScript exactos correspondientes al request/response.
    2. Los servicios y llamadas asíncronas dentro de `api/services.ts`.
    3. Los Custom Hooks de React (TanStack Query) en `hooks/` listos para consumirse.
    4. Los componentes de UI en `components/` blindados e integrados para mostrar o mutar esa data específica.

## 🛡️ 6. Manejo de Errores y Estados de Carga (Resilience)
- **Zero White Screens:** El Agente NUNCA debe dejar que una promesa rechazada rompa la app.
- **Error Boundaries:** Sugerir y usar Error Boundaries granulares a nivel de feature, no solo globables.
- **Skeletons over Spinners:** Priorizar el uso de Skeletons (UI de carga fantasmal) antes que simples spinners genéricos para evitar brincos bruscos de UI (Layout Shifts).

## ⚡ 7. Performance y Memoización Estratégica
- **Avoid Premature Optimization:** No usar `useMemo` o `useCallback` en todos lados "por si acaso".
- **Targeted Memoization:** Usarlos ÚNICAMENTE cuando se pasen referencias a componentes hijos pesados envueltos en `React.memo`, o cuando haya cálculos verdaderamente costosos.
- **Debounce/Throttle:** Asegurarse de aplicar debounce en inputs de búsqueda y llamadas recurrentes a la API.

## 📏 8. Convenciones Estrictas de Nomenclatura
- **Archivos y Componentes:** `PascalCase` (ej: `UserProfile.tsx`).
- **Hooks:** `camelCase` empezando con `use` (ej: `useUserProfile.ts`).
- **Interfaces/Tipos:** Preferir prefijar con `I` (ej: `IUserData`) o sufijos claros (ej: `UserDataProps`) según dicte la preferencia del proyecto, pero CERO tipos implícitos (`any`).

## ♿ 9. Accesibilidad (a11y) desde el Día 1
- **UI Inclusiva:** Todo componente interactivo DEBE ser navegable por teclado.
- **Aria Attributes:** Usar roles (`role="button"`, `role="dialog"`) y etiquetas adecuadas (`aria-label`, `aria-expanded`, `aria-hidden` para iconos puramente visuales).

## ✅ 10. Verificación de Completitud contra Contratos (Contract Completeness Gate)
- **CERO Endpoints Olvidados:** Antes de dar por finalizada cualquier tarea de UI que corresponda a un contrato API, el Agente DEBE hacer una verificación cruzada exhaustiva:
    1. Leer cada contrato relevante en `docs/contracts/` (o ruta equivalente).
    2. Listar TODOS los endpoints definidos (GET, POST, PUT, PATCH, DELETE).
    3. Para CADA endpoint verificar que existen:
        - ✅ Tipo/Interfaz TypeScript del Request y Response.
        - ✅ Función de servicio en `api/services.ts`.
        - ✅ Custom Hook en `hooks/`.
        - ✅ Componente de UI (lista, formulario, detalle, acción) que lo consume.
        - ✅ Ruta registrada en el router si el componente es una página.
    4. Si falta algún elemento, el Agente DEBE implementarlo antes de marcar la tarea como completada.
- **Checklist Explícita:** Al finalizar, el Agente debe incluir en su resumen una tabla o checklist mapeando cada endpoint → artefactos generados, para que el usuario pueda auditarlo.

## 🔍 11. Campos de Referencia a Entidades (Smart Entity Selectors)
- **UUID → Searchable Select:** Cuando un formulario tenga un campo de tipo UUID que haga referencia a otra entidad del sistema (ej: `patientId`, `doctorId`, `serviceId`), el Agente DEBE:
    1. **Analizar** si existe un endpoint de listado (GET) para esa entidad referenciada.
    2. **Si existe:** Renderizar el campo como un **Select con buscador** (combobox/autocomplete) que cargue las opciones desde el hook correspondiente, mostrando un label legible (ej: nombre + cédula) en vez del UUID crudo.
    3. **Si NO existe:** Documentar la limitación y usar un input de texto como fallback temporal, dejando un comentario `// TODO: Convertir a searchable select cuando exista el endpoint GET /entidad`.
- **Patrón Recomendado:** Crear un componente reutilizable `SearchableSelect` en `src/shared/components/` que acepte:
    - `options: { value: string; label: string }[]`
    - `isLoading: boolean`
    - `placeholder: string`
    - `onSearch?: (query: string) => void` (para filtrado server-side si la lista es grande)
- **Nunca exponer UUIDs crudos al usuario** en la interfaz; siempre mostrar el nombre u identificador legible de la entidad.
