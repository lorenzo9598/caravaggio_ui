import 'dart:developer';

import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';

const SizedBox _spacer = SizedBox(height: 20);
const SizedBox _spacerSmall = SizedBox(height: 10);
const Icon _icon = Icon(Icons.star);
const Icon _suffixIcon = Icon(Icons.star);
const CFieldDecoration _decoration = CFieldDecoration(labelText: "Label here", hintText: "Write something here", prefixIcon: _icon);
const Text _buttonText = Text("Click here");
const List<String> _options = ["Option 1", "Option 2", "Option 3"];

final CFieldDecoration _textFieldDecoration = _decoration.copyWith(suffixIcon: _suffixIcon);
final LinearGradient _gradient = CGradient.primaryToSecondary;
final List<CDropdownItemModel<String>> _items = [
  CDropdownItemModel<String>(value: "item1", text: "Item 1"),
  CDropdownItemModel<String>(value: "item2", text: "Item 2"),
  CDropdownItemModel<String>(value: "item3", text: "Item 3"),
];

final List<String> _headerTexts = ["Header 1", "Header 2", "Header 3"];
final List<List<String>> _rowsTexts = [
  ["Row 1", "Row 1", "Row 1"],
  ["Row 2", "Row 2", "Row 2"],
  ["Row 3", "Row 3", "Row 3"],
];

enum Page { generics, forms, views }

void main() {
  CaravaggioUI.initialize(primaryColor: const Color(0xFF662D8C), secondaryColor: const Color(0xFFED1E79));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Caravaggio UI',
      theme: CaravaggioUI.instance.themeData,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Page _selectedPage = Page.forms;

  Widget get _page {
    switch (_selectedPage) {
      case Page.generics:
        return const GenericsSection();
      case Page.forms:
        return const FormsSection();
      case Page.views:
        return const ViewsSection();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Caravaggio UI'),
      ),
      body: _page,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Generics'),
          BottomNavigationBarItem(icon: Icon(Icons.document_scanner), label: 'Forms'),
          BottomNavigationBarItem(icon: Icon(Icons.view_comfortable_rounded), label: 'Views'),
        ],
        currentIndex: _selectedPage.index,
        onTap: (int index) {
          setState(() {
            _selectedPage = Page.values[index];
          });
        },
      ),
    );
  }
}

class GenericsSection extends StatelessWidget {
  const GenericsSection({super.key});

  Widget get _textStyles => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CText.body("Default", size: TextSize.small),
          CText.body("Primary", size: TextSize.small).primary,
          CText.body("Secondary", size: TextSize.small).secondary,
          CText.body("Bold", size: TextSize.small).bold,
          CText.body("Italic", size: TextSize.small).italic,
        ],
      );

  Widget get _gradients => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _gradient("primaryLight", CGradient.primaryLight),
          _gradient("primaryDark", CGradient.primaryDark),
          _gradient("primaryHighContrast", CGradient.primaryHighContrast),
          _gradient("secondaryLight", CGradient.secondaryLight),
          _gradient("secondaryDark", CGradient.secondaryDark),
          _gradient("secondaryHighContrast", CGradient.secondaryHighContrast),
          _gradient("primaryToSecondary", CGradient.primaryToSecondary),
          _gradient("primaryLightToSecondaryLight", CGradient.primaryLightToSecondaryLight),
          _gradient("primaryDarkToSecondaryDark", CGradient.primaryDarkToSecondaryDark),
          _gradient("reverse", CGradient.primaryToSecondary.reverse),
          _gradient("opacity(0.5)", CGradient.primaryToSecondary.opacity(0.5)),
          _gradient(
              "custom(primaryLightToSecondaryDark, centerLeftToTopRight, opacity)",
              CGradient.custom(
                colors: CGradientColorType.primaryLightToSecondaryDark,
                direction: CGradientDirection.centerLeftToTopRight,
                opacity: 1,
              )),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _spacer,
            CText.title("Text Sizes", size: TextSize.large),
            _textStyles,
            _spacer,
            CText.title("Gradients", size: TextSize.large),
            _gradients,
          ],
        ),
      ),
    );
  }

  static Widget _gradient(String text, LinearGradient gradient) => Container(height: 100, decoration: BoxDecoration(gradient: gradient), child: Center(child: Text(text)));
}

class FormsSection extends StatefulWidget {
  const FormsSection({super.key});

  @override
  State<FormsSection> createState() => _FormsSectionState();
}

class _FormsSectionState extends State<FormsSection> {
  Widget get _buttons {
    final CButton elevated = CButton.elevated(suffixIcon: _suffixIcon, icon: _icon, onPressed: _onPressed, child: _buttonText);
    final CButton outlined = CButton.outlined(suffixIcon: _suffixIcon, icon: _icon, onPressed: _onPressed, child: _buttonText);
    final CButton text = CButton.text(suffixIcon: _suffixIcon, icon: _icon, onPressed: _onPressed, child: _buttonText);

    return Column(
      children: [
        elevated,
        _spacerSmall,
        CButton.elevated(suffixIcon: _suffixIcon, icon: _icon, gradient: _gradient, onPressed: _onPressed, child: _buttonText),
        _spacerSmall,
        outlined,
        _spacerSmall,
        text,
        _spacerSmall,
        elevated.xSmall,
        _spacerSmall,
        elevated.small,
        _spacerSmall,
        elevated.medium,
        _spacerSmall,
        elevated.large,
        _spacerSmall,
        elevated.xLarge,
        _spacerSmall,
        elevated.xxLarge,
      ],
    );
  }

