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

To ensure seamless integration and optimal performance of CarvaggioUI within your Flutter application, it's crucial to follow a simple initialization process. By initializing the library in the main function and setting the theme parameter of MaterialApp with the generated themeData from CarvaggioUI, you'll unlock its full potential and elevate the visual appeal of your app.

Here's a step-by-step guide to integrating CarvaggioUI effectively:

**Initialize CarvaggioUI in the Main Function:**
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

**Set Theme Parameter of MaterialApp:**
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

_WIP: to translate_
Per uniformità grafica carvaggio UI espone Ctext e cgradients. Due classi che cercano di fornire metodi facili, intuitivi e facilmente memorizzabili perché possano essere facilmente utilizzabili in qualsiasi momento durante lo sviluppo dell'app.

#### `CText`

_WIP: to translate_
CText è una estensione di TextStyle che aggiunge una serie di mettodi getter per aggiunger dimesione colore e stile.
Invocando il getter CText.style non si fa altro che creare un nuovo TextStyle al cui è possibile dare una dimensione

```dart
CText.style.bodyMedium
```

_WIP: to translate_
secondo la seguente tabella

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

_WIP: to translate_
un colore

```dart
CText.style.primary
CText.style.primaryLight
CText.style.primaryDark
CText.style.secondary
CText.style.secondaryLight
CText.style.secondaryDark
```

_WIP: to translate_
e uno stile

```dart
CText.style.italic
CText.style.bold
```

_WIP: to translate_
Dunque puoi decidere di unire tutti questi getter a tuo piacimento per formare lo stile che preferisci in maniera facile veloce ed intuitiva

```dart
CText.style.bodyMedium.primary.bold
```

#### `CGradients`

_WIP: to translate_
CGradientColorType è un enum con tutte coppie di colori presenti nel tema di caravaggio. Le combinazioni sono unilateriali poiché è previsto il metodo reverse che inverte la direzinoe del colore.

_WIP: add image_

_WIP: to translate_
CGradientDirection è un enum che espone tutte le possibili direzioni del gradient. anche in questo caso si prende in considerazione da sinsitra a destra in quanto esiste il metodo reverse.

_WIP: add image_

_WIP: to translate_
CGradient è una estensione di LinearGradient. Espone alcuni getter per avere la maggior parte dei linear gradient a disposizione in maniera facile, veloce ed intuitiva. Di default la direzione è CGradientDirection.topLeftToBottomRight e i getter sono:

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

_WIP: to translate_
Esistono tuttavia i metodi custom(CGradientColorType,CGradientDirection, {double}), get reverse e opacity(dobule)

### Form

_WIP: to translate_
La sezione forms espone alcuni degli elementi di una form

#### `CButtons`

_WIP_

```dart
CButton.elevated
CButton.outlined
CButton.text
CButton.elevatedSmall
CButton.outlinedSmall
CButton.textSmall
```

#### `CTextField`

_WIP_

```dart
CTextField.simple
CTextField.bordered
CTextField.filled
CTextField.borderedFilled
```

#### `CAutocomplete`

_WIP_

```dart
CAutocomplete<T>.simple
CAutocomplete<T>.bordered
CAutocomplete<T>.filled
CAutocomplete<T>.borderedFilled
```

#### `CDropdown`

_WIP_

```dart
CDropdown<T>.simple
CDropdown<T>.bordered
CDropdown<T>.filled
CDropdown<T>.borderedFilled
```

#### `CCheckbox`

_WIP_

```dart
final CCheckboxController controller = CCheckboxController();
    return CCheckbox(controller: controller, label: "Checkbox");
```

#### `CRadioGroup`

_WIP_

```dart
final List<CRadioItem<String>> items = _options.map((value) => CRadioItem<String>(value: value, label: value)).toList();
    final CRadioController<String> controller = CRadioController<String>(initialValue: _options.first);
    return Column(
      children: [
        CRadioGroup<String>(values: items, controller: controller, orientation: CRadioGroupOrientation.vertical, crossAxisAlignment: CRadioCrossAxisAlignment.start),
      ],
    );
```

### Components

_WIP_

#### `CTable`

_WIP_

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

_WIP_

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

_WIP_

```dart
//Circular Progress Indicators
CCircularProgressIndicator.primary(),
CCircularProgressIndicator.secondary(),

//Linear Progress Indicators
CLinearProgressIndicator.primary(),
CLinearProgressIndicator.secondary(),
```

## Additional information

TODO: Tell users more about the package: where to find more information, how to contribute to the package, how to file issues, what response they can expect from the package authors, and more.
