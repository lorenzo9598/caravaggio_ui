# CaravaggioUI

<div align="center"> 
    <img src="https://raw.githubusercontent.com/lorenzo9598/caravaggio_ui/refs/heads/main/assets-for-api-docs/logo.png" alt="Caravaggio UI logo" width="300">
</div>

<br />

A comprehensive UI package designed to streamline your Flutter app development process. Built with flexibility and customization in mind, CaravaggioUI offers a wide range of beautifully crafted UI components to help you create stunning user interfaces with ease.

<br />

<p align="center"> 
    <img src="https://raw.githubusercontent.com/lorenzo9598/caravaggio_ui/refs/heads/main/assets-for-api-docs/example_app.png" alt="example of an app with Caravaggio UI design screenshots" width="450">
</p>

## Getting started

Within your main.dart file, initiate CarvaggioUI to harness its capabilities. This initialization step is essential for accessing CarvaggioUI's rich set of features seamlessly.

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

After initialization, ensure that you set the theme parameter of MaterialApp with the themeData provided by CarvaggioUI. This step guarantees consistent visual styling across your entire application.

```dart

class  MainApp  extends  StatelessWidget {

    const  MainApp({Key? key}) : super(key: key);

    @override
    Widget  build(BuildContext context) {
        return  MaterialApp(
            title: 'Caravaggio UI',
            theme: CaravaggioUI.instance.themeData,
            home: const  HomeScreen(),
        );
    }
}

```

## Usage

Upon initialization, by simply invoking

```dart

CaravaggioUI.instance

```

you'll ulock the core theme data of your application and a default color Palette, including primaryLight, primaryDark, secondaryLight, and secondaryDark. These predefined colors offer a quick and intuitive way to maintain visual consistency across your app, catering to various design needs.

### Colors

<img src="https://raw.githubusercontent.com/lorenzo9598/caravaggio_ui/refs/heads/main/assets-for-api-docs/screenshot_1.png" alt="screenshot of Caravaggio UI generated colors" width="200">


```dart

ThemeData themeData => CaravaggioUI.instance.themeData;

MaterialColor primary = CarvaggioUI.instance.primary;
MaterialColor secondary = CarvaggioUI.instance.secondary;

Color primaryColor = CarvaggioUI.instance.primaryColor;
Color secondaryColor = CarvaggioUI.instance.secondaryColor;

Color primaryColorLight = CarvaggioUI.instance.primaryColorLight;
Color secondaryColorLight = CarvaggioUI.instance.secondaryColorLight;

Color primaryColorDark = CarvaggioUI.instance.;
Color secondaryColorDark = CarvaggioUI.instance.secondaryColorDark;

```

### Generics

For graphic uniformity, Caravaggio UI introduces CText and CGradients. These are two classes that aim to provide easy, intuitive, and easily memorable methods so they can be readily used at any point during app development.

#### `CText`

CText is an extension of Text widget that adds a series of factory constructors and getter methods to include dimensions, colors, and styles.

<img src="https://raw.githubusercontent.com/lorenzo9598/caravaggio_ui/refs/heads/main/assets-for-api-docs/screenshot_2.png" alt="screenshot of Caravaggio UI generated text sizes" width="200">

```dart

CText.label("Label", size: TextSize.small),
CText.label("Label", size: TextSize.medium),
CText.label("Label", size: TextSize.large),
CText.body("Body", size: TextSize.small),
CText.body("Body", size: TextSize.medium),
CText.body("Body", size: TextSize.large),
CText.title("Title", size: TextSize.small),
CText.title("Title", size: TextSize.medium),
CText.title("Title", size: TextSize.large),
CText.headline("Headline", size: TextSize.small),
CText.headline("Headline", size: TextSize.medium),
CText.headline("Headline", size: TextSize.large),
CText.display("Display", size: TextSize.small),
CText.display("Display", size: TextSize.medium),
CText.display("Display", size: TextSize.large),

```

Overrides such as `italic`, `bold`, `withColor()`, etc. are applied after merging, so they always retain the theme values.

Chaining (e.g., `CText("hello").italic.bold.size(18)`) respects the order: the last override takes precedence over previous properties.

<img src="https://raw.githubusercontent.com/lorenzo9598/caravaggio_ui/refs/heads/main/assets-for-api-docs/screenshot_3.png" alt="screenshot of Caravaggio UI generated text getters" width="200">


```dart

CText.body("Primary", size: TextSize.medium).primary,
CText.body("Secondary", size: TextSize.medium).secondary,
CText.body("Bold", size: TextSize.medium).bold,
CText.body("Italic", size: TextSize.medium).italic,
CText.body("Underline", size: TextSize.medium).underline,
CText.body("withColor", size: TextSize.medium).withColor(Colors.blue),
CText.body("withSize", size: TextSize.medium).withSize(11),
CText.body("withWeight", size: TextSize.medium).withWeight(FontWeight.bold),

```

