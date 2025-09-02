import 'package:caravaggio_ui/src/generics/gradients.dart';
import 'package:flutter/material.dart';

/// Widget for displaying a table with a header and rows.
class CTable extends StatelessWidget {
  /// The header of the table.
  final CTableHeader header;

  /// The rows of the table.
  final List<CTableRow> rows;

  /// Constructs a [CTable] widget.
  const CTable({
    super.key,
    required this.header,
    required this.rows,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: CGradient.primaryToSecondary.opacity(0.3),
        borderRadius: const BorderRadius.all(
          Radius.circular(12),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            decoration: BoxDecoration(
              gradient: CGradient.primaryToSecondary,
              borderRadius: const BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            child: Row(
              children: [
                ...header.titles.map(
                  (CTableCell title) => Expanded(
                    flex: title.flex,
                    child: Center(
                      child: title.text != null ? Text(title.text!, textAlign: TextAlign.center, maxLines: 2, style: const TextStyle(color: Colors.white)) : title.child!,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ...rows.map((row) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Row(
                children: [
                  ...row.values.map(
                    (value) => Expanded(
                      flex: value.flex,
                      child: Center(
                        child: value.text != null ? Text(value.text!, style: const TextStyle(color: Colors.black)) : value.child!,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

/// Class representing the header of the table.
class CTableHeader {
  /// The titles of the table header.
  final List<CTableCell> titles;

  /// Constructs a [CTableHeader] object.
  const CTableHeader({
    required this.titles,
  });
}

/// Class representing a row in the table.
class CTableRow {
  /// The values of the row.
  final List<CTableCell> values;

  /// Constructs a [CTableRow] object.
  const CTableRow({
    required this.values,
  });
}

/// Class representing a cell in the table.
class CTableCell {
  final String? text;
  final Widget? child;
  final int flex;

  const CTableCell({
    this.child,
    this.text,
    this.flex = 1,
  }) : assert(text != null || child != null, 'Either text or child must be provided.');
}
