import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/pages/demo_pages.dart';
import 'package:caravaggio_ui_app/widgets/demo_scaffold_title.dart';
import 'package:caravaggio_ui_app/widgets/scaffold.dart';
import 'package:caravaggio_ui_app/widgets/section.dart';
import 'package:flutter/material.dart';

class ModalBottomSheetPage extends StatelessWidget {
  const ModalBottomSheetPage({super.key});

  List<CPopupAction> _demoActions(BuildContext context) => [
        CPopupAction(
          label: 'Cancel',
          style: CPopupActionStyle.outlined,
          onPressed: () {},
        ),
        CPopupAction(
          label: 'Apply',
          onPressed: () {
            CToast.of(context).showMessage(
              title: 'Filters applied',
              variant: CToastVariant.success,
            );
          },
        ),
      ];

  void _showDemoSheet(BuildContext context) {
    showCModalBottomSheet(
      context: context,
      icon: Icons.tune_outlined,
      title: 'Filter results',
      subtitle: 'Adjust what appears in the list.',
      body: CText.body(
        'Choose one or more categories, then apply to update the view.',
        size: TextSize.small,
      ),
      actions: _demoActions(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      demoPageId: DemoPageId.modalBottomSheet,
      title: demoScaffoldTitleFor(DemoPageId.modalBottomSheet),
      bodyBuilder: (context, topPadding) {
        return Sections(
          padding: EdgeInsets.only(top: topPadding + 12, left: 16, right: 16, bottom: 12),
          sections: [
            Section(
              title: 'Bottom sheet',
              icon: Icons.vertical_align_top_outlined,
              items: [
                (
                  'showCModalBottomSheet',
                  CButton.elevated(
                    onPressed: () => _showDemoSheet(context),
                    child: CText.label('Open bottom sheet'),
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
