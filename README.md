# CaravaggioUI

A comprehensive UI package designed to streamline your Flutter app development process. Built with flexibility and customization in mind, CaravaggioUI offers a wide range of beautifully crafted UI components to help you create stunning user interfaces with ease.

## Getting started

Within your main.dart file, initiate CarvaggioUI to harness its capabilities. This initialization step is essential for accessing CarvaggioUI's rich set of features seamlessly.

```dart

void  main() {

    CaravaggioUI.initialize(
        primaryColor: const  Color(0xFF662D8C),
        secondaryColor: const  Color(0xFFED1E79),
    );

    runApp(const  MainApp());
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

CText is an extension of Text widget that adds a series of factory constructors and getter methods to include dimensions, colors, and styles.

```dart

CText.body("Small", size: TextSize.small)
CText.body("Medium", size: TextSize.medium)
CText.body("Large", size: TextSize.large)
CText.body("Primary").primary
CText.body("Secondary").secondary
CText.body("Bold").bold
CText.body("Italic").italic
CText.body("withColor", size: TextSize.large).withColor(Colors.blue),
CText.body("withSize", size: TextSize.large).withSize(11),
CText.body("withWeight", size: TextSize.large).withWeight(FontWeight.bold),

```

Overrides such as `italic`, `bold`, `withColor()`, etc. are applied after merging, so they always retain the theme values.

Chaining (e.g., `CText("hello").italic.bold.size(18)`) respects the order: the last override takes precedence over previous properties.

#### `CGradients`

CGradientColorType is an enum containing all color pairs present in the Caravaggio theme. The combinations are unilateral since the reverse method is provided to invert the color direction

![CGradientColorType explanatory image](https://raw.githubusercontent.com/lorenzo9598/caravaggio_ui/refs/heads/main/assets-for-api-docs/gradient_colors.png)

CGradientDirection is an enum that exposes all possible gradient directions. Similarly, it considers left to right by default, as the reverse method is available

![CGradientDirection explanatory image](https://raw.githubusercontent.com/lorenzo9598/caravaggio_ui/refs/heads/main/assets-for-api-docs/gradient_directions.png)

CGradient is an extension of LinearGradient. It exposes several getters to provide most common linear gradients in an easy, quick, and intuitive manner. By default, the direction is CGradientDirection.topLeftToBottomRight and the getters are:

```dart

/// Returns a primary light gradient.
static  LinearGradient  get primaryLight => _generate(CGradientColorType.primaryLightToPrimary, CGradientDirection.topLeftToBottomRight);

/// Returns a primary dark gradient.
static  LinearGradient  get primaryDark => _generate(CGradientColorType.primaryToPrimaryDark, CGradientDirection.topLeftToBottomRight);

/// Returns a primary high contrast gradient.
static  LinearGradient  get primaryHighContrast => _generate(CGradientColorType.primaryLightToPrimaryDark, CGradientDirection.topLeftToBottomRight);

/// Returns a secondary light gradient.
static  LinearGradient  get secondaryLight => _generate(CGradientColorType.secondaryLightToSecondary, CGradientDirection.topLeftToBottomRight);

/// Returns a secondary dark gradient.
static  LinearGradient  get secondaryDark => _generate(CGradientColorType.secondaryToSecondaryDark, CGradientDirection.topLeftToBottomRight);

/// Returns a secondary high contrast gradient.
static  LinearGradient  get secondaryHighContrast => _generate(CGradientColorType.secondaryLightToSecondaryDark, CGradientDirection.topLeftToBottomRight);

/// Returns a gradient from primary to secondary colors.
static  LinearGradient  get primaryToSecondary => _generate(CGradientColorType.primaryToSecondary, CGradientDirection.topLeftToBottomRight);

/// Returns a gradient from primary light to secondary light colors.
static  LinearGradient  get primaryLightToSecondaryLight => _generate(CGradientColorType.primaryLightToSecondaryLight, CGradientDirection.topLeftToBottomRight);

/// Returns a gradient from primary dark to secondary dark colors.
static  LinearGradient  get primaryDarkToSecondaryDark => _generate(CGradientColorType.primaryDarkToSecondaryDark, CGradientDirection.topLeftToBottomRight);

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

2. Outlined `outlined`

3. Text `text`

```dart

final CButton button = CButton.elevated({
    child: Text('Press me'),
    icon: Icon(Icons.star),
    suffixIcon: Icon(Icons.star),
    gradient: CGradients.primaryToSecodnary,
})

```

You can also create a sized button with size getter :

```dart

button.xSmall
button.small
button.medium
button.large
button.xLarge
button.xxLarge

```

![CButton explanatory image](https://raw.githubusercontent.com/lorenzo9598/caravaggio_ui/refs/heads/main/assets-for-api-docs/buttons.png)

#### `CTextField`, `CAutocomplete`, `CDropdown`

The available input fields in Caravaggio are `CTextField`, `CAutocomplete` and `CDropdown`. All three can be in the following forms:

1. simple

2. bordered

3. filled

4. borderedFilled

![CButton explanatory image](https://raw.githubusercontent.com/lorenzo9598/caravaggio_ui/refs/heads/main/assets-for-api-docs/text_field.png)

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

### Others

In addition to input fields, CaravaggioUI also includes various graphical elements for visualizing the app's state.

![CButton explanatory image](https://raw.githubusercontent.com/lorenzo9598/caravaggio_ui/refs/heads/main/assets-for-api-docs/components.png)

#### `CTable`

```dart

final  CTableHeader header = CTableHeader(titles: ["Header 1", "Header 2", "Header 3"]);

final _rows =
    ["Row 1", "Row 1", "Row 1"],
    ["Row 2", "Row 2", "Row 2"],
    ["Row 3", "Row 3", "Row 3"]

final  List<CTableRow> rows = _rows.map((row) => CTableRow(values: row)).toList();

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

## Additional information

_WIP_
