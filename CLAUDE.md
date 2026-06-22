# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

SiTeknisi is a Flutter marketplace for electronics repair services (printer, computer, laptop). A **single Flutter codebase** serves three roles — Customer mobile, Technician mobile, and Admin web — selected at runtime. The UI language is Indonesian; keep all user-facing strings in Indonesian.

This is currently a **UI/prototype phase**: all data is mocked in-memory. The Supabase + Midtrans backend described under `docs/` is the planned architecture, **not yet implemented**. Do not assume any network, auth, or persistence layer exists beyond `shared_preferences`.

## Commands

```bash
flutter pub get                          # install deps
flutter analyze                          # lint (uses flutter_lints via analysis_options.yaml)
flutter test                             # run all tests
flutter test test/admin_service_crud_test.dart   # run a single test file
flutter test --name "customer home"      # run tests matching a name
flutter run                              # run mobile (Customer/Technician) on a device
flutter run -d chrome                    # run mobile flow in browser
flutter run -d chrome --dart-define=APP_MODE=mobile   # force mobile entry on web
```

The app entry point is chosen by `APP_MODE` (`String.fromEnvironment`) in `lib/core/router/app_router.dart`: on web with `APP_MODE != 'mobile'` the router starts at the Admin login; otherwise it starts at the mobile splash screen. There is one `main.dart` — no separate entry files per role.

## Architecture

**Feature-first layout** under `lib/`:

- `core/` — cross-cutting: `router/app_router.dart` (all routes + the `AppRoutes` path constants), `theme/` (design tokens), `constants/`.
- `features/{admin,auth,customer,technician}/` — each feature has `presentation/` (screens, widgets, providers) and optionally `data/`.
- `shared/widgets/` — reusable UI components, barrel-exported via `widgets.dart`. `shared/utils/`.

**Routing**: a single `GoRouter` defined in `appRouterProvider`. All paths are declared as constants in the `AppRoutes` class — add new routes there and in the `routes:` list. Some screen classes are grouped into multi-class files (e.g. `technician_screens.dart`, `customer_flow_screens.dart`) rather than one file per screen.

**State**: Riverpod (`flutter_riverpod` v3). `main.dart` wraps the app in `ProviderScope`. New-style `Notifier`/`NotifierProvider` APIs are used (not the legacy `StateNotifier`).

**Mock data layer** (the current source of truth — there is no backend):
- `AdminMockStore` (`features/admin/data/admin_mock_store.dart`) — a `ChangeNotifier` **singleton** (`AdminMockStore.instance`) holding all admin CRUD records (users, technicians, services, bookings, payments, invoices) in nested maps. Admin screens read/mutate this directly.
- `features/customer/data/customer_dummy_data.dart` and various `*_mock_providers.dart` / `*_dummy` providers supply hardcoded lists.
- `technician_image_provider.dart` persists uploaded image bytes as base64 in `shared_preferences` — the only real persistence in the app.

**Theme / design tokens**: never hardcode colors, spacing, radii, or text styles. Use the token classes in `core/theme/`: `AppColors`, `AppSpacing`, `AppRadius`, `AppTypography`. `AppTheme.light` / `AppTheme.dark` wire these into Material 3 `ThemeData`; theme mode follows the system.

## Testing conventions

Tests in `test/` are **widget tests**, primarily verifying screens render without layout overflow at small Android viewports (e.g. `Size(360, 800)`). They pump screens inside `ProviderScope` + `MaterialApp` and assert on visible Indonesian text plus `tester.takeException()` being null. When adding or changing screens, check they pass at narrow viewports and update the asserted strings if copy changes.

## Reference docs

`docs/` holds the product/architecture spec (`SYSTEM_ARCHITECTURE.md`, `DATABASE_SCHEMA.md`, `API_SPECIFICATION.md`, `MVP_SCOPE.md`, etc.) and `docs/design/` holds the UX/UI specification and design tokens. These describe the **target** Supabase-backed system and are the reference when wiring up the real backend.
