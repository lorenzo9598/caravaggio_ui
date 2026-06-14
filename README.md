# CaravaggioUI

<div align="center">
    <img src="https://raw.githubusercontent.com/lorenzo9598/caravaggio_ui/refs/heads/main/assets-for-api-docs/logo.png" alt="Caravaggio UI logo" width="300">
</div>

<br />

A comprehensive UI package designed to streamline your Flutter app development process. Built with flexibility and customization in mind, CaravaggioUI offers a wide range of beautifully crafted UI components to help you create stunning user interfaces with ease.

## Table of contents

- [Getting started](#getting-started)
- [Usage](#usage)
- [Colors](#colors)
- [Design tokens](#design-tokens)
- [Generics](#generics)
  - [CText](#ctext)
  - [CGradient](#cgradient)
- [Form](#form)
  - [CButton](#cbutton)
  - [CTextField, CAutocomplete, CDropdown](#ctextfield-cautocomplete-cdropdown)
  - [CDatePicker and CTimePicker](#cdatepicker-and-ctimepicker)
  - [CCheckbox](#ccheckbox)
  - [CRadioGroup](#cradiogroup)
- [Views](#views)
  - [CScaffold](#cscaffold)
  - [CTabs](#ctabs)
  - [CPopup and showCPopup](#cpopup-and-showcpopup)
  - [CModalBottomSheet and showCModalBottomSheet](#cmodalbottomsheet-and-showcmodalbottomsheet)
  - [CToast](#ctoast)
  - [CWrapper](#cwrapper)
  - [CIconBadge](#ciconbadge)
  - [CCarousel](#ccarousel)
  - [CTagChip](#ctagchip)
  - [CTile](#ctile)
- [Indicators & data](#indicators--data)
  - [CTable](#ctable)
  - [CCircularIndicator](#ccircularindicator)
  - [Progress indicators](#progress-indicators)
  - [CLoader](#cloader)

## Getting started

Within your `main.dart` file, initialize CaravaggioUI before calling `runApp`. This step is required to access the theme and components.

```dart
void main() {
  CaravaggioUI.initialize(
    primaryColor: const Color(0xFF662D8C),
    primaryColorLight: const Color(0xFFB58AD6), // optional
    primaryColorDark: const Color(0xFF3F145A),  // optional
    secondaryColor: const Color(0xFFED1E79),
    secondaryColorLight: const Color(0xFFFF7BB5), // optional
    secondaryColorDark: const Color(0xFFB3004C),  // optional
  );

  runApp(const MainApp());
}
```

Then pass the generated theme to `MaterialApp` and wrap the app with [CToast] so toast messages can be shown from any route:

```dart
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caravaggio UI',
      theme: CUI.themeData,
      builder: (context, child) => CToast(child: child ?? const SizedBox.shrink()),
      home: const HomeScreen(),
    );
  }
}
```

## Usage

After initialization, use [CUI] and [CColors] for theme and palette access. [CaravaggioUI.instance] remains available but its direct color getters are deprecated in favor of [CColors].

```dart
ThemeData themeData = CUI.themeData;

MaterialColor primary = CColors.primary;
MaterialColor secondary = CColors.secondary;

Color primaryColor = CColors.primaryColor;
Color secondaryColor = CColors.secondaryColor;
```

## Colors

[CColors] exposes the full palette generated from your primary and secondary colors, including light/dark variants and on-color tones.

```dart
Color primaryColorLight = CColors.primaryColorLight;
Color secondaryColorLight = CColors.secondaryColorLight;
Color primaryColorDark = CColors.primaryColorDark;
Color secondaryColorDark = CColors.secondaryColorDark;

Color onPrimary = CColors.onPrimaryColor;
Color onSecondary = CColors.onSecondaryColor;
```

Update colors at runtime with [CaravaggioUI.updateColors]. Wrap widgets that read [CColors] or [CGradient] in [CColorsBuilder] so they rebuild when the palette changes:

```dart
CaravaggioUI.instance.updateColors(
  primaryColor: const Color(0xFF00695C),
  secondaryColor: const Color(0xFFFF6F00),
);

CColorsBuilder(
  builder: (context) => CButton.elevated(
    onPressed: () {},
    child: CText.label('Themed button'),
  ),
)
```

## Design tokens

Shared spacing, radius, shadow, and color helpers used across components:

| Class | Purpose |
| --- | --- |
| [AppRadius] | Corner radii (`AppRadius.s`, `AppRadius.m`, `AppRadius.l`, …) |
| [AppSpacing] | Consistent padding and gaps |
| [AppShadow] | Card and surface shadows (`AppShadow.sm`, …) |
| [AppColors] | Semantic colors independent of the theme palette |

Use them in custom widgets or when overriding component defaults:

```dart
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.all(AppRadius.m),
    boxShadow: AppShadow.sm,
  ),
  padding: EdgeInsets.all(AppSpacing.sm),
  child: CText.body('Custom card'),
)
```

## Generics

### CText

[CText] extends [Text] with factory constructors for labels, body, titles, headlines, and display styles. Each accepts a [TextSize] (`small`, `medium`, `large`).

```dart
CText.label('Label', size: TextSize.small),
CText.body('Body', size: TextSize.medium),
CText.title('Title', size: TextSize.large),
CText.headline('Headline', size: TextSize.medium),
CText.display('Display', size: TextSize.large),
```

Style modifiers can be chained. The last override wins:

```dart
CText.body('Primary', size: TextSize.medium).primary,
CText.body('Secondary', size: TextSize.medium).secondary,
CText.body('Bold', size: TextSize.medium).bold,
CText.body('Italic', size: TextSize.medium).italic,
CText.body('Underline', size: TextSize.medium).underline,
CText.body('Custom', size: TextSize.medium).withColor(Colors.blue),
CText.body('Custom size', size: TextSize.medium).withSize(11),
CText.body('Custom weight', size: TextSize.medium).withWeight(FontWeight.bold),
```

### CGradient

[CGradient] provides theme-aware [LinearGradient] presets and a customizable factory.

```dart
final LinearGradient gradient = CGradient.primaryLight;
final LinearGradient gradient = CGradient.primaryToSecondary;
final LinearGradient gradient = CGradient.primaryLightToSecondaryLight;
final LinearGradient gradient = CGradient.primaryDarkToSecondaryDark;

CGradient.primaryToSecondary.reverse;
CGradient.primaryToSecondary.opacity(0.5);

CGradient.custom(
  colors: CGradientColorType.primaryLightToSecondaryDark,
  direction: CGradientDirection.centerLeftToTopRight,
  opacity: 1,
);
```

[CGradientDirection] covers all common directions. Use `.reverse` on any preset to flip it.

## Form

### CButton

[CButton] supports elevated, outlined, text, and icon-only variants. Size modifiers scale the button height:

```dart
CButton.elevated(
  onPressed: () {},
  icon: Icon(Icons.star),
  suffixIcon: Icon(Icons.arrow_forward),
  gradient: CGradient.primaryToSecondary,
  iconAlignment: CButtonIconAlignment.spaceBetween,
  child: CText.label('Press me'),
);

CButton.outlined(
  onPressed: () {},
  child: CText.label('Outlined'),
);

CButton.text(
  onPressed: () {},
  child: CText.label('Text button'),
);

CButton.icon(
  onPressed: () {},
  icon: Icons.settings_outlined,
);
```

Size getters: `.xSmall`, `.small`, `.medium`, `.large`, `.xLarge`, `.xxLarge`.

Optional press animation via `animationDuration` and `animationCurve`. Gradient buttons accept `foregroundColor` for label contrast.

### CTextField, CAutocomplete, CDropdown

Input fields share four visual styles: `simple`, `bordered`, `filled`, and `borderedFilled`. Radius is controlled through [CFieldDecoration]:

```dart
CTextField.simple(),
CTextField.bordered(),
CTextField.filled(),
CTextField.borderedFilled(),

CTextField.filled(decoration: const CFieldDecoration(radius: AppRadius.m)),
```

##### CTextField

```dart
CTextField.simple(
  decoration: CFieldDecoration(
    labelText: 'Label',
    hintText: 'Write something here',
    prefixIcon: Icon(Icons.star),
    suffixIcon: Icon(Icons.star),
  ),
  onChanged: (_) {
    // ...
  },
);
```

##### CAutocomplete

```dart
CAutocomplete<String>.simple(
  options: ['Option 1', 'Option 2', 'Option 3'],
  decoration: CFieldDecoration(
    labelText: 'Label',
    hintText: 'Write something here',
    prefixIcon: Icon(Icons.star),
  ),
  optionsValueToMatch: (value) => value.toLowerCase(),
  displayStringForOption: (value) => value,
  searchItems: () {
    // ...
  },
);
```

##### CDropdown

```dart
CDropdown<String>.simple(
  items: [
    CDropdownItemModel<String>(value: 'item1', text: 'Item 1'),
    CDropdownItemModel<String>(value: 'item2', text: 'Item 2'),
    CDropdownItemModel<String>(value: 'item3', text: 'Item 3'),
  ],
  decoration: CFieldDecoration(
    labelText: 'Label',
    hintText: 'Select an option',
    prefixIcon: Icon(Icons.star),
  ),
  onChanged: (_) {
    // ...
  },
);
```

### CDatePicker and CTimePicker

[CDatePicker] is re-exported from the `caravaggio_calendar_picker` package. [CTimePicker] ships with CaravaggioUI. Both support single or multiple selection.

```dart
CDatePicker(
  mode: CustomDatePickerMode.single,
  onChanged: (dates) {
    // Handle selected dates
  },
);

CTimePicker(
  mode: CustomTimePickerMode.single,
  onChanged: (times) {
    // Handle selected times
  },
);
```

### CCheckbox

```dart
CCheckbox(controller: CCheckboxController(), label: 'Checkbox');
```

### CRadioGroup

```dart
final List<CRadioItem<String>> items = [
  CRadioItem<String>(value: 'option1', label: 'Option 1'),
  CRadioItem<String>(value: 'option2', label: 'Option 2'),
  CRadioItem<String>(value: 'option3', label: 'Option 3'),
];

final CRadioController<String> controller =
    CRadioController<String>(initialValue: 'option1');

CRadioGroup<String>(
  values: items,
  controller: controller,
  orientation: CRadioGroupOrientation.vertical,
  crossAxisAlignment: CRadioCrossAxisAlignment.start,
);
```

## Views

### CScaffold

Design-system scaffold with gradient background, scroll-linked app bar overlay, optional scroll-aware title, and a configurable default back pill.

```dart
CScaffold(
  title: CText.title('Page title', size: TextSize.small),
  bodyBuilder: (context, topPadding) {
    return ListView(
      padding: EdgeInsets.only(top: topPadding),
      children: [
        // ...
      ],
    );
  },
)
```

**Layout & scroll**

| Parameter | Description |
| --- | --- |
| `body` | Content below the app bar. Ignored when `bodyBuilder` is set. |
| `bodyBuilder` | Receives `topPadding` so you can pad scrollables (`ListView`, `CustomScrollView`, …). |
| `scrollController` | Pass when the body uses a custom controller so overlay, title, and back pill react to scroll. |
| `title` | Widget in the app bar (e.g. page title). |
| `titleAlignment` | Alignment of `title` in the app bar. Default: `Alignment.center`. |
| `hideTitleOnScroll` | When true (default), title fades on scroll down and reappears on scroll up. Fade range: `kCScaffoldTitleHideScrollRange` (56 px). |
| `leading` | Left app bar control (e.g. drawer menu). When null and `showBackButton` is true, the default back pill is shown. |
| `action` | Widget pinned to the right of the app bar. |
| `drawer` | Optional `Scaffold.drawer` content. |
| `backgroundGradient` | Behind `backgroundLayers` and body. Default: `CGradient.primaryLightToSecondaryLight`. |
| `backgroundLayers` | Widgets painted above the gradient and below scrollable content. |
| `scrollOverlayColor` | Tint for the top gradient overlay while scrolling. Opacity tracks scroll offset. Default: `CColors.secondaryColorLight` when null. |
| `onBackPressed` | Callback for the default back pill. Default: `Navigator.pop`. |

**Back pill** (when `showBackButton` is true and `leading` is null)

| Parameter | Description |
| --- | --- |
| `showBackButton` | When false, no left control unless `leading` is set. Default: true. |
| `backButtonTopBackgroundAlpha` | White pill opacity at scroll offset 0. Default: `0.5`. |
| `backButtonScrolledBackgroundColor` | Pill background tint after scroll fade. Default: `CColors.secondaryColor` when null. |
| `backButtonScrolledBackgroundAlpha` | Opacity of the scrolled pill background. Default: `0.7`. |
| `backButtonBorder` | Optional border. When null, no border is drawn. |
| `backButtonIcon` | Icon for the back pill. Default: `Icons.arrow_back_ios_new_outlined`. |

Read top inset from a descendant with `CScaffold.topPaddingOf(context)`, or use `CScaffoldState.topPadding` from a `GlobalKey<CScaffoldState>`.

See the example app: `example/lib/pages/scaffold_page.dart` and `example/lib/pages/scaffold_preview_page.dart`.

### CTabs

Rounded pill tab bar backed by Material [TabBar] / [TabBarView], with a card-style content panel below.

```dart
CTabs(
  tabs: const [
    CTabItem(label: 'Overview', icon: Icons.dashboard_outlined),
    CTabItem(label: 'Stats', icon: Icons.bar_chart_outlined),
    CTabItem(label: 'Details', icon: Icons.info_outline),
  ],
  children: [
    Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CText.title('Overview'),
        CText.body('First tab content', size: TextSize.small),
      ],
    ),
    Center(child: CText.body('Stats tab content')),
    Center(child: CText.body('Details tab content')),
  ],
  onTabChanged: (index) {
    // React to tab selection
  },
)
```

For text-only tabs, use the `fromLabels` factory:

```dart
CTabs.fromLabels(
  labels: const ['First', 'Second', 'Third'],
  children: [
    Center(child: CText.body('First tab content')),
    Center(child: CText.body('Second tab content')),
    Center(child: CText.body('Third tab content')),
  ],
)
```

Enable horizontal swipes with `enableSwipe: true`. When swipe is on, set `contentHeight` if the tabs sit inside an unbounded vertical layout (e.g. a `ListView`):

```dart
CTabs.fromLabels(
  enableSwipe: true,
  contentHeight: 120,
  labels: const ['Alpha', 'Beta', 'Gamma'],
  children: [
    Center(child: CText.body('Swipe between tabs')),
    Center(child: CText.body('Native TabBarView physics')),
    Center(child: CText.body('Indicator animates with selection')),
  ],
)
```

| Parameter | Description |
| --- | --- |
| `tabs` / `labels` | Tab descriptors ([CTabItem] or strings via `fromLabels`). Must match `children.length`. |
| `children` | One widget per tab panel. |
| `controller` | Optional external [TabController]. When null, [CTabs] creates and owns one. |
| `onTabChanged` | Called when the selected tab index changes. |
| `initialIndex` | Starting tab. Default: `0`. |
| `tabBarHeight` | Height of each tab label. Default: `44`. |
| `contentPadding` | Padding around each tab panel. Default: `EdgeInsets.all(16)`. |
| `contentHeight` | Fixed height for tab content. Required when `enableSwipe` is true in unbounded layouts. |
| `enableSwipe` | When true, tab panels respond to horizontal swipes. Default: false. |

See the example app: `example/lib/pages/tabs_page.dart` and `example/lib/pages/views_tabs_page.dart`.

### CPopup and showCPopup

Centered modal dialog with a gradient icon header ([CPopupHeader]), optional body, and a row of [CButton] actions ([CPopupActionsRow]).

```dart
showCPopup(
  context: context,
  icon: Icons.info_outline,
  title: 'Confirm action',
  subtitle: 'This cannot be undone.',
  body: CText.body(
    'Review the details before continuing.',
    size: TextSize.small,
  ),
  actions: [
    CPopupAction(
      label: 'Cancel',
      style: CPopupActionStyle.outlined,
      onPressed: () {},
    ),
    CPopupAction(
      label: 'Confirm',
      onPressed: () {
        // Action runs after the dialog is dismissed
      },
    ),
  ],
);
```

| Parameter | Description |
| --- | --- |
| `icon` | Header icon shown in [CIconBadge]. |
| `title` | Primary header text. |
| `subtitle` | Optional secondary header text. |
| `body` | Optional content between header and actions. |
| `actions` | Footer buttons as [CPopupAction] entries. Each action pops the route, then runs `onPressed`. |
| `barrierDismissible` | Whether tapping outside closes the dialog. Default: true. |
| `elevation` | [Dialog] elevation. Default: `8`. |

[CPopupActionStyle] offers `elevated` (filled) and `outlined` (bordered) button styles.

See the example app: `example/lib/pages/popup_page.dart` and `example/lib/pages/views_dialogs_page.dart`.

### CModalBottomSheet and showCModalBottomSheet

Bottom sheet with the same header pattern as [CPopup], a required body, and optional footer actions.

```dart
showCModalBottomSheet(
  context: context,
  icon: Icons.tune_outlined,
  title: 'Filter results',
  subtitle: 'Adjust what appears in the list.',
  body: CText.body(
    'Choose one or more categories, then apply to update the view.',
    size: TextSize.small,
  ),
  actions: [
    CPopupAction(
      label: 'Cancel',
      style: CPopupActionStyle.outlined,
      onPressed: () {},
    ),
    CPopupAction(
      label: 'Apply',
      onPressed: () {
        // Apply filters after the sheet closes
      },
    ),
  ],
);
```

Omit `actions` for content-only sheets (e.g. a list of tappable rows). The sheet is scroll-controlled and respects keyboard insets.

| Parameter | Description |
| --- | --- |
| `icon`, `title`, `subtitle`, `body` | Same roles as [CPopup]; `body` is required. |
| `actions` | Optional footer [CPopupAction] buttons. |
| `isDismissible` | Whether tapping the scrim closes the sheet. Default: true. |
| `enableDrag` | Whether the sheet can be dragged down to dismiss. Default: true. |

See the example app: `example/lib/pages/modal_bottom_sheet_page.dart` and `example/lib/pages/views_dialogs_page.dart`.

### CToast

Overlay toasts with semantic variants and top/bottom positioning. Wrap the app root with [CToast] (see [Getting started](#getting-started)), then show messages from any descendant:

```dart
CToast.of(context).showMessage(
  variant: CToastVariant.success,
  title: 'Changes saved',
  subtitle: 'Your profile was updated successfully.',
  position: CToastPosition.top,
  duration: const Duration(seconds: 4),
);
```

| Variant | Use case |
| --- | --- |
| `CToastVariant.error` | Failures and blocking errors |
| `CToastVariant.success` | Completed actions |
| `CToastVariant.warning` | Cautionary messages |
| `CToastVariant.info` | Neutral information |

See the example app: `example/lib/pages/messages_page.dart`.

### CWrapper

Wraps content and shows a loading overlay when `loading` is true. Blocks interaction and optionally dims the child with a scrim.

```dart
CWrapper(
  loading: isLoading,
  message: isLoading ? 'Please wait…' : null,
  loader: CLoader.orbit(color: CColors.secondaryColor),
  child: MyContent(),
)
```

| Parameter | Description |
| --- | --- |
| `loading` | When true, shows the overlay on top of `child`. |
| `loader` | Custom loader widget. Defaults to [CLoader.bouncing]. |
| `message` | Optional text below the loader. |
| `scrimColor` | Overlay tint. Default: black at 35% opacity. |
| `borderRadius` | Clips the scrim to match rounded child corners. |

See the example app: `example/lib/pages/wrapper_page.dart` and `example/lib/pages/loading_page.dart`.

### CIconBadge

Rounded icon container with a gradient background. Used in [CPopupHeader], [CTile], and [CButton.icon].

```dart
CIconBadge(icon: Icons.notifications_outlined)
CIconBadge(
  icon: Icons.star_outline,
  backgroundColor: CColors.primaryColorLight.withValues(alpha: 0.2),
)
```

### CCarousel

Rounded card for horizontal carousels and featured content. The header accepts exactly one of image, gradient, or solid color (fallback: `CGradient.primaryToSecondary`). Tags are pinned to the top-left of the header; optional `onTap` makes the card tappable.

Two layouts are available via factory constructors:

- **`stacked`** — header on top (`aspectRatio`, default `16 / 9`), content below on `backgroundColor` (defaults to the theme surface).
- **`overlay`** — fixed height (`width / aspectRatio`); content sits at the bottom over a bottom-to-top scrim (`backgroundColor ?? Colors.black` at 75% opacity fading to transparent).

Use **`stackedSimple`** / **`overlaySimple`** when you prefer string slots for title, subtitle, description, and tags, plus an optional `ImageProvider` for the header image.

```dart
CCarousel.stackedSimple(
  width: 280,
  gradient: CGradient.primaryToSecondary,
  title: 'Pasta al pomodoro',
  subtitle: '4.2 · 320 kcal',
  description: 'Ricetta veloce con basilico fresco.',
  tags: const ['Food', 'Trending'],
)

CCarousel.overlaySimple(
  width: 280,
  image: const NetworkImage('https://example.com/photo.jpg'),
  title: 'Mountain retreat',
  subtitle: 'Weekend escape',
  description: 'Tap to open details.',
  tags: const ['New'],
  onTap: () {
    // Navigate or show a sheet
  },
)
```

For full control over each slot, use `stacked` or `overlay` with `Widget` parameters (`title`, `subtitle`, `description`, `bottom`, `tags`). In overlay mode, text color is your responsibility unless you use `overlaySimple` (white [CText] by default).

```dart
CCarousel.stacked(
  width: 280,
  gradient: CGradient.primaryLightToSecondaryLight,
  title: CText.title('Featured recipe'),
  subtitle: Row(
    children: [
      Icon(Icons.star, size: 16, color: Color(0xFFF5A623)),
      // ...
    ],
  ),
  description: CText.body('Any widget works in each slot.', size: TextSize.small),
  tags: const [/* custom chip widgets */],
  bottom: CButton.outlined(
    onPressed: () {},
    child: CText.label('Discover'),
  ),
)
```

| Parameter | Description |
| --- | --- |
| `width` | Required card width. |
| `aspectRatio` | Header aspect ratio. Default: `16 / 9`. In overlay mode, card height is `width / aspectRatio`. |
| `image` | Header image as a [Widget] (`stacked` / `overlay`) or [ImageProvider] (`*Simple`). Mutually exclusive with `gradient` and `color`. |
| `gradient` | Header [LinearGradient]. Mutually exclusive with `image` and `color`. |
| `color` | Solid header color. Mutually exclusive with `image` and `gradient`. |
| `backgroundColor` | Stacked: content area background. Overlay: base color for the bottom scrim. |
| `title` | Required title ([Widget] or [String] via `*Simple`). |
| `subtitle`, `description`, `bottom` | Optional content slots ([Widget] or [String] via `*Simple`). |
| `tags` | Top-left chips ([List<Widget>] or [List<String>] via `*Simple`; string tags use a badge-style chip). |
| `onTap` | When set, the card responds to taps via [InkWell]. |
| `borderRadius` | Outer clip radius. Default: `BorderRadius.all(AppRadius.l)`. |
| `boxFit` | Image fit for `*Simple` factories. Default: [BoxFit.cover]. |

See the example app: `example/lib/pages/carousel_page.dart`.

### CTagChip

Shared text badge used by [CCarousel] and [CTile] tags. Two variants: `normal` (primary tint) and `overlay` (translucent white on dark/image surfaces).

```dart
CTagChip(label: 'Food')
CTagChip(label: 'New', variant: CTagChipVariant.overlay)
```

### CTile

Rounded list/modal row with optional leading icon, center column (`header`, `content`, `footer`), and trailing chevron when tappable. Card styling uses theme surface color, border, and [AppShadow.sm].

```dart
CTile.simple(
  icon: Icons.restaurant_outlined,
  title: 'Pasta al pomodoro',
  description: 'Ricetta veloce con basilico fresco.',
  tags: const ['Food', 'Popular'],
  onTap: () {},
)

CTile.withDateTime(
  icon: Icons.event_outlined,
  title: 'Weekend brunch',
  description: 'Ristorante Da Marco · 4 persone',
  tags: const ['Booking'],
  dateTime: DateTime(2026, 6, 13, 14, 30),
  onTap: () {},
)

CTile.icon(
  icon: Icons.settings_outlined,
  title: 'Account settings',
  description: 'Email, password, and preferences',
  onTap: () {},
)
```

For full control, use the main constructor with [Widget] slots. String tags populate the header via [CTagChip]; a custom `header` widget takes precedence over `tags`. When `onTap` is null, no chevron is shown unless you pass a custom `trailing` together with `onTap`.

```dart
CTile(
  leading: CIconBadge(icon: Icons.star_outline),
  header: CText.label('Custom header'),
  content: CText.title('Any widget in each slot'),
  footer: CText.body('Secondary line', size: TextSize.small),
  trailing: CText.label('Open'),
  onTap: () {},
)
```

| Parameter | Description |
| --- | --- |
| `leading` | Left slot (e.g. [CIconBadge]). |
| `header` | Custom header row content; when set, `tags` are ignored. |
| `content` | Main body column. |
| `footer` | Optional bottom line in the center column. |
| `tags` | [List<Widget>] rendered in the header when `header` is null. |
| `dateTime` | Shown top-right in the header row (`d MMM y · HH:mm`, locale-aware). Used by [withDateTime]. |
| `trailing` | Override right slot; default chevron when `onTap` is set. |
| `onTap` | Enables [InkWell] and default chevron. |
| `backgroundColor` | Tile surface. Default: [ThemeData.cardColor]. |
| `borderRadius` | Default: `BorderRadius.all(AppRadius.m)`. |
| `padding` | Default: `EdgeInsets.all(16)`. |

See the example app: `example/lib/pages/tiles_page.dart`.

## Indicators & data

### CTable

```dart
final List<String> headerTexts = ['Header 1', 'Header 2', 'Header 3'];
final List<List<String>> rowsTexts = [
  ['Row 1', 'Row 1', 'Row 1'],
  ['Row 2', 'Row 2', 'Row 2'],
  ['Row 3', 'Row 3', 'Row 3'],
];

final header = CTableHeader(
  titles: headerTexts.map((title) => CTableCell(text: title)).toList(),
);

final rows = rowsTexts
    .map((row) => CTableRow(
          values: row.map((cell) => CTableCell(text: cell)).toList(),
        ))
    .toList();

return CTable(
  header: header,
  rows: rows,
);
```

### CCircularIndicator

```dart
CCircularIndicator.single(
  value: CircularValue(currentValue: 64, maxValue: 100),
  label: 'Value 1',
),

CCircularIndicator.double(
  externalValue: CircularValue(currentValue: 64, maxValue: 100),
  internalValue: CircularValue(currentValue: 87, maxValue: 100),
  internalLabel: 'Value 1',
  externalLabel: 'Value 2',
),

CCircularIndicator.percent(
  value: CircularValue(currentValue: 64, maxValue: 100),
  currentLabel: 'Current',
  maxLabel: 'Max',
  isDense: true,
),
```

### Progress indicators

```dart
CCircularProgressIndicator.primary(),
CCircularProgressIndicator.secondary(),

CLinearProgressIndicator.primary(),
CLinearProgressIndicator.secondary(),
```

### CLoader

Animated loaders with three factory constructors. Optional `color` (defaults to primary) and `numberOfDots` (default 3; for bouncing and pulsing, max 5).

```dart
CLoader.bouncing(),
CLoader.orbit(),
CLoader.pulsing(),

CLoader.bouncing(color: CColors.secondaryColor, numberOfDots: 5),
CLoader.orbit(color: CColors.primaryColorLight, numberOfDots: 6),
CLoader.pulsing(numberOfDots: 4),
```

See the example app: `example/lib/pages/loaders_page.dart`.
