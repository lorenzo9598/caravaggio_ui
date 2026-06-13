import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/pages/demo_pages.dart';
import 'package:caravaggio_ui_app/widgets/demo_scaffold_title.dart';
import 'package:caravaggio_ui_app/widgets/scaffold.dart';
import 'package:caravaggio_ui_app/widgets/section.dart';
import 'package:flutter/material.dart';

import 'page_constants.dart';

class WrapperPage extends StatefulWidget {
  const WrapperPage({super.key});

  @override
  State<WrapperPage> createState() => _WrapperPageState();
}

class _WrapperPageState extends State<WrapperPage> {
  bool _defaultLoading = false;
  bool _customLoading = false;

  void _onPressed() {
    CToast.of(context).showMessage(
      title: 'Button pressed',
      variant: CToastVariant.info,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      demoPageId: DemoPageId.wrapper,
      title: demoScaffoldTitleFor(DemoPageId.wrapper),
      bodyBuilder: (context, topPadding) {
        return Sections(
          padding: EdgeInsets.only(top: topPadding + 12, left: 16, right: 16, bottom: 12),
          sections: [
            Section(
              title: 'Default loader',
              icon: Icons.hourglass_empty_outlined,
              items: [
                (
                  'Toggle loading',
                  Column(
                    children: [
                      CButton.elevated(
                        onPressed: () => setState(() => _defaultLoading = !_defaultLoading),
                        child: CText.label(_defaultLoading ? 'Stop loading' : 'Start loading'),
                      ),
                      const SizedBox(height: 16),
                      CWrapper(
                        loading: _defaultLoading,
                        message: _defaultLoading ? 'Please wait…' : null,
                        child: _demoContent(onPressed: _onPressed),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Section(
              title: 'Custom loader',
              icon: Icons.settings_suggest_outlined,
              items: [
                (
                  'Orbit loader + message',
                  Column(
                    children: [
                      CButton.outlined(
                        onPressed: () => setState(() => _customLoading = !_customLoading),
                        child: CText.label(_customLoading ? 'Stop loading' : 'Start loading'),
                      ),
                      const SizedBox(height: 16),
                      CWrapper(
                        loading: _customLoading,
                        loader: CLoader.orbit(
                          color: CColors.secondaryColor,
                          numberOfDots: 5,
                        ),
                        message: _customLoading ? 'Loading data…' : null,
                        child: _demoContent(onPressed: _onPressed),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _demoContent({required VoidCallback onPressed}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(AppRadius.m),
        boxShadow: AppShadow.sm,
      ),
      child: Column(
        children: [
          CText.body(
            'Content under the overlay. Buttons are blocked while loading.',
            size: TextSize.small,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          CButton.elevated(
            onPressed: onPressed,
            child: buttonText,
          ),
        ],
      ),
    );
  }
}