#### `CGradients`

With the CGradient class you can quickly get gradients that match your app's theme

<img src="https://raw.githubusercontent.com/lorenzo9598/caravaggio_ui/refs/heads/main/assets-for-api-docs/screenshot_4.png" alt="screenshot of Caravaggio UI generated gradients" width="200">

```dart

final LinearGradient gradient = CGradient.primaryLight;
final LinearGradient gradient = CGradient.primaryDark;
final LinearGradient gradient = CGradient.primaryHighContrast;

final LinearGradient gradient = CGradient.secondaryLight;
final LinearGradient gradient = CGradient.secondaryDark;
final LinearGradient gradient = CGradient.secondaryHighContrast;

final LinearGradient gradient = CGradient.primaryToSecondary;
final LinearGradient gradient = CGradient.primaryLightToSecondaryLign;
final LinearGradient gradient = CGradient.primaryDarkToSecondaryDark;

```

You can also add some customization with static getter

```dart

CGradient.primaryToSecondary.reverse,
CGradient.primaryToSecondary.opacity(0.5),

```

Or create a custom gradient using user friendly enums ready to use.

```dart

CGradient.custom(
    colors: CGradientColorType.primaryLightToSecondaryDark,
    direction: CGradientDirection.centerLeftToTopRight,
    opacity: 1,
),

```

CGradientDirection is an enum that exposes all possible gradient directions. Similarly, it considers left to right by default, as the reverse method is available

<img src="https://raw.githubusercontent.com/lorenzo9598/caravaggio_ui/refs/heads/main/assets-for-api-docs/gradient_directions.png" alt="Caravaggio UI gradient direction enum attribute for custom gradient generator" width="500">

### Form

#### `CButtons`

The CButton class enables easy and fast creation of buttons according to the CaravaggioUI style. It features three types of buttons, each with its corresponding small version.

1. Elevated `elevated`

2. Outlined `outlined`

3. Text `text`


<img src="https://raw.githubusercontent.com/lorenzo9598/caravaggio_ui/refs/heads/main/assets-for-api-docs/screenshot_8.png" alt="screenshot of Caravaggio UI CButton class" width="200">

```dart

final CButton button = CButton.elevated({
    child: Text('Press me'),
    icon: Icon(Icons.star),
    suffixIcon: Icon(Icons.star),
    gradient: CGradients.primaryToSecodnary,
})

```

You can also create a sized button with size getter :

<img src="https://raw.githubusercontent.com/lorenzo9598/caravaggio_ui/refs/heads/main/assets-for-api-docs/screenshot_9.png" alt="screenshot of Caravaggio UI CButton size gettrs" width="200">

```dart

button.xSmall
button.small
button.medium
button.large
button.xLarge
button.xxLarge

```

#### `CTextField`, `CAutocomplete`, `CDropdown`

The available input fields in Caravaggio are `CTextField`, `CAutocomplete` and `CDropdown`. All three can be in the following forms:

1. simple

2. bordered

3. filled

4. borderedFilled

and each of them can have different radius size:

<img src="https://raw.githubusercontent.com/lorenzo9598/caravaggio_ui/refs/heads/main/assets-for-api-docs/screenshot_6.png" alt="screenshot of Caravaggio UI CTextField class" width="200">
<img src="https://raw.githubusercontent.com/lorenzo9598/caravaggio_ui/refs/heads/main/assets-for-api-docs/screenshot_5.png" alt="screenshot of Caravaggio UI CTextField class AppRadius attribute" width="200">

```dart

CTextField.simple(),
CTextField.bordered(),
CTextField.filled(),
CTextField.borderedFilled(),


CTextField.filled(decoration: const CFieldDecoration(radius: AppRadius.xxs)),
CTextField.filled(decoration: const CFieldDecoration(radius: AppRadius.xs)),
CTextField.filled(decoration: const CFieldDecoration(radius: AppRadius.s)),
CTextField.filled(decoration: const CFieldDecoration(radius: AppRadius.m)),
CTextField.filled(decoration: const CFieldDecoration(radius: AppRadius.l)),
CTextField.filled(decoration: const CFieldDecoration(radius: AppRadius.xl)),
CTextField.filled(decoration: const CFieldDecoration(radius: AppRadius.xxl)),
```

`CTextField`, `CAutocomplete` and `CDropdown` looks like:

<img src="https://raw.githubusercontent.com/lorenzo9598/caravaggio_ui/refs/heads/main/assets-for-api-docs/screenshot_7.png" alt="screenshot of Caravaggio UI CTextField, CAutocomplete and CDropdown classes compared" width="200">

##### `CTextField`

```dart

CTextField.simple(
    decoration: CFieldDecoration(
        labelText: "Label",
        hintText: "Write something here",
        prefixIcon: Icon(Icons.star),
        suffixIcon: Icon(Icons.star),
    ),
    onChanged: (_) => //...do stuff,
),

```

