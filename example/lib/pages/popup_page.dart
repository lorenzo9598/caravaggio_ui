import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/pages/demo_pages.dart';
import 'package:caravaggio_ui_app/widgets/demo_scaffold_title.dart';
import 'package:caravaggio_ui_app/widgets/scaffold.dart';
import 'package:caravaggio_ui_app/widgets/section.dart';
import 'package:flutter/material.dart';

class PopupPage extends StatelessWidget {
  const PopupPage({super.key});

  List<CPopupAction> _demoActions(BuildContext context) => [
        CPopupAction(
          label: 'Cancel',
          style: CPopupActionStyle.outlined,
          onPressed: () {},
        ),
        CPopupAction(
          label: 'Confirm',
          onPressed: () {
            CToast.of(context).showMessage(
              title: 'Confirmed',
              variant: CToastVariant.success,
            );
          },
        ),
      ];

  void _showDemoPopup(BuildContext context) {
    showCPopup(
      context: context,
      icon: Icons.info_outline,
      title: 'Confirm action',
      subtitle: 'This cannot be undone.',
      body: CText.body(
        'Review the details before continuing.',
        size: TextSize.small,
      ),
      actions: _demoActions(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      demoPageId: DemoPageId.popups,
      title: demoScaffoldTitleFor(DemoPageId.popups),
      bodyBuilder: (context, topPadding) {
        return Sections(
          padding: EdgeInsets.only(top: topPadding + 12, left: 16, right: 16, bottom: 12),
          sections: [
            Section(
              title: 'Dialog',
              icon: Icons.open_in_new_outlined,
              items: [
                (
                  'showCPopup',
                  CButton.elevated(
                    onPressed: () => _showDemoPopup(context),
                    child: CText.label('Open popup'),
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
