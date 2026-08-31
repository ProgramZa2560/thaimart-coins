# Coin Market — Flutter Mobile Assignment

A cryptocurrency market app built with **Flutter 3.47 (Dart 3.13)** using the
[Coinranking API v2](https://coinranking.com/api/documentation).

## Features

- Coin list (10 coins per page, infinite scroll, no "Load more" button)
- Market cap formatted with 2 decimals + suffix (trillion / billion / million)
- Price change with red/green arrow badges
- Top 3 coins section (hidden while searching, coins excluded from the main list)
- Coin details (bottom sheet on phones, side pane on tablets/landscape)
- "Read more" link (hidden when no website), "No description" placeholder
- Loading / error states with retry (full page and load-more)
- Pull to refresh (disabled while searching)
- Search with 1s debounce, pagination, empty state and clear button
- "Invite Friends" items inserted at positions 5, 10, 20, 40, 80, 160, … (opens share sheet)
- Internationalization (English)

## Getting started

```bash
flutter pub get
flutter run --dart-define=COINRANKING_API_KEY=<your_key>
```

The API key is free — create a developer account at
https://account.coinranking.com. The key is only injected via `--dart-define`
and never hardcoded in the source code.

## Architecture

Clean Architecture with three layers, feature-first package structure:

```
lib/
├── main.dart                    # entry point, BlocObserver, DI setup
├── app.dart                     # MaterialApp, localization, theme
├── core/                        # cross-feature utilities
│   ├── constants.dart           # base URL, page size, invite URL, debounce
│   ├── formatters.dart          # money / market cap / change formatting
│   ├── theme.dart               # colors and ThemeData
│   └── di.dart                  # get_it service locator
├── l10n/                        # ARB translation files
└── features/coin/
    ├── data/
    │   ├── api/                 # CoinApiClient (Dio, auth header, error mapping)
    │   ├── models/coin.dart     # DTO / domain model
    │   └── repositories/        # CoinRepositoryImpl (implements domain contract)
    ├── domain/
    │   └── repositories/        # abstract CoinRepository
    └── presentation/
        ├── cubit/               # CoinListCubit, CoinDetailCubit
        ├── pages/               # HomePage, CoinDetailSheet, CoinDetailPane
        └── widgets/             # reusable UI components
```

### Architecture decisions

**1. Layered (Clean) architecture with a single feature module**
The domain layer exposes an abstract `CoinRepository`; the data layer implements
it. The presentation layer only depends on abstractions and models, never on
Dio directly. This keeps business rules testable in isolation and allows the
network implementation to be swapped without touching UI or logic.

**2. State management: flutter_bloc (Cubit)**
- `CoinListCubit` owns one immutable `CoinListState` that covers pagination,
  search mode, load-more and refresh flags. All transitions are explicit
  (`initial → loading → success/failure`), which makes every UI state
  reproducible and easy to unit test with `bloc_test`.
- `CoinDetailCubit` is scoped to the detail view (sheet or pane), created
  per-view via `get_it`.
- Cubit (rather than full Bloc events) is chosen because all interactions are
  simple method calls; it keeps boilerplate low while retaining the
  single-state-object discipline the requirement asks for.

**3. Dependency injection with get_it**
Constructor injection end-to-end; cubits are registered as factories so every
screen instance gets fresh state. No global mutable state.

**4. DTO-as-domain-model**
The assignment scope has one entity, so a separate domain entity would only
duplicate fields. `Coin` is an immutable Equatable model parsed defensively
(null-safe parsing of numeric strings). If the app grows, this model maps 1:1
to a future domain entity.

**5. Presentation-side row composition**
Invite-friend rows and the Top-3 section are presentation concerns, so they are
computed in the UI layer (`_rows()`) instead of polluting the repository or
cubit state. The cubit state stays a pure list of coins; list position logic
(5, 10, 20, 40, …) is a pure, testable function of the displayed list.

**6. Responsive layout**
Single source of truth for the coin list. On viewports wider than 800 dp
(tablet/landscape/web) the layout switches to two panes: a fixed-width list on
the left and the selected coin's detail on the right (no bottom sheet).
Narrow viewports use the phone layout from the design files.

**7. Error handling**
The API client maps non-success statuses and HTTP failures into Dart
exceptions; cubits translate them into typed states (`failure`,
`loadingMoreFailed`) so the UI can offer "Try again" exactly where the failure
happened (first page vs. next page vs. detail).

## Testing

```bash
flutter test
```

- **Repository tests** — verify correct parameters are passed to the API client
  and errors propagate.
- **Cubit tests** (`bloc_test`) — every state transition: first page, load
  more (append, short page ends pagination, failure), search, clear search,
  refresh, refresh suppressed while searching.
- `Coin` uses `Equatable`, so state equality is verified on field values.

## CI/CD

Two GitHub Actions workflows:

### `.github/workflows/ci.yml` — runs on every push and pull request
1. **analyze** — `flutter analyze --fatal-infos` (zero issues enforced)
2. **test** — `flutter test` with coverage artifact
3. **scan** — secret scan on `lib/` (fails the build if a key is committed)

### `.github/workflows/cd.yml` — runs on push to `main` (or manual dispatch)
1. **build-android** — release APK artifact
2. **build-ios** — unsigned IPA artifact (`--no-codesign`)
3. **build-web** — release web bundle (API key injected via `--dart-define`
   from the `COINRANKING_API_KEY` repository secret)
4. **deploy-web** — publishes the web build to **GitHub Pages**

Live web app: https://programza2560.github.io/thaimart-coins/

Downloadable APK/IPA artifacts are attached to each CD run under
*Actions → CD → Artifacts*.

Required repository secret: `COINRANKING_API_KEY`.
