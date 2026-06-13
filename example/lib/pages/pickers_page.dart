import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/pages/demo_pages.dart';
import 'package:caravaggio_ui_app/widgets/demo_scaffold_title.dart';
import 'package:caravaggio_ui_app/widgets/scaffold.dart';
import 'package:caravaggio_ui_app/widgets/section.dart';
import 'package:flutter/material.dart';

class PickersPage extends StatefulWidget {
  const PickersPage({super.key});

  @override
  State<PickersPage> createState() => _PickersPageState();
}

class _PickersPageState extends State<PickersPage> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      demoPageId: DemoPageId.pickers,
      title: demoScaffoldTitleFor(DemoPageId.pickers),
      bodyBuilder: (context, topPadding) {
        return Sections(
          padding: EdgeInsets.only(top: topPadding + 12, left: 16, right: 16, bottom: 12),
          sections: [
            Section(
              title: 'Time Picker',
              icon: Icons.access_time,
              items: [
                (
                  'Single Mode',
                  CTimePicker(
                    mode: CustomTimePickerMode.single,
                    maxLines: 3,
                    onChanged: (times) {
                      CToast.of(context).showMessage(
                        title: 'Time selected',
                        subtitle: times.map((t) => '${t.hour}:${t.minute.toString().padLeft(2, '0')}').join(', '),
                        variant: CToastVariant.info,
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
                      CToast.of(context).showMessage(
                        title: 'Time selected',
                        subtitle: times.map((t) => '${t.hour}:${t.minute.toString().padLeft(2, '0')}').join(', '),
                        variant: CToastVariant.info,
                      );
                    },
                  ),
                ),
              ],
            ),
            Section(
              title: 'Date Picker',
              icon: Icons.calendar_today_outlined,
              items: [
                (
                  'Single Mode',
                  CDatePicker(
                    mode: CustomDatePickerMode.single,
                    onChanged: (dates) {
                      CToast.of(context).showMessage(
                        title: 'Date selected',
                        subtitle: dates.map((d) => '${d.day}/${d.month}/${d.year}').join(', '),
                        variant: CToastVariant.info,
                      );
                    },
                  ),
                ),
                (
                  'Multiple Mode',
                  CDatePicker(
                    mode: CustomDatePickerMode.multiple,
                    onChanged: (dates) {
                      CToast.of(context).showMessage(
                        title: '${dates.length} date(s) selected',
                        subtitle: dates.map((d) => '${d.day}/${d.month}/${d.year}').join(', '),
                        variant: CToastVariant.info,
                      );
                    },
                  ),
                ),
                (
                  'Selectable window (first / last)',
                  CDatePicker(
                    mode: CustomDatePickerMode.single,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 30)),
                    onChanged: (dates) {
                      CToast.of(context).showMessage(
                        title: 'Date selected',
                        subtitle: dates.map((d) => '${d.day}/${d.month}/${d.year}').join(', '),
                        variant: CToastVariant.info,
                      );
                    },
                  ),
                ),
                (
                  'Range mode',
                  CDatePicker(
                    mode: CustomDatePickerMode.range,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 60)),
                    onChanged: (dates) {
                      if (dates.isEmpty) return;
                      final start = dates.first;
                      final end = dates.last;
                      if (dates.length == 1) {
                        CToast.of(context).showMessage(
                          title: 'Select end date',
                          subtitle: 'From ${start.day}/${start.month}/${start.year}',
                          variant: CToastVariant.info,
                        );
                      } else {
                        CToast.of(context).showMessage(
                          title: 'Date range selected',
                          subtitle:
                              '${start.day}/${start.month}/${start.year} – ${end.day}/${end.month}/${end.year} (${dates.length} days)',
                          variant: CToastVariant.info,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
