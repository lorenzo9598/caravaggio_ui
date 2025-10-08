# Changelog

All notable changes to this project will be documented in this file.  

## [1.0.1]

- minor fixes

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
