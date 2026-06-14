import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/pages/demo_pages.dart';
import 'package:flutter/material.dart';

const kDemoLogoUrl =
    'https://raw.githubusercontent.com/lorenzo9598/caravaggio_ui/refs/heads/main/assets-for-api-docs/logo.png';

/// Polished app-bar title for demo [CustomScaffold] / [CScaffold] pages.
///
/// Pairs with scroll-hide and title alignment; the app bar [Row] keeps the title
/// between the leading control and any trailing [CScaffold.action].
Widget demoScaffoldTitle(String text) {
  return CText.headline(
    text,
    size: TextSize.small,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: const TextStyle(
      fontWeight: FontWeight.w600,
      letterSpacing: -0.25,
      height: 1.1,
    ),
  ).primary;
}

/// App-bar title using [DemoPageId.displayTitle] (aligned with drawer labels).
Widget demoScaffoldTitleFor(DemoPageId id) => demoScaffoldTitle(id.displayTitle);

/// Logo title for the Colors demo (typically [Alignment.centerRight]).
Widget demoScaffoldColorsTitle() {
  return Semantics(
    label: DemoPageId.colors.displayTitle,
    child: ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 36, maxWidth: 132),
      child: Image.network(
        kDemoLogoUrl,
        fit: BoxFit.contain,
        filterQuality: FilterQuality.medium,
      ),
    ),
  );
}
