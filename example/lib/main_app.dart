import 'dart:developer';

import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';

const SizedBox _fill = SizedBox(height: 1240);
const SizedBox _spacerSmall = SizedBox(height: 10);
const Icon _icon = Icon(Icons.star);
const Icon _suffixIcon = Icon(Icons.star);
const CFieldDecoration _decoration = CFieldDecoration(labelText: "Label");
const Text _buttonText = Text("Click here");
const List<String> _options = ["Option 1", "Option 2", "Option 3"];

const CFieldDecoration _textFieldDecoration = _decoration;
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

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Page _selectedPage = Page.generics;

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
          _fill,
          // CText.body("Primary", size: TextSize.small).primary,
          CText.body("Primary", size: TextSize.medium).primary,
          // CText.body("Primary", size: TextSize.large).primary,
          // CText.body("Secondary", size: TextSize.small).secondary,
          CText.body("Secondary", size: TextSize.medium).secondary,
          // CText.body("Secondary", size: TextSize.large).secondary,
          // CText.body("Bold", size: TextSize.small).bold,
          CText.body("Bold", size: TextSize.medium).bold,
          // CText.body("Bold", size: TextSize.large).bold,
          // CText.body("Italic", size: TextSize.small).italic,
          CText.body("Italic", size: TextSize.medium).italic,
          // CText.body("Italic", size: TextSize.large).italic,
          // CText.body("Underline", size: TextSize.small).underline,
          CText.body("Underline", size: TextSize.medium).underline,
          // CText.body("Underline", size: TextSize.large).underline,
          CText.body("withColor", size: TextSize.medium).withColor(Colors.blue),
          CText.body("withSize", size: TextSize.medium).withSize(11),
          CText.body("withWeight", size: TextSize.medium).withWeight(FontWeight.bold),
        ],
      );

  Widget get _gradients => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _gradientGroup([
            CGradient.primaryLight,
            CGradient.primaryDark,
            CGradient.primaryHighContrast,
          ]),
          _spacerSmall,
          _gradientGroup([
            CGradient.secondaryLight,
            CGradient.secondaryDark,
            CGradient.secondaryHighContrast,
          ]),
          _spacerSmall,
          _gradientGroup([
            CGradient.primaryToSecondary,
            CGradient.primaryLightToSecondaryLight,
            CGradient.primaryDarkToSecondaryDark,
          ]),
          _spacerSmall,
          _gradientGroup([
            CGradient.primaryToSecondary.reverse,
            CGradient.primaryToSecondary.opacity(0.5),
            CGradient.custom(
              colors: CGradientColorType.primaryLightToSecondaryDark,
              direction: CGradientDirection.centerLeftToTopRight,
              opacity: 1,
            ),
          ]),
        ],
      );

  Widget _buildPalette({
    required String title,
    required Color primary,
    required Color secondary,
    required Color onPrimary,
    required Color onSecondary,
  }) {
    return Expanded(
      child: Column(
        children: [
          CText.body(title, size: TextSize.large),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    color: primary,
                  ),
                  height: 80,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    // shape: BoxShape.circle,
                    color: secondary,
                  ),
                  height: 80,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                _buildPalette(
                  title: "Default",
                  primary: CColors.primaryColor,
                  secondary: CColors.secondaryColor,
                  onPrimary: CColors.onPrimaryColor,
                  onSecondary: CColors.onSecondaryColor,
                ),
                const SizedBox(width: 3),
                _buildPalette(
                  title: "Light",
                  primary: CColors.primaryColor,
                  secondary: CColors.secondaryColorLight,
                  onPrimary: CColors.onPrimaryLightColor,
                  onSecondary: CColors.onSecondaryLightColor,
                ),
                const SizedBox(width: 3),
                _buildPalette(
                  title: "Dark",
                  primary: CColors.primaryColorDark,
                  secondary: CColors.secondaryColorDark,
                  onPrimary: CColors.onPrimaryDarkColor,
                  onSecondary: CColors.onSecondaryDarkColor,
                ),
              ],
            ),
            _fill,
            _textStyles,
            _fill,
            _gradients,
            _fill,
          ],
        ),
      ),
    );
  }

  static Widget _gradient(LinearGradient gradient) => Expanded(
        child: Container(
          height: 100,
          decoration: BoxDecoration(gradient: gradient),
        ),
      );

  static Widget _gradientGroup(List<LinearGradient> gradients) {
    return Row(
      children: gradients.map(_gradient).toList(),
    );
  }
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
    final CButton text = CButton.text(
      suffixIcon: _suffixIcon,
      icon: _icon,
      onPressed: _onPressed,
      child: _buttonText,
    );

    return Column(
      children: [
        elevated,
        _spacerSmall,
        CButton.elevated(suffixIcon: _suffixIcon, icon: _icon, gradient: _gradient, onPressed: _onPressed, child: _buttonText),
        _spacerSmall,
        outlined,
        _spacerSmall,
        text,
        _fill,
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

  Widget get _textFieldsRadius {
    return Column(
      children: [
        CTextField.filled(decoration: const CFieldDecoration(labelText: "Label", radius: AppRadius.xxs), onChanged: _onFieldChanged),
        _spacerSmall,
        CTextField.filled(decoration: const CFieldDecoration(labelText: "Label", radius: AppRadius.xs), onChanged: _onFieldChanged),
        _spacerSmall,
        CTextField.filled(decoration: const CFieldDecoration(labelText: "Label", radius: AppRadius.s), onChanged: _onFieldChanged),
        _spacerSmall,
        CTextField.filled(decoration: const CFieldDecoration(labelText: "Label", radius: AppRadius.m), onChanged: _onFieldChanged),
        _spacerSmall,
        CTextField.filled(decoration: const CFieldDecoration(labelText: "Label", radius: AppRadius.l), onChanged: _onFieldChanged),
        _spacerSmall,
        CTextField.filled(decoration: const CFieldDecoration(labelText: "Label", radius: AppRadius.xl), onChanged: _onFieldChanged),
        _spacerSmall,
        CTextField.filled(decoration: const CFieldDecoration(labelText: "Label", radius: AppRadius.xxl), onChanged: _onFieldChanged),
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

  Widget get _fieldTypes {
    return Column(
      children: [
        CTextField.filled(decoration: _textFieldDecoration, onChanged: _onFieldChanged),
        _spacerSmall,
        CAutocomplete<String>.filled(options: _options, decoration: _decoration, optionsValueToMatch: _optionsValueToMatch, displayStringForOption: (value) => value, searchItems: () {}),
        _spacerSmall,
        CDropdown<String>.filled(items: _items, decoration: _decoration, onChanged: _onChanged),
      ],
    );
  }

  // Widget get _checkboxes {
  //   final CCheckboxController controller = CCheckboxController();
  //   return CCheckbox(controller: controller, label: "Checkbox");
  // }

  // Widget get _radiobuttons {
  //   final List<CRadioItem<String>> items = _options.map((value) => CRadioItem<String>(value: value, label: value)).toList();
  //   final CRadioController<String> controller = CRadioController<String>(initialValue: _options.first);
  //   return Column(
  //     children: [
  //       CRadioGroup<String>(values: items, controller: controller, orientation: CRadioGroupOrientation.vertical, crossAxisAlignment: CRadioCrossAxisAlignment.start),
  //     ],
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _spacerSmall,
            _textFieldsRadius,
            _fill,
            _textFields,
            _fill,
            _fieldTypes,
            _fill,
            _buttons,
            _fill,
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
    final header = CTableHeader(titles: _headerTexts.map((title) => CTableCell(text: title)).toList());
    final rows = _rowsTexts.map((row) => CTableRow(values: row.map((cell) => CTableCell(text: cell)).toList())).toList();

    return CTable(
      header: header,
      rows: rows,
    );
  }

  Widget get _circularIndicators {
    return Column(
      children: [
        CCircularIndicator.single(value: CircularValue(currentValue: 64, maxValue: 100), label: "Value 1"),
        _spacerSmall,
        CCircularIndicator.double(
          externalValue: CircularValue(currentValue: 64, maxValue: 100),
          internalValue: CircularValue(currentValue: 87, maxValue: 100),
          internalLabel: "Value 1",
          externalLabel: "Value 2",
        ),
        _spacerSmall,
        CCircularIndicator.percent(
          value: CircularValue(currentValue: 64, maxValue: 100),
          currentLabel: "Current",
          maxLabel: "Max",
          isDense: true,
        ),
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
            _tables,
            const Divider(
              color: Colors.grey,
              height: 20,
            ),
            _circularIndicators,
            const Divider(
              color: Colors.grey,
              height: 20,
            ),
            _progress,
          ],
        ),
      ),
    );
  }
}
