import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';

const SizedBox fillSpacer = SizedBox(height: 1240);
const SizedBox spacerSmall = SizedBox(height: 10);
const Icon demoIcon = Icon(Icons.star);
const Icon suffixIcon = Icon(Icons.star);
const CFieldDecoration demoDecoration = CFieldDecoration(labelText: "Label", hintText: "Hint text");
const Text buttonText = Text("Click here");
const List<String> options = ["Option 1", "Option 2", "Option 3"];

const CFieldDecoration textFieldDecoration = demoDecoration;
final LinearGradient demoGradient = CGradient.primaryToSecondary;
final List<CDropdownItemModel<String>> dropdownItems = [
  CDropdownItemModel<String>(value: "item1", text: "Item 1"),
  CDropdownItemModel<String>(value: "item2", text: "Item 2"),
  CDropdownItemModel<String>(value: "item3", text: "Item 3"),
];

final List<String> tableHeaderTexts = ["Header 1", "Header 2", "Header 3"];
final List<List<String>> tableRowsTexts = [
  ["Row 1", "Row 1", "Row 1"],
  ["Row 2", "Row 2", "Row 2"],
  ["Row 3", "Row 3", "Row 3"],
];
