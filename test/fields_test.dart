import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    CaravaggioUI.initialize(
      primaryColor: const Color(0xFF406565),
      secondaryColor: const Color(0xFFC4A35A),
    );
  });

  testWidgets('text field shows its validation message', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            autovalidateMode: AutovalidateMode.always,
            child: CTextField.bordered(
              decoration: const CFieldDecoration(labelText: 'Nome'),
              validator: (value) => (value == null || value.isEmpty) ? 'Il nome è obbligatorio' : null,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Il nome è obbligatorio'), findsOneWidget);
    expect(find.text('Nome'), findsOneWidget);
  });

  testWidgets('dropdown shows its validation message', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Form(
            autovalidateMode: AutovalidateMode.always,
            child: CDropdown<String>.bordered(
              items: [
                CDropdownItemModel(value: 'a', text: 'Opzione A'),
              ],
              decoration: const CFieldDecoration(labelText: 'Scelta'),
              validator: (value) => value == null ? 'Scegli un valore' : null,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Scegli un valore'), findsOneWidget);
    expect(find.text('Scelta'), findsOneWidget);
  });
}
