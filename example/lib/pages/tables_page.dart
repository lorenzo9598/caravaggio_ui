import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/pages/demo_pages.dart';
import 'package:caravaggio_ui_app/widgets/demo_scaffold_title.dart';
import 'package:caravaggio_ui_app/widgets/scaffold.dart';
import 'package:caravaggio_ui_app/widgets/section.dart';
import 'package:flutter/material.dart';

import 'page_constants.dart';

class TablesPage extends StatelessWidget {
  const TablesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final header = CTableHeader(
      titles: tableHeaderTexts.map((title) => CTableCell(text: title)).toList(),
    );
    final rows = tableRowsTexts.map((row) => CTableRow(values: row.map((cell) => CTableCell(text: cell)).toList())).toList();

    return CustomScaffold(
      demoPageId: DemoPageId.tables,
      title: demoScaffoldTitleFor(DemoPageId.tables),
      bodyBuilder: (context, topPadding) {
        return Sections(
          padding: EdgeInsets.only(top: topPadding + 12, left: 16, right: 16, bottom: 12),
          sections: [
            Section(
              title: 'Table Example',
              icon: Icons.table_chart_outlined,
              items: [
                ('Table Example', CTable(header: header, rows: rows)),
              ],
            ),
          ],
        );
      },
    );
  }
}
