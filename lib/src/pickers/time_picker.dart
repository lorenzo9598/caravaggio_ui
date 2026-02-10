import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui/src/pickers/picker_localizations.dart';
import 'package:flutter/material.dart';

/// Enumeration defining the mode of the custom time picker.
/// - single: only one time can be selected
/// - multiple: multiple times can be selected
enum CustomTimePickerMode {
  single,
  multiple,
}

/// Formats a [TimeOfDay] into a string in the format "HH:MM".
String _formatTime(TimeOfDay time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final minute = time.minute.toString().padLeft(2, '0');
  return '$hour:$minute';
}

/// Custom time picker widget.
/// [mode] The mode of the custom time picker.
/// [onChanged] The callback function called when the selected times change.
/// [initialTime] The initial time of the custom time picker.
/// [initialSelectedTimes] The initial selected times of the custom time picker.
/// [intervalMinutes] The interval between the available times (default 15 minutes).
/// [maxLines] The maximum number of rows to show (optional).
/// [quickTimes] Custom quick time choices. If null, uses default quick times.
class CTimePicker extends StatefulWidget {
  const CTimePicker({
    super.key,
    required this.mode,
    required this.onChanged,
    this.initialTime,
    this.initialSelectedTimes,
    this.intervalMinutes = 15,
    this.maxLines,
    this.quickTimes,
  });

  /// The mode of the custom time picker.
  final CustomTimePickerMode mode;

  /// The callback function called when the selected times change.
  final Function(List<TimeOfDay> selectedTimes) onChanged;

  /// The initial time of the custom time picker.
  final TimeOfDay? initialTime;

  /// The initial selected times of the custom time picker.
  final List<TimeOfDay>? initialSelectedTimes;

  /// The interval between the available times (default 15 minutes).
  final int intervalMinutes;

  /// The maximum number of rows to show (optional).
  final int? maxLines;

  /// Custom quick time choices. If null, uses default quick times.
  final List<TimeOfDay>? quickTimes;

  @override
  State<CTimePicker> createState() => _CTimePickerState();
}

class _CTimePickerState extends State<CTimePicker> {
  late List<TimeOfDay> _selectedTimes;
  late ScrollController _scrollController;
  final GlobalKey _twelveOClockKey = GlobalKey();
  final GlobalKey _selectedTimeKey = GlobalKey();
  bool _hasScrolledToInitial = false;
  bool _showFullList = false; // Check if show the full list or only the quick choices

  // Default quick choices
  static const List<TimeOfDay> _defaultQuickTimes = [
    TimeOfDay(hour: 12, minute: 30),
    TimeOfDay(hour: 13, minute: 0),
    TimeOfDay(hour: 13, minute: 30),
    TimeOfDay(hour: 14, minute: 0),
    TimeOfDay(hour: 19, minute: 30),
    TimeOfDay(hour: 20, minute: 0),
    TimeOfDay(hour: 20, minute: 30),
    TimeOfDay(hour: 21, minute: 0),
  ];

  // Getter for quick times (uses custom ones if provided, otherwise defaults)
  List<TimeOfDay> get _quickTimes => widget.quickTimes ?? _defaultQuickTimes;

