# Changelog

All notable changes to this project will be documented in this file.  

## [1.0.3]

### Added
- **CScaffold**: design-system scaffold with gradient background, scroll-linked app bar overlay, scroll-aware title, and configurable default back pill.
  - `scrollOverlayColor` (`Color?`) — top scroll overlay gradient tint; null uses `CColors.secondaryColorLight`.
  - `backButtonScrolledBackgroundColor` (`Color?`) — back pill background when scrolled; null uses `CColors.secondaryColor`.
  - `backButtonScrolledBackgroundAlpha` (`double`, default `0.7`) — opacity of the scrolled back pill background.
  - `backButtonTopBackgroundAlpha` (`double`, default `0.5`) — white back pill opacity at scroll offset 0.
  - Also: `hideTitleOnScroll`, `titleAlignment`, `bodyBuilder`, `scrollController`, `backgroundGradient`, `backgroundLayers`, and related back-pill options.
- **CLoader**: new animated loaders with three styles:
  - `CLoader.bouncing()` — bouncing dots animation
  - `CLoader.orbit()` — dots orbiting in a circle
  - `CLoader.pulsing()` — pulsing dots animation
- Customization: `color` and `numberOfDots` (default 3) for all loaders. For bouncing and pulsing types, `numberOfDots` is limited to at most 5.
- **CCarousel**: rounded carousel card with two layouts (`stacked`, `overlay`) and simplified factories (`stackedSimple`, `overlaySimple`).
  - Header: one of image ([Widget] or [ImageProvider]), [LinearGradient], or [Color]; fallback `CGradient.primaryToSecondary`.
  - Content slots: `title`, optional `subtitle`, `description`, `bottom`, and top-left `tags`.
  - `backgroundColor`: content background in stacked mode; scrim base in overlay mode.
  - `onTap`: optional tap handler; `aspectRatio` (default `16 / 9`); required `width`.
- **CTagChip**: shared text badge for [CCarousel] and [CTile] tags (`normal` and `overlay` variants).
- **CTile**: rounded list/modal row with leading, center slots (`header`, `content`, `footer`), and optional trailing chevron.
  - Factories: `simple`, `withDateTime` (header date/time), and `icon` shortcut.
  - `tags` populate the header; `onTap` enables tap + default chevron; intrinsic height.

### Fixed
- Animation intervals for bouncing and pulsing loaders now scale correctly with `numberOfDots` and stay within valid range, avoiding assertion errors with many dots.

## [1.0.2]

- Added support to explicitly set light and dark variants for primary and secondary colors in `CaravaggioUI.initialize`.
- Improved `MaterialColor` generation to respect custom light/dark overrides when provided.
- Added `DatePicker` and `TimePicker` components to the library.

## [1.0.1]

- Minor fixes.

## [1.0.0] - 2025-09-02
First stable release of the **Caravaggio UI** package.  
Includes significant updates compared to `0.0.13`:

### Added
- Introduced `CColors` and `CUI` classes for simpler and cleaner access to colors and theme.
- Added the ability to initialize the theme with custom primary and secondary colors via `CaravaggioUI.initialize`.
- Optional support for the `fontFamily` property in the theme.
- Added handling of “onPrimary” and “onSecondary” colors with Light/Dark variants.
- Improved inline documentation with DartDoc comments.

### Changed
- Getters in `CaravaggioUI.instance` for colors have been deprecated in favor of `CColors` and `CUI`.
- Improved handling of `MaterialColor` for primary and secondary colors.
- Theme updated with Material 3 support (`useMaterial3: true`).
- Improved consistency between main colors and Light/Dark variants.
- `scaffoldBackgroundColor` handling can now be customized.

### Deprecated
- All direct color getters in `CaravaggioUI.instance` (`primaryColor`, `secondaryColor`, `onPrimaryColor`, etc.) are now marked as `@Deprecated` and replaced by `CColors`.

### Removed
- No significant removals: all previous APIs remain compatible via deprecated getters.

### Fixed
- Minor bugs in generating “onPrimary” and “onSecondary” colors for Light/Dark variants.
- Fixed references to `MaterialColor[200]` and `MaterialColor[800]` to avoid null exceptions.

---

## [0.0.13] - 2025-08-01
- Previous beta version with API for `CaravaggioUI.instance` and basic primary/secondary color handling.
- Initial theme and widget helper functionality.
- Minimal documentation.

## [0.0.12]

- `CText` bugfix

## [0.0.11]

- Added `flex` parameter to `CTableCell`.
- In `CTableHeader`, the `values` property is now a list of `CTableCell` instead of a list of `String`.

## [0.0.10]

- In the `CTableRow` class, the `values` property is now a list of `CTableCell` instead of a list of `String`. Each `CTableCell` can have either a `child` (Widget) or `text` (String).

## [0.0.9]

- Refactored `CircularIndicator` to use the new `CircularValue` class for value representation.
- Replaced previous parameters in `CircularIndicator.single(int currentValue, int maxValue)` with `CircularIndicator.single(CircularValue value)`.
- Applied the same change to `CircularIndicator.double`, now accepting `CircularValue` instances.
- Introduced `CircularIndicator.percent`, which displays a single indicator with the percentage value shown at the center and between the labels.

## [0.0.8]

Initial version
