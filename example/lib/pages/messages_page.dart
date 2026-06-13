import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/pages/demo_pages.dart';
import 'package:caravaggio_ui_app/widgets/demo_scaffold_title.dart';
import 'package:caravaggio_ui_app/widgets/scaffold.dart';
import 'package:caravaggio_ui_app/widgets/section.dart';
import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  void _showDemoMessage(
    BuildContext context,
    CToastVariant variant, {
    CToastPosition position = CToastPosition.top,
    Duration duration = const Duration(seconds: 4),
  }) {
    final (title, subtitle) = switch (variant) {
      CToastVariant.error => (
          'Something went wrong',
          'Check your connection and try again.',
        ),
      CToastVariant.success => (
          'Changes saved',
          'Your profile was updated successfully.',
        ),
      CToastVariant.warning => (
          'Session expiring soon',
          'You will be signed out in 5 minutes.',
        ),
      CToastVariant.info => (
          'New version available',
          'Update the app to get the latest features.',
        ),
    };

    CToast.of(context).showMessage(
      variant: variant,
      title: title,
      subtitle: subtitle,
      position: position,
      duration: duration,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      demoPageId: DemoPageId.message,
      title: demoScaffoldTitleFor(DemoPageId.message),
      bodyBuilder: (context, topPadding) {
        return Sections(
          padding: EdgeInsets.only(top: topPadding + 12, left: 16, right: 16, bottom: 12),
          sections: [
            Section(
              title: 'Variants',
              icon: Icons.notifications_outlined,
              items: [
                (
                  'Error',
                  CButton.elevated(
                    onPressed: () => _showDemoMessage(context, CToastVariant.error),
                    child: CText.label('Show error'),
                  ),
                ),
                (
                  'Success',
                  CButton.outlined(
                    onPressed: () => _showDemoMessage(context, CToastVariant.success),
                    child: CText.label('Show success'),
                  ),
                ),
                (
                  'Warning',
                  CButton.outlined(
                    onPressed: () => _showDemoMessage(context, CToastVariant.warning),
                    child: CText.label('Show warning'),
                  ),
                ),
                (
                  'Info',
                  CButton.text(
                    onPressed: () => _showDemoMessage(context, CToastVariant.info),
                    child: CText.label('Show info'),
                  ),
                ),
              ],
            ),
            Section(
              title: 'Position',
              icon: Icons.swap_vert,
              items: [
                (
                  'Top (default)',
                  CButton.elevated(
                    onPressed: () => _showDemoMessage(
                      context,
                      CToastVariant.info,
                      position: CToastPosition.top,
                    ),
                    child: CText.label('Show at top'),
                  ),
                ),
                (
                  'Bottom',
                  CButton.outlined(
                    onPressed: () => _showDemoMessage(
                      context,
                      CToastVariant.success,
                      position: CToastPosition.bottom,
                    ),
                    child: CText.label('Show at bottom'),
                  ),
                ),
              ],
            ),
            Section(
              title: 'Duration',
              icon: Icons.timer_outlined,
              items: [
                (
                  '2 seconds',
                  CButton.elevated(
                    onPressed: () => _showDemoMessage(
                      context,
                      CToastVariant.info,
                      duration: const Duration(seconds: 2),
                    ),
                    child: CText.label('Short'),
                  ),
                ),
                (
                  'Persistent',
                  CButton.outlined(
                    onPressed: () => _showDemoMessage(
                      context,
                      CToastVariant.warning,
                      duration: Duration.zero,
                    ),
                    child: CText.label('Until dismissed'),
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