  @override
  void initState() {
    super.initState();
    _selectedTimes = widget.initialSelectedTimes ?? [];
    _scrollController = ScrollController();

    // Scroll to the selected time position or to 12:00 after the widget has been built
    // Use a delay to avoid interference with other widgets during the build
    // And only if it hasn't been done yet
    if (!_hasScrolledToInitial) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(const Duration(milliseconds: 100), () {
          if (mounted && !_hasScrolledToInitial) {
            _hasScrolledToInitial = true;
            _scrollToInitialTime();
          }
        });
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  /// Scrolls to the initial time.
  void _scrollToInitialTime() {
    if (!mounted || !_scrollController.hasClients) return;

    // Calculate the approximate position based on the target time index
    final timeSlots = _generateTimeSlots();
    final targetTime = _selectedTimes.isNotEmpty ? _selectedTimes.first : const TimeOfDay(hour: 12, minute: 0);
    final targetIndex = timeSlots.indexWhere((time) => time.hour == targetTime.hour && time.minute == targetTime.minute);

    if (targetIndex == -1) return;

    // Calculate the approximate position
    // Assume 4 elements per row and ~52px per row
    const double approximateRowHeight = 52.0;
    const int itemsPerRow = 4;
    final targetRow = targetIndex ~/ itemsPerRow;
    final scrollPosition = targetRow * approximateRowHeight;

    // Scroll using the ScrollController instead of Scrollable.ensureVisible
    // to avoid interference with the TabController
    Future.delayed(const Duration(milliseconds: 100), () {
      if (mounted && _scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final targetScroll = scrollPosition.clamp(0.0, maxScroll);
        _scrollController.animateTo(
          targetScroll,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  /// Checks if a time is selected.
  bool _isTimeSelected(TimeOfDay time) {
    return _selectedTimes.any((t) => t.hour == time.hour && t.minute == time.minute);
  }

  /// Handles the tap event on a time.
  void _onTimeTap(TimeOfDay time) {
    setState(() {
      if (widget.mode == CustomTimePickerMode.single) {
        // Single mode: replace the previous selection
        _selectedTimes = [time];
      } else {
        // Multiple mode: add or remove the time
        if (_isTimeSelected(time)) {
          _selectedTimes = _selectedTimes.where((t) => !(t.hour == time.hour && t.minute == time.minute)).toList();
        } else {
          _selectedTimes.add(time);
        }
      }

      // Sort the selected times
      _selectedTimes.sort((a, b) {
        if (a.hour != b.hour) {
          return a.hour.compareTo(b.hour);
        }
        return a.minute.compareTo(b.minute);
      });

      // Call the callback
      widget.onChanged(List.from(_selectedTimes));
    });
  }

  /// Adds a custom time.
  Future<void> _addCustomTime() async {
    final result = await showTimePicker(
      context: context,
      initialTime: widget.initialTime ?? TimeOfDay.now(),
    );

    if (result != null) {
      setState(() {
        if (widget.mode == CustomTimePickerMode.single) {
          _selectedTimes = [result];
        } else {
          if (!_isTimeSelected(result)) {
            _selectedTimes.add(result);
            _selectedTimes.sort((a, b) {
              if (a.hour != b.hour) {
                return a.hour.compareTo(b.hour);
              }
              return a.minute.compareTo(b.minute);
            });
          }
        }

        widget.onChanged(List.from(_selectedTimes));
      });
    }
  }

  /// Generates the time slots.
  List<TimeOfDay> _generateTimeSlots() {
    final times = <TimeOfDay>[];
    for (int hour = 0; hour < 24; hour++) {
      for (int minute = 0; minute < 60; minute += widget.intervalMinutes) {
        times.add(TimeOfDay(hour: hour, minute: minute));
      }
    }
    return times;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = PickerLocalizations.of(context);
    final timeSlots = _generateTimeSlots();

    // Calculate the approximate height of a row
    // Vertical container padding: 12 * 2 = 24
    // Text height: ~20px
    // runSpacing: 8
    // Total per row: ~52px
    const double approximateRowHeight = 52.0;
    final double? maxHeight = widget.maxLines != null ? widget.maxLines! * approximateRowHeight : null;

    final scrollView = Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: timeSlots.map((time) {
            final isSelected = _isTimeSelected(time);
            final isTwelveOClock = time.hour == 12 && time.minute == 0;
            // Assign the key to the first selected time or to 12:00 if there are no selections
            final isFirstSelected = _selectedTimes.isNotEmpty && time.hour == _selectedTimes.first.hour && time.minute == _selectedTimes.first.minute;
            final shouldHaveKey = isTwelveOClock || isFirstSelected;
            return GestureDetector(
              onTap: () => _onTimeTap(time),
              child: _TimeItem(
                key: shouldHaveKey ? (isFirstSelected ? _selectedTimeKey : _twelveOClockKey) : null,
                time: time,
                isSelected: isSelected,
              ),
            );
          }).toList(),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (!_showFullList) ...[
          // Quick choices mode
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CText.body(localizations.quickChoices).bold,
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _quickTimes.map((time) {
                    final isSelected = _isTimeSelected(time);
                    return GestureDetector(
                      onTap: () => _onTimeTap(time),
                      child: _TimeItem(time: time, isSelected: isSelected),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                // "Show more" button
                OutlinedButton(
                  onPressed: () {
                    setState(() {
                      _showFullList = true;
                    });
                  },
                  child: CText.body(localizations.showMore),
                ),
              ],
            ),
          ),
        ] else ...[
          // Full list mode
          // Grid of times
          if (maxHeight != null)
            ConstrainedBox(
              constraints: BoxConstraints(maxHeight: maxHeight),
              child: scrollView,
            )
          else
            Expanded(child: scrollView),
          // Button to add custom time
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: OutlinedButton.icon(
              onPressed: _addCustomTime,
              icon: const Icon(Icons.add),
              label: Text(localizations.customTime),
            ),
          ),
        ],
        // Selected times list (only in multiple mode)
        if (widget.mode == CustomTimePickerMode.multiple && _selectedTimes.isNotEmpty) ...[
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localizations.selectedTimes,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: _selectedTimes.map((time) {
                    return Chip(
                      key: ValueKey('${time.hour}-${time.minute}'),
                      label: CText.label(_formatTime(time)),
                      onDeleted: () {
                        setState(() {
                          _selectedTimes = _selectedTimes.where((t) => !(t.hour == time.hour && t.minute == time.minute)).toList();
                          widget.onChanged(List.from(_selectedTimes));
                        });
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

/// A widget that displays a time item.
/// [time] The time to display.
/// [isSelected] Whether the time is selected.
class _TimeItem extends StatelessWidget {
  const _TimeItem({
    super.key,
    required this.time,
    required this.isSelected,
  });

  /// The time to display.
  final TimeOfDay time;

  /// Whether the time is selected.
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? Theme.of(context).primaryColor : Colors.grey.shade300,
          width: 1,
        ),
      ),
      child: Text(
        _formatTime(time),
        style: TextStyle(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.white : Colors.black87,
        ),
      ),
    );
  }
}
