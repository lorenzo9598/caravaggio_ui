import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui/src/pickers/picker_localizations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Enumeration defining the mode of the custom date picker.
/// - single: only one date can be selected
/// - multiple: multiple dates can be selected
enum CustomDatePickerMode {
  single,
  multiple,
}

/// A custom date picker widget.
/// [mode] the mode of the custom date picker.
/// [onChanged] the callback function called when the selected dates change.
/// [initialDate] the initial date of the custom date picker.
/// [firstDate] the first date of the custom date picker.
/// [lastDate] the last date of the custom date picker.
/// [initialSelectedDates] the initial selected dates of the custom date picker.
class CDatePicker extends StatefulWidget {
  const CDatePicker({
    super.key,
    required this.mode,
    required this.onChanged,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    this.initialSelectedDates,
    this.weekDays,
  });

  /// The mode of the custom date picker.
  final CustomDatePickerMode mode;

  /// The callback function called when the selected dates change.
  final Function(List<DateTime> selectedDates) onChanged;

  /// The initial date of the custom date picker.
  final DateTime? initialDate;

  /// The first date of the custom date picker.
  final DateTime? firstDate;

  /// The last date of the custom date picker.
  final DateTime? lastDate;

  /// The initial selected dates of the custom date picker.
  final List<DateTime>? initialSelectedDates;

  /// The week days of the custom date picker.
  /// If null, will use localized week days based on the current locale.
  final List<String>? weekDays;

  @override
  State<CDatePicker> createState() => _CDatePickerState();
}

/// The state of the custom date picker.
class _CDatePickerState extends State<CDatePicker> {
  /// The current month of the custom date picker.
  late DateTime _currentMonth;

  /// The selected dates of the custom date picker.
  late List<DateTime> _selectedDates;

  @override
  void initState() {
    super.initState();
    _currentMonth = widget.initialDate ?? DateTime.now();
    _selectedDates = widget.initialSelectedDates ?? [];
    _selectedDates = _selectedDates.map((date) => DateTime(date.year, date.month, date.day)).toList();
  }

  void _onDateTap(DateTime date) {
    setState(() {
      final normalizedDate = DateTime(date.year, date.month, date.day);

      if (widget.mode == CustomDatePickerMode.single) {
        // Mode single: replaces the previous selection
        _selectedDates = [normalizedDate];
      } else {
        // Mode multiple: adds or removes the date
        if (_selectedDates.any((d) => d.year == normalizedDate.year && d.month == normalizedDate.month && d.day == normalizedDate.day)) {
          _selectedDates.removeWhere((d) => d.year == normalizedDate.year && d.month == normalizedDate.month && d.day == normalizedDate.day);
        } else {
          _selectedDates.add(normalizedDate);
        }
      }

      // Sort the selected dates
      _selectedDates.sort((a, b) => a.compareTo(b));

      // Call the callback
      widget.onChanged(List.from(_selectedDates));
    });
  }

  bool _isDateSelected(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    return _selectedDates.any((d) => d.year == normalizedDate.year && d.month == normalizedDate.month && d.day == normalizedDate.day);
  }