##### `CAutocomplete`

```dart

CAutocomplete<String>.simple(
    options: ["Option 1", "Option 2", "Option 3"],
    decoration: CFieldDecoration(
        labelText: "Label",
        hintText: "Write something here",
        prefixIcon: Icon(Icons.star),
    ),
    optionsValueToMatch: (value) => value.toLowerCase(),
    displayStringForOption: (value) => value,
    searchItems: () => //...do stuff
),

```

##### `CDropdown`

```dart

CDropdown<String>.simple(
    items: [
        CDropdownItemModel<String>(value: "item1", text: "Item 1"),
        CDropdownItemModel<String>(value: "item2", text: "Item 2"),
        CDropdownItemModel<String>(value: "item3", text: "Item 3"),
    ],
    decoration: CFieldDecoration(
        labelText: "Label",
        hintText: "Write something here",
        prefixIcon: Icon(Icons.star),
    ),
    onChanged: (_) => //...do stuff
),

```

#### `CDatePicker` and `CTimePicker`

Caravaggio UI also provides ready-to-use date and time pickers with support for single or multiple selection.

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

#### `CTable`, `CCircularIndicator`, `CCircularProgressIndicator` and `CLoader`

For data representation the library adds graphical elements such as tables, circular indicators, progress indicators and animated loaders.

<img src="https://raw.githubusercontent.com/lorenzo9598/caravaggio_ui/refs/heads/main/assets-for-api-docs/screenshot_10.png" alt="screenshot of Caravaggio UI view elements classes" width="200">


#### `CTable`

```dart

final List<String> _headerTexts = ["Header 1", "Header 2", "Header 3"];
final List<List<String>> _rowsTexts = [
  ["Row 1", "Row 1", "Row 1"],
  ["Row 2", "Row 2", "Row 2"],
  ["Row 3", "Row 3", "Row 3"],
];

final header = CTableHeader(titles: _headerTexts.map((title) => CTableCell(text: title)).toList());

final rows = _rowsTexts.map((row) => CTableRow(values: row.map((cell) => CTableCell(text: cell)).toList())).toList();

return CTable(
    header: header,
    rows: rows,
);

```

#### `CCircularIndicator`

```dart

CCircularIndicator.single(value: CircularValue(currentValue: 64, maxValue: 100), label: "Value 1"),

CCircularIndicator.double(
    externalValue: CircularValue(currentValue: 64, maxValue: 100),
    internalValue: CircularValue(currentValue: 87, maxValue: 100),
    internalLabel: "Value 1",
    externalLabel: "Value 2",
),

CCircularIndicator.percent(
    value: CircularValue(currentValue: 64, maxValue: 100),
    currentLabel: "Current",
    maxLabel: "Max",
    isDense: true,
),

```

#### `CCircularProgressIndicator`

```dart

// Circular
CCircularProgressIndicator.primary(),

CCircularProgressIndicator.secondary(),

// Linear
CLinearProgressIndicator.primary(),

CLinearProgressIndicator.secondary(),

```

#### `CLoader`

Animated loaders with three factory constructors. Optional `color` (defaults to primary) and `numberOfDots` (default 3; for bouncing and pulsing, max 5).

```dart

CLoader.bouncing(),
CLoader.orbit(),
CLoader.pulsing(),

// Customized
CLoader.bouncing(color: CColors.secondaryColor, numberOfDots: 5),
CLoader.orbit(color: CColors.primaryColorLight, numberOfDots: 6),
CLoader.pulsing(numberOfDots: 4),

```

### Views

#### `CScaffold`

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

#### `CTabs`

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

See the example app: `example/lib/pages/tabs_page.dart` (component demos) and `example/lib/pages/views_tabs_page.dart` (account profile layout).

#### `CPopup` and `showCPopup`

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

See the example app: `example/lib/pages/popup_page.dart` and `example/lib/pages/views_dialogs_page.dart` (delete-account confirmation).

#### `CModalBottomSheet` and `showCModalBottomSheet`

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

See the example app: `example/lib/pages/modal_bottom_sheet_page.dart` and `example/lib/pages/views_dialogs_page.dart` (order filters and action menu).

### Others

#### `CCheckbox`

```dart

CCheckbox(controller: CCheckboxController(), label: "Checkbox");

```

#### `CRadioGroup`

```dart

final  List<CRadioItem<String>> items = [
    CRadioItem<String>(value: "option1", label: "Option 1"),
    CRadioItem<String>(value: "option2", label: "Option 2"),
    CRadioItem<String>(value: "option3", label: "Option 3"),
];

final  CRadioController<String> controller = CRadioController<String>(initialValue: "option1");

CRadioGroup<String>(
    values: items,
    controller: controller,
    orientation: CRadioGroupOrientation.vertical,
    crossAxisAlignment: CRadioCrossAxisAlignment.start,
),

```
