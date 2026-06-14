import 'package:flutter/material.dart';

import 'carousel_page.dart';
import 'tiles_page.dart';
import 'buttons_page.dart';
import 'colors_page.dart';
import 'complex_form_page.dart';
import 'fields_page.dart';
import 'indicators_page.dart';
import 'loaders_page.dart';
import 'login_page.dart';
import 'modal_bottom_sheet_page.dart';
import 'pickers_page.dart';
import 'messages_page.dart';
import 'popup_page.dart';
import 'scaffold_page.dart';
import 'statistics_page.dart';
import 'tables_page.dart';
import 'tabs_page.dart';
import 'texts_page.dart';
import 'loading_page.dart';
import 'views_discover_page.dart';
import 'wrapper_page.dart';

/// Demo pages in the same order as the home drawer (Basics, Advanced, Views).
enum DemoPageId {
  colors,
  texts,
  buttons,
  fields,
  loaders,
  pickers,
  indicators,
  tables,
  tabs,
  message,
  scaffold,
  wrapper,
  popups,
  modalBottomSheet,
  carousel,
  tiles,
  discover,
  loading,
  statistics,
  form,
  login;

  /// Human-readable title, aligned with the home drawer labels.
  String get displayTitle => switch (this) {
        DemoPageId.colors => 'Colors',
        DemoPageId.texts => 'Texts',
        DemoPageId.buttons => 'Buttons',
        DemoPageId.fields => 'Fields',
        DemoPageId.loaders => 'Loaders',
        DemoPageId.pickers => 'Pickers',
        DemoPageId.indicators => 'Indicators',
        DemoPageId.tables => 'Tables',
        DemoPageId.tabs => 'Tabs',
        DemoPageId.message => 'Messages',
        DemoPageId.scaffold => 'Scaffold',
        DemoPageId.wrapper => 'Wrapper',
        DemoPageId.popups => 'Popups',
        DemoPageId.modalBottomSheet => 'Modal Bottom',
        DemoPageId.carousel => 'Carousel',
        DemoPageId.tiles => 'Tiles',
        DemoPageId.discover => 'Discover',
        DemoPageId.loading => 'Loading',
        DemoPageId.statistics => 'Statistics',
        DemoPageId.form => 'Book event',
        DemoPageId.login => 'Login',
      };
}

class DemoPages {
  DemoPages._();

  /// Prev/next navigation: Basics + Advanced (ends at [DemoPageId.tiles]).
  static const List<DemoPageId> navigableOrder = [
    DemoPageId.colors,
    DemoPageId.texts,
    DemoPageId.buttons,
    DemoPageId.fields,
    DemoPageId.loaders,
    DemoPageId.pickers,
    DemoPageId.indicators,
    DemoPageId.tables,
    DemoPageId.tabs,
    DemoPageId.message,
    DemoPageId.scaffold,
    DemoPageId.wrapper,
    DemoPageId.popups,
    DemoPageId.modalBottomSheet,
    DemoPageId.carousel,
    DemoPageId.tiles,
  ];

  static const List<DemoPageId> order = navigableOrder;

  static int indexOf(DemoPageId id) => order.indexOf(id);

  static bool hasPrevious(DemoPageId id) => indexOf(id) > 0;

  static bool hasNext(DemoPageId id) => indexOf(id) < order.length - 1;

  static DemoPageId? previous(DemoPageId id) {
    final index = indexOf(id);
    return index > 0 ? order[index - 1] : null;
  }

  static DemoPageId? next(DemoPageId id) {
    final index = indexOf(id);
    return index < order.length - 1 ? order[index + 1] : null;
  }

  static Widget pageFor(DemoPageId id) {
    return switch (id) {
      DemoPageId.colors => const ColorsPage(),
      DemoPageId.texts => const TextsPage(),
      DemoPageId.buttons => const ButtonsPage(),
      DemoPageId.fields => const FieldsPage(),
      DemoPageId.loaders => const LoadersPage(),
      DemoPageId.pickers => const PickersPage(),
      DemoPageId.indicators => const IndicatorsPage(),
      DemoPageId.tables => const TablesPage(),
      DemoPageId.tabs => const TabsPage(),
      DemoPageId.message => const MessagesPage(),
      DemoPageId.scaffold => const ScaffoldPage(),
      DemoPageId.wrapper => const WrapperPage(),
      DemoPageId.popups => const PopupPage(),
      DemoPageId.modalBottomSheet => const ModalBottomSheetPage(),
      DemoPageId.carousel => const CarouselPage(),
      DemoPageId.tiles => const TilesPage(),
      DemoPageId.discover => const ViewsDiscoverPage(),
      DemoPageId.loading => const LoadingPage(),
      DemoPageId.statistics => const StatisticsPage(),
      DemoPageId.form => const ComplexFormPage(),
      DemoPageId.login => const LoginPage(),
    };
  }

  /// Navigates to [id] with a horizontal slide transition.
  ///
  /// [direction.back]: new page enters from the left (Material pop / back).
  /// [direction.forward]: new page enters from the right (Material push).
  static void navigateTo(
    BuildContext context,
    DemoPageId id, {
    required DemoPageDirection direction,
  }) {
    Navigator.pushReplacement(
      context,
      _DemoPageRoute(
        page: pageFor(id),
        direction: direction,
      ),
    );
  }
}

/// Horizontal slide direction for demo prev/next navigation.
enum DemoPageDirection {
  back,
  forward,
}

class _DemoPageRoute extends PageRouteBuilder<void> {
  _DemoPageRoute({
    required Widget page,
    required DemoPageDirection direction,
  }) : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            final begin = direction == DemoPageDirection.forward ? const Offset(1, 0) : const Offset(-1, 0);
            final tween = Tween<Offset>(begin: begin, end: Offset.zero).chain(
              CurveTween(curve: Curves.easeInOut),
            );
            return SlideTransition(
              position: animation.drive(tween),
              child: child,
            );
          },
        );
}