  bool _isDateEnabled(DateTime date) {
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (normalizedDate.isBefore(today)) {
      return false;
    }

    if (widget.firstDate != null) {
      final firstDate = DateTime(widget.firstDate!.year, widget.firstDate!.month, widget.firstDate!.day);
      if (normalizedDate.isBefore(firstDate)) {
        return false;
      }
    }

    if (widget.lastDate != null) {
      final lastDate = DateTime(widget.lastDate!.year, widget.lastDate!.month, widget.lastDate!.day);
      if (normalizedDate.isAfter(lastDate)) {
        return false;
      }
    }

    return true;
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1);
    });
  }

  List<DateTime> _getDaysInMonth(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay = DateTime(month.year, month.month + 1, 0);

    // Calculate the first day of the week (Monday = 1)
    int firstWeekday = firstDay.weekday;
    // Convert to Monday = 0
    firstWeekday = firstWeekday == 7 ? 0 : firstWeekday - 1;

    final days = <DateTime>[];

    // Add the days of the previous month to fill the first week
    final previousMonth = DateTime(month.year, month.month - 1);
    final daysInPreviousMonth = DateTime(previousMonth.year, previousMonth.month + 1, 0).day;
    for (int i = firstWeekday - 1; i >= 0; i--) {
      days.add(DateTime(previousMonth.year, previousMonth.month, daysInPreviousMonth - i));
    }

    // Add the days of the current month
    for (int i = 1; i <= lastDay.day; i++) {
      days.add(DateTime(month.year, month.month, i));
    }

    // Add the days of the next month to complete the last week
    final remainingDays = 42 - days.length; // 6 settimane * 7 giorni
    for (int i = 1; i <= remainingDays; i++) {
      days.add(DateTime(month.year, month.month + 1, i));
    }

    return days;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = PickerLocalizations.of(context);
    final days = _getDaysInMonth(_currentMonth);
    final today = DateTime.now();
    final weekDays = widget.weekDays ?? localizations.weekDays;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header with month and year
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: _previousMonth,
              ),
              CText.label(
                DateFormat('MMMM yyyy', localizations.localeCode).format(_currentMonth),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: _nextMonth,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // Week days names
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: weekDays.map((day) {
              return Expanded(
                child: Center(
                  child: CText.label(
                    day,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        const SizedBox(height: 8),
        // Calendar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Table(
            children: [
              for (int week = 0; week < 6; week++)
                TableRow(
                  children: [
                    for (int day = 0; day < 7; day++)
                      Builder(
                        builder: (context) {
                          final dateIndex = week * 7 + day;
                          if (dateIndex >= days.length) {
                            return const SizedBox.shrink();
                          }
                          final date = days[dateIndex];
                          final isCurrentMonthDay = date.month == _currentMonth.month;
                          final isSelected = _isDateSelected(date);
                          final isEnabled = _isDateEnabled(date);
                          final isToday = isCurrentMonthDay && date.year == today.year && date.month == today.month && date.day == today.day;

                          return GestureDetector(
                            onTap: isEnabled ? () => _onDateTap(date) : null,
                            child: Container(
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Theme.of(context).primaryColor
                                    : isToday
                                        ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
                                        : Colors.transparent,
                                shape: BoxShape.circle,
                                border: isToday && !isSelected
                                    ? Border.all(
                                        color: Theme.of(context).primaryColor,
                                        width: 2,
                                        strokeAlign: BorderSide.strokeAlignOutside,
                                      )
                                    : null,
                              ),
                              padding: const EdgeInsets.all(4),
                              child: Center(
                                child: CText.label(
                                  '${date.day}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: isSelected || isToday ? FontWeight.bold : FontWeight.normal,
                                    color: isSelected
                                        ? Colors.white
                                        : !isCurrentMonthDay
                                            ? Colors.grey.shade300
                                            : !isEnabled
                                                ? Colors.grey.shade400
                                                : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),
            ],
          ),
        ),
        if (widget.mode == CustomDatePickerMode.multiple && _selectedDates.isNotEmpty) ...[
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: _selectedDates.map((date) {
                final normalizedDate = DateTime(date.year, date.month, date.day);
                return Chip(
                  key: ValueKey('${normalizedDate.year}-${normalizedDate.month}-${normalizedDate.day}'),
                  label: CText.label(DateFormat('dd/MM', localizations.localeCode).format(date)),
                  onDeleted: () {
                    setState(() {
                      _selectedDates = _selectedDates.where((d) {
                        final dNormalized = DateTime(d.year, d.month, d.day);
                        return !(dNormalized.year == normalizedDate.year && dNormalized.month == normalizedDate.month && dNormalized.day == normalizedDate.day);
                      }).toList();
                      widget.onChanged(List.from(_selectedDates));
                    });
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ],
    );
  }
}
