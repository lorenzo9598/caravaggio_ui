import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';

class PickersPage extends StatefulWidget {
  const PickersPage({super.key});

  @override
  State<PickersPage> createState() => _PickersPageState();
}

class _PickersPageState extends State<PickersPage> {
  static const double _cardPadding = 16.0;
  static const double _sectionSpacing = 24.0;
  static const double _itemSpacing = 16.0;

  Widget _buildPickerCard({
    required String label,
    required Widget picker,
  }) {
    return Container(
      padding: const EdgeInsets.all(_cardPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(AppRadius.m),
        boxShadow: AppShadow.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CText.label(
            label,
            size: TextSize.small,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
            ),
          ),
          const SizedBox(height: 12),
          picker,
        ],
      ),
    );
  }

  Widget _buildPickerSection(
    BuildContext context,
    String title,
    List<(String label, Widget picker)> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: CText.headline(title, size: TextSize.small),
        ),
        ...items.map((item) => Padding(
              padding: EdgeInsets.only(
                bottom: items.indexOf(item) < items.length - 1 ? _itemSpacing : 0,
              ),
              child: _buildPickerCard(label: item.$1, picker: item.$2),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pickers')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildPickerSection(
              context,
              'Time Picker',
              [
                (
                  'Single Mode',
                  CTimePicker(
                    mode: CustomTimePickerMode.single,
                    maxLines: 3,
                    onChanged: (times) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Selected: ${times.map((t) => '${t.hour}:${t.minute.toString().padLeft(2, '0')}').join(', ')}'),
                        ),
                      );
                    },
                  ),
                ),
                (
                  'Multiple Mode',
                  CTimePicker(
                    mode: CustomTimePickerMode.multiple,
                    maxLines: 3,
                    onChanged: (times) {
                      // Multiple mode handles selection internally
                    },
                  ),
                ),
                (
                  'Custom Quick Times',
                  CTimePicker(
                    mode: CustomTimePickerMode.single,
                    maxLines: 3,
                    quickTimes: const [
                      TimeOfDay(hour: 8, minute: 0),
                      TimeOfDay(hour: 9, minute: 0),
                      TimeOfDay(hour: 10, minute: 0),
                      TimeOfDay(hour: 17, minute: 0),
                      TimeOfDay(hour: 18, minute: 0),
                    ],
                    onChanged: (times) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Selected: ${times.map((t) => '${t.hour}:${t.minute.toString().padLeft(2, '0')}').join(', ')}'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: _sectionSpacing),
            _buildPickerSection(
              context,
              'Date Picker',
              [
                (
                  'Single Mode',
                  CDatePicker(
                    mode: CustomDatePickerMode.single,
                    onChanged: (dates) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Selected: ${dates.map((d) => '${d.day}/${d.month}/${d.year}').join(', ')}'),
                        ),
                      );
                    },
                  ),
                ),
                (
                  'Multiple Mode',
                  CDatePicker(
                    mode: CustomDatePickerMode.multiple,
                    onChanged: (dates) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Selected ${dates.length} date(s): ${dates.map((d) => '${d.day}/${d.month}/${d.year}').join(', ')}'),
                        ),
                      );
                    },
                  ),
                ),
                (
                  'With Date Range',
                  CDatePicker(
                    mode: CustomDatePickerMode.single,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                    onChanged: (dates) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Selected: ${dates.map((d) => '${d.day}/${d.month}/${d.year}').join(', ')}'),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