  Widget get _textFields {
    return Column(
      children: [
        CTextField.simple(decoration: _textFieldDecoration, onChanged: _onFieldChanged),
        _spacerSmall,
        CTextField.bordered(decoration: _textFieldDecoration, onChanged: _onFieldChanged),
        _spacerSmall,
        CTextField.filled(decoration: _textFieldDecoration, onChanged: _onFieldChanged),
        _spacerSmall,
        CTextField.borderedFilled(decoration: _textFieldDecoration, onChanged: _onFieldChanged),
      ],
    );
  }

  Widget get _autocomplete {
    return Column(
      children: [
        CAutocomplete<String>.simple(options: _options, decoration: _decoration, optionsValueToMatch: (value) => value.toLowerCase(), displayStringForOption: (value) => value, searchItems: () {}),
        _spacerSmall,
        CAutocomplete<String>.bordered(options: _options, decoration: _decoration, optionsValueToMatch: _optionsValueToMatch, displayStringForOption: (value) => value, searchItems: () {}),
        _spacerSmall,
        CAutocomplete<String>.filled(options: _options, decoration: _decoration, optionsValueToMatch: _optionsValueToMatch, displayStringForOption: (value) => value, searchItems: () {}),
        _spacerSmall,
        CAutocomplete<String>.borderedFilled(options: _options, decoration: _decoration, optionsValueToMatch: _optionsValueToMatch, displayStringForOption: (value) => value, searchItems: () {}),
      ],
    );
  }

  Widget get _dropdowns {
    return Column(
      children: [
        CDropdown<String>.simple(items: _items, decoration: _decoration, onChanged: _onChanged),
        _spacerSmall,
        CDropdown<String>.filled(items: _items, decoration: _decoration, onChanged: _onChanged),
        _spacerSmall,
        CDropdown<String>.bordered(items: _items, decoration: _decoration, onChanged: _onChanged),
        _spacerSmall,
        CDropdown<String>.borderedFilled(items: _items, decoration: _decoration, onChanged: _onChanged),
      ],
    );
  }

  Widget get _checkboxes {
    final CCheckboxController controller = CCheckboxController();
    return CCheckbox(controller: controller, label: "Checkbox");
  }

  Widget get _radiobuttons {
    final List<CRadioItem<String>> items = _options.map((value) => CRadioItem<String>(value: value, label: value)).toList();
    final CRadioController<String> controller = CRadioController<String>(initialValue: _options.first);
    return Column(
      children: [
        CRadioGroup<String>(values: items, controller: controller, orientation: CRadioGroupOrientation.vertical, crossAxisAlignment: CRadioCrossAxisAlignment.start),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text("Buttons", style: TextStyle(fontSize: 24)),
            _buttons,
            _spacer,
            const Text("Text Fields", style: TextStyle(fontSize: 20)),
            _textFields,
            _spacer,
            const Text("Autocomplete", style: TextStyle(fontSize: 20)),
            _autocomplete,
            _spacer,
            const Text("Dropdowns", style: TextStyle(fontSize: 20)),
            _dropdowns,
            _spacer,
            const Text("Checkboxes", style: TextStyle(fontSize: 20)),
            _checkboxes,
            _spacer,
            const Text("Radio buttons", style: TextStyle(fontSize: 20)),
            _radiobuttons,
          ],
        ),
      ),
    );
  }

  void _onPressed() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Button pressed')));
  }

  void _onChanged(String? value) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(value ?? 'No value')));
  }

  void _onFieldChanged(String value) {
    log(value);
  }

  String _optionsValueToMatch(String value) {
    return value.toLowerCase();
  }
}

class ViewsSection extends StatefulWidget {
  const ViewsSection({super.key});

  @override
  State<ViewsSection> createState() => _ViewsSectionState();
}

class _ViewsSectionState extends State<ViewsSection> {
  Widget get _tables {
    final header = CTableHeader(titles: _headerTexts);
    final rows = _rowsTexts.map((row) => CTableRow(values: row)).toList();

    return CTable(
      header: header,
      rows: rows,
    );
  }

  Widget get _circularIndicators {
    return Column(
      children: [
        CCircularIndicator.single(currentValue: 64, maxValue: 100, label: "Value 1"),
        _spacerSmall,
        CCircularIndicator.double(currentExternalValue: 64, maxExternalValue: 100, currentInternalValue: 87, maxInternalValue: 100, internalLabel: "Value 1", externalLabel: "Value 2"),
      ],
    );
  }

  Widget get _progress {
    return Column(
      children: [
        CCircularProgressIndicator.primary(),
        _spacerSmall,
        CCircularProgressIndicator.secondary(),
        _spacerSmall,
        CLinearProgressIndicator.primary(),
        _spacerSmall,
        CLinearProgressIndicator.secondary(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            CText.title("Tables", size: TextSize.large),
            _tables,
            _spacer,
            CText.title("Circular Indicators", size: TextSize.large),
            _circularIndicators,
            _spacer,
            CText.title("Progress Indicators", size: TextSize.large),
            _progress,
          ],
        ),
      ),
    );
  }
}
