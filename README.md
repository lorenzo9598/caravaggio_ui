<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# CaravaggioUI

A comprehensive UI package designed to streamline your Flutter app development process. Built with flexibility and customization in mind, CaravaggioUI offers a wide range of beautifully crafted UI components to help you create stunning user interfaces with ease.

## Features

| Style                                                                                                                 | Forms                                                                                                                | Components                                                                                                                     |
| --------------------------------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------ |
| ![Style section image](https://github.com/lorenzo9598/caravaggio_ui/blob/main/assets-for-api-docs/styles_section.gif) | ![Forms section image](https://github.com/lorenzo9598/caravaggio_ui/blob/main/assets-for-api-docs/forms_section.gif) | ![Components section image](https://github.com/lorenzo9598/caravaggio_ui/blob/main/assets-for-api-docs/components_section.gif) |

## Getting started

Within your main.dart file, initiate CarvaggioUI to harness its capabilities. This initialization step is essential for accessing CarvaggioUI's rich set of features seamlessly.

```dart
void main() {
  CaravaggioUI.initialize(
    primaryColor: const Color(0xFF662D8C),
    secondaryColor: const Color(0xFFED1E79),
  );
  runApp(const MainApp());
}
```

After initialization, ensure that you set the theme parameter of MaterialApp with the themeData provided by CarvaggioUI. This step guarantees consistent visual styling across your entire application.

```dart
class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caravaggio UI',
      theme: CaravaggioUI.instance.themeData,
      home: const HomeScreen(),
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

```dart
ThemeData themeData => CaravaggioUI.instance.themeData;

MaterialColor primary = CarvaggioUI.instance.primary;
MaterialColor secondary = CarvaggioUI.instance.secondary;

Color primaryColor = CarvaggioUI.instance.primaryColor;
Color primaryColorLight = CarvaggioUI.instance.primaryColorLight;
Color primaryColorDark = CarvaggioUI.instance.;

Color secondaryColor = CarvaggioUI.instance.secondaryColor;
Color secondaryColorLight = CarvaggioUI.instance.secondaryColorLight;
Color secondaryColorDark = CarvaggioUI.instance.secondaryColorDark;
```

### Generics

For graphic uniformity, Caravaggio UI introduces CText and CGradients. These are two classes that aim to provide easy, intuitive, and easily memorable methods so they can be readily used at any point during app development.

#### `CText`

CText is an extension of TextStyle that adds a series of getter methods to include dimensions, colors, and styles. Invoking the CText.style getter simply creates a new TextStyle to which can be applied dimensions:

| Name                                            | Size |
| ----------------------------------------------- | ---- |
| <p style="font-size:57px">Display Large</p>     | 57   |
| <p style="font-size:52px">Display Medium </p>   | 52   |
| <p style="font-size:44px">Display Small </p>    | 44   |
| <p style="font-size:44px">Headline Large </p>   | 40   |
| <p style="font-size:36px"> Headline Medium </p> | 36   |
| <p style="font-size:32px">Headline Small </p>   | 32   |
| <p style="font-size:28px"> Title Large </p>     | 28   |
| <p style="font-size:24px"> Title Medium </p>    | 24   |
| <p style="font-size:20px"> Title Small </p>     | 20   |
| <p style="font-size:24px">Body Large </p>       | 24   |
| <p style="font-size:20px"> Body Medium </p>     | 20   |
| <p style="font-size:16px"> Body Small </p>      | 16   |
| <p style="font-size:14px"> Label Large </p>     | 14   |
| <p style="font-size:12px">Label Medium </p>     | 12   |
| <p style="font-size:11px">Label Small </p>      | 11   |

colors

```dart
CText.style.primary
CText.style.primaryLight
CText.style.primaryDark
CText.style.secondary
CText.style.secondaryLight
CText.style.secondaryDark
```

and style

_CText.style.italic_
**CText.style.bold**

So, you can choose to combine all these getters as you prefer to form the style you prefer in an easy, quick, and intuitive way. For example:

![CText styles exemples](https://github.com/lorenzo9598/caravaggio_ui/blob/main/assets-for-api-docs/text_styles.png)

#### `CGradients`

CGradientColorType is an enum containing all color pairs present in the Caravaggio theme. The combinations are unilateral since the reverse method is provided to invert the color direction

![CGradientColorType explanatory image](https://github.com/lorenzo9598/caravaggio_ui/blob/main/assets-for-api-docs/gradient_colors.png)

CGradientDirection is an enum that exposes all possible gradient directions. Similarly, it considers left to right by default, as the reverse method is available

![CGradientDirection explanatory image](https://github.com/lorenzo9598/caravaggio_ui/blob/main/assets-for-api-docs/gradient_directions.png)

CGradient is an extension of LinearGradient. It exposes several getters to provide most common linear gradients in an easy, quick, and intuitive manner. By default, the direction is CGradientDirection.topLeftToBottomRight and the getters are:

```dart
 /// Returns a primary light gradient.
  static LinearGradient get primaryLight => _generate(CGradientColorType.primaryLightToPrimary, CGradientDirection.topLeftToBottomRight);

  /// Returns a primary dark gradient.
  static LinearGradient get primaryDark => _generate(CGradientColorType.primaryToPrimaryDark, CGradientDirection.topLeftToBottomRight);

  /// Returns a primary high contrast gradient.
  static LinearGradient get primaryHighContrast => _generate(CGradientColorType.primaryLightToPrimaryDark, CGradientDirection.topLeftToBottomRight);

  /// Returns a secondary light gradient.
  static LinearGradient get secondaryLight => _generate(CGradientColorType.secondaryLightToSecondary, CGradientDirection.topLeftToBottomRight);

  /// Returns a secondary dark gradient.
  static LinearGradient get secondaryDark => _generate(CGradientColorType.secondaryToSecondaryDark, CGradientDirection.topLeftToBottomRight);

  /// Returns a secondary high contrast gradient.
  static LinearGradient get secondaryHighContrast => _generate(CGradientColorType.secondaryLightToSecondaryDark, CGradientDirection.topLeftToBottomRight);

  /// Returns a gradient from primary to secondary colors.
  static LinearGradient get primaryToSecondary => _generate(CGradientColorType.primaryToSecondary, CGradientDirection.topLeftToBottomRight);

  /// Returns a gradient from primary light to secondary light colors.
  static LinearGradient get primaryLightToSecondaryLight => _generate(CGradientColorType.primaryLightToSecondaryLight, CGradientDirection.topLeftToBottomRight);

  /// Returns a gradient from primary dark to secondary dark colors.
  static LinearGradient get primaryDarkToSecondaryDark => _generate(CGradientColorType.primaryDarkToSecondaryDark, CGradientDirection.topLeftToBottomRight);
```

If the linear gradient you're looking for isn't exposed in any of these methods, you can create one using the `custom(CGradientCGradientColorType colors, CGradientDirection direction, double opacity = 1)` method with `reverse` getter.

```dart
LinearGradient customGradient = custom(
    colors: CGradientColorType.primaryLightToSecondaryLight,
    direction: CGradientDirection.topLeftToBottomRight,
    opacity: 0.3).reverse;
```

### Form

#### `CButtons`

The CButton class enables easy and fast creation of buttons according to the CaravaggioUI style. It features three types of buttons, each with its corresponding small version.

1. Elevated `elevated`
2. Elevated Small `elevated`
3. Outlined `outlined`
4. Outlined Small `outlinedSmall`
5. Text `text`
6. Text Small `textSmall`

```dart
CButton.elevated({
    child: Text('Press me'),
    icon: Icon(Icons.star),
    suffixIcon: Icon(Icons.star),
    gradient: CGradients.primaryToSecodnary,
})
```

![CButton explanatory image](https://github.com/lorenzo9598/caravaggio_ui/blob/main/assets-for-api-docs/buttons.png)

#### `CTextField`, `CAutocomplete`, `CDropdown`

The available input fields in Caravaggio are `CTextField`, `CAutocomplete` and `CDropdown`. All three can be in the following forms:

1. simple
2. bordered
3. filled
4. borderedFilled

![CButton explanatory image](https://github.com/lorenzo9598/caravaggio_ui/blob/main/assets-for-api-docs/text_field.png)

##### `CTextField`

```dart
CTextField.simple(
    decoration: CFieldDecoration(
        labelText: "Label here",
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
        labelText: "Label here",
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
        labelText: "Label here",
        hintText: "Write something here",
        prefixIcon: Icon(Icons.star),
    ),
    onChanged: (_) => //...do stuff
),

```

#### `CCheckbox`

```dart
CCheckbox(controller: CCheckboxController(), label: "Checkbox");
```

#### `CRadioGroup`

```dart
final List<CRadioItem<String>> items = [
    CRadioItem<String>(value: "option1", label: "Option 1"),
    CRadioItem<String>(value: "option2", label: "Option 2"),
    CRadioItem<String>(value: "option3", label: "Option 3"),
];

final CRadioController<String> controller = CRadioController<String>(initialValue: "option1");

CRadioGroup<String>(
    values: items,
    controller: controller,
    orientation: CRadioGroupOrientation.vertical,
    crossAxisAlignment: CRadioCrossAxisAlignment.start,
),
```

### Others

In addition to input fields, CaravaggioUI also includes various graphical elements for visualizing the app's state.

![CButton explanatory image](https://github.com/lorenzo9598/caravaggio_ui/blob/main/assets-for-api-docs/components.png)

#### `CTable`

```dart
final CTableHeader header = CTableHeader(titles: ["Header 1", "Header 2", "Header 3"]);
final _rows =
    ["Row 1", "Row 1", "Row 1"],
    ["Row 2", "Row 2", "Row 2"],
    ["Row 3", "Row 3", "Row 3"]

final List<CTableRow> rows = _rows.map((row) => CTableRow(values: row)).toList();

CTable(header: header, rows: rows);

```

#### `Circular Indicator`

```dart
CCircularIndicator.single(
    label: "Value 1",
    currentValue: 64,
    maxValue: 100,
),

CCircularIndicator.double(
    internalLabel: "Value 1",
    currentExternalValue: 64,
    maxExternalValue: 100,
    externalLabel: "Value 2",
    currentInternalValue: 87,
    maxInternalValue: 100,
),
```

#### `Progress Indicator`

```dart
//Circular Progress Indicators
CCircularProgressIndicator.primary(),
CCircularProgressIndicator.secondary(),

//Linear Progress Indicators
CLinearProgressIndicator.primary(),
CLinearProgressIndicator.secondary(),
```

## Additional information

_WIP_
