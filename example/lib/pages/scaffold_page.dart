import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/pages/demo_pages.dart';
import 'package:caravaggio_ui_app/pages/scaffold_preview_page.dart';
import 'package:caravaggio_ui_app/widgets/demo_scaffold_title.dart';
import 'package:caravaggio_ui_app/widgets/scaffold.dart';
import 'package:caravaggio_ui_app/widgets/section.dart';
import 'package:flutter/material.dart';

class ScaffoldPage extends StatefulWidget {
  const ScaffoldPage({super.key});

  @override
  State<ScaffoldPage> createState() => _ScaffoldPageState();
}

class _ScaffoldPageState extends State<ScaffoldPage> {
  bool _hideTitleOnScroll = true;
  Alignment _titleAlignment = Alignment.center;

  void _openPreview() {
    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (_) => const ScaffoldBackButtonPreviewPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      demoPageId: DemoPageId.scaffold,
      title: demoScaffoldTitleFor(DemoPageId.scaffold),
      hideTitleOnScroll: _hideTitleOnScroll,
      titleAlignment: _titleAlignment,
      bodyBuilder: (context, topPadding) {
        return Sections(
          padding: EdgeInsets.only(top: topPadding + 12, left: 16, right: 16, bottom: 12),
          sections: [
            Section(
              title: 'CScaffold vs CustomScaffold',
              icon: Icons.compare_arrows,
              items: [
                (
                  'Library vs example app',
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CText.body(
                        'CScaffold is the design-system scaffold: gradient background, '
                        'scroll-linked app bar overlay, optional scroll-aware title, and '
                        'configurable back button (alpha, scrolled color, border, icon). '
                        'Use scrollOverlayColor to tint the top fade while scrolling.',
                        size: TextSize.small,
                      ),
                      const SizedBox(height: 8),
                      CText.body(
                        'CustomScaffold (this example app) wraps CScaffold and adds animated '
                        'pattern assets in backgroundLayers. Other demo pages use CustomScaffold; '
                        'use CScaffold directly when you bring your own background layers.',
                        size: TextSize.small,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Section(
              title: 'Preview',
              icon: Icons.preview_outlined,
              items: [
                (
                  'Back button live preview',
                  CButton.elevated(
                    onPressed: _openPreview,
                    child: CText.label('Open preview'),
                  ),
                ),
              ],
            ),
            Section(
              title: 'Scroll & back pill',
              icon: Icons.tune,
              items: [
                (
                  'Customization',
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CText.body(
                        'scrollOverlayColor tints the top gradient overlay (default: '
                        'CColors.secondaryColorLight). Back pill at rest uses white with '
                        'backButtonTopBackgroundAlpha; after scroll it lerps to '
                        'backButtonScrolledBackgroundColor with backButtonScrolledBackgroundAlpha.',
                        size: TextSize.small,
                      ),
                      const SizedBox(height: 8),
                      CButton.elevated(
                        onPressed: _openPreview,
                        child: CText.label('Tune live in preview'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Section(
              title: 'bodyBuilder & topPadding',
              icon: Icons.padding,
              items: [
                (
                  'Scroll padding',
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CText.body(
                        'Pass bodyBuilder to apply topPadding on your scrollable '
                        '(ListView, CustomScrollView, Sections, …). '
                        'Or read CScaffold.topPaddingOf(context) inside the body tree.',
                        size: TextSize.small,
                      ),
                      const SizedBox(height: 8),
                      CText.body(
                        'Current topPadding: ${topPadding.toStringAsFixed(0)}',
                        size: TextSize.small,
                      ).primary,
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
}

class _AlignmentChip extends StatelessWidget {
  const _AlignmentChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: CText.label(label, size: TextSize.small),
      selected: selected,
      onSelected: (_) => onTap(),
    );
  }
}
