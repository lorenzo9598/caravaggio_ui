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
    Key? key,
    required this.header,
    required this.rows,
  }) : super(key: key);

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
                ...header.titles
                    .map(
                      (title) => Expanded(
                        child: Center(
                          child: Text(title,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: const TextStyle(color: Colors.white)),
                        ),
                      ),
                    )
                    .toList(),
              ],
            ),
          ),
          ...rows.map((row) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              child: Row(
                children: [
                  ...row.values
                      .map((value) => Expanded(
                            child: Center(
                              child: Text(value,
                                  style: const TextStyle(color: Colors.black)),
                            ),
                          ))
                      .toList(),
                ],
              ),
            );
          })
        ],
      ),
    );
  }
}

/// Class representing the header of the table.
class CTableHeader {
  /// The titles of the table header.
  final List<String> titles;

  /// Constructs a [CTableHeader] object.
  const CTableHeader({
    required this.titles,
  });
}

/// Class representing a row in the table.
class CTableRow {
  /// The values of the row.
  final List<String> values;

  /// Constructs a [CTableRow] object.
  const CTableRow({
    required this.values,
  });
}
