<!--
SYNC IMPACT REPORT
==================
Version change: Initial Template -> 1.0.0
Modified principles:
  - Initialized Core Principles for E-Store project architecture, Figma design tokens, Clean Architecture, Cubit state management, go_router navigation, flutter_screenutil, and Mason brick workflows.
Added sections:
  - Phase 1 Scope & Constraints
  - Development Workflow & Quality Gates
  - Governance
Removed sections:
  - N/A (template placeholders replaced)
Templates requiring updates:
  - .specify/templates/plan-template.md (✅ aligned)
  - .specify/templates/spec-template.md (✅ aligned)
  - .specify/templates/tasks-template.md (✅ aligned)
Follow-up TODOs:
  - None
-->

# E-Store Project Constitution

## Core Principles

### I. Existing Architecture Preservation (NON-NEGOTIABLE)
The application MUST strictly preserve and extend the existing project structure (`lib/features/`, `lib/core/`, `lib/config/`, `lib/shared/`). Developers MUST NOT recreate or re-architect foundational layers or override dependencies configured in `pubspec.yaml`. All new features MUST reference existing feature structures (e.g., `lib/features/home`) as the canonical pattern.

### II. Feature-First Clean Architecture & Data Safety
Every feature MUST adhere to Feature-First Clean Architecture with explicit layer boundaries: presentation → domain ← data.
- Domain entities and use cases MUST remain decoupled from external frameworks.
- UseCases MUST return `Either<Failure, T>` using `dartz`.
- `RepositoryImpl` MUST wrap all remote data calls using `safeCall` error handling in `lib/core/`.
- Dependency injection MUST be configured via `GetIt` (`lib/core/di/`).

### III. Design Token & Figma Pixel-Perfection
All user interface elements MUST achieve a pixel-perfect match with the ShopX e-Commerce UI Kit Figma design reference.
- Default Material Design styles MUST NOT be used.
- All colors, typography, spacing, and radii MUST strictly utilize Figma design tokens defined in `lib/config/theme/` or `lib/core/res/`.
- All component and layout dimensions MUST use `flutter_screenutil` responsive extensions (`.w`, `.h`, `.r`, `.sp`).

### IV. Strict UI & State Separation
Widgets MUST remain purely declarative and strictly free of business logic.
- State management MUST use Cubit (`flutter_bloc`).
- Widgets MUST only consume state emitted by Cubits.
- All Cubit states and domain entities MUST extend `Equatable` to ensure reliable value equality and performance.
- Reusable UI widgets MUST reside in `lib/shared/widgets/`.
- All asynchronous data loading states MUST present shimmer loading placeholders using `shimmer`.

### V. Router & Shell Navigation Discipline
Application routing MUST be implemented using `go_router`.
- Primary feature screens requiring bottom navigation MUST be mounted inside a `ShellRoute` to maintain a persistent bottom navigation shell.
- Navigation state MUST be decoupled from UI widgets and triggered cleanly through `go_router` paths/names.

### VI. Scaffolding & Quality Gates
New features MUST be created using the repository's established Mason brick structure (`bricks/`).
- Presentation layers MUST be covered by automated widget tests in `test/`.
- Phase 1 implementations MUST focus on UI completeness backed by clean mock data sources.

## Phase 1 Scope & Feature Constraints

Phase 1 implementation covers UI-only screens backed by structured mock data:
1. **Home Screen**: Hero banners, product categories, and responsive product grid.
2. **Product Details Screen**: Product preview, image gallery, specification details, and action buttons.
3. **Cart Screen**: Item listing, quantity controls, price summaries, and checkout triggers.
4. **Profile Screen**: User account overview, settings entry points, and preference options.
5. **Bottom Navigation Shell**: Persistent bottom nav bar providing tab switching across primary screens.

## Development Workflow & Quality Gates

- **Feature Generation**: Developers MUST execute `mason make` with standard bricks when creating a new feature module under `lib/features/`.
- **UI Verification**: Every UI component MUST be verified against Figma token specs for padding, font weights, line heights, and colors before merging.
- **Testing Standard**: Presentation widgets MUST have corresponding widget tests in `test/features/<feature>/presentation/`.
- **State Immutability**: All states emitted by Cubits MUST be immutable and extend `Equatable`.

## Governance

- **Supremacy**: This Constitution supersedes all informal coding conventions or ad-hoc practices.
- **Compliance**: All code reviews MUST verify adherence to Clean Architecture layers, Figma design fidelity, Cubit separation, and `go_router` shell architecture.
- **Amendments**: Proposed updates to this Constitution require documentation of rationale, version updates following Semantic Versioning (MAJOR for structural paradigm shifts, MINOR for new architectural principles, PATCH for clarifications), and synchronization across `.specify/templates/`.

**Version**: 1.0.0 | **Ratified**: 2026-08-02 | **Last Amended**: 2026-08-02
