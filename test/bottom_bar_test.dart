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

  testWidgets('tapping a destination reports its index', (tester) async {
    var selected = 0;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: StatefulBuilder(
            builder: (context, setState) {
              return CBottomBar(
                currentIndex: selected,
                onTap: (index) => setState(() => selected = index),
                items: const [
                  CBottomBarItem(icon: Icons.home_outlined, label: 'Home'),
                  CBottomBarItem(icon: Icons.search, label: 'Cerca'),
                  CBottomBarItem(icon: Icons.person_outline, label: 'Profilo'),
                ],
              );
            },
          ),
        ),
      ),
    );

    expect(find.text('Home'), findsOneWidget);
    await tester.tap(find.text('Profilo'));
    await tester.pumpAndSettle();

    expect(selected, 2);
  });
}
