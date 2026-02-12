import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';

import 'page_constants.dart';

class TablesPage extends StatelessWidget {
  const TablesPage({super.key});

  static const double _cardPadding = 16.0;

  @override
  Widget build(BuildContext context) {
    final header = CTableHeader(
      titles: tableHeaderTexts.map((title) => CTableCell(text: title)).toList(),
    );
    final rows = tableRowsTexts.map((row) => CTableRow(values: row.map((cell) => CTableCell(text: cell)).toList())).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Tables')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: CText.headline('Table Example', size: TextSize.small),
            ),
            Container(
              padding: const EdgeInsets.all(_cardPadding),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(AppRadius.m),
                boxShadow: AppShadow.sm,
              ),
              child: CTable(header: header, rows: rows),
            ),
          ],
        ),
      ),
    );
  }
}
