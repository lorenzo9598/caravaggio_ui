import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';

import 'page_constants.dart';

class ButtonsPage extends StatefulWidget {
  const ButtonsPage({super.key});

  @override
  State<ButtonsPage> createState() => _ButtonsPageState();
}

class _ButtonsPageState extends State<ButtonsPage> {
  void _onPressed() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Button pressed')));
  }

  static const double _cardPadding = 16.0;
  static const double _sectionSpacing = 8.0;
  static const double _itemSpacing = 16.0;

  Widget _buildButtonCard({
    required String label,
    required Widget button,
  }) {
    return Container(
      padding: const EdgeInsets.all(_cardPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(AppRadius.m),
        boxShadow: AppShadow.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CText.label(
            label,
            size: TextSize.small,
            style: TextStyle(
              color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 12),
          Center(child: button),
        ],
      ),
    );
  }

  Widget _buildButtonSection(
    BuildContext context,
    String title,
    List<(String label, Widget button)> items,
  ) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: _sectionSpacing),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.all(AppRadius.l),
        boxShadow: AppShadow.sm,
      ),
      child: Theme(
        data: theme.copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
          childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(AppRadius.l),
          ),
          collapsedShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(AppRadius.l),
          ),
          iconColor: CColors.primaryColor,
          collapsedIconColor: theme.iconTheme.color,
          title: CText.headline(
            title,
            size: TextSize.small,
          ),
          children: [
            ...items.map(
              (item) => Padding(
                padding: EdgeInsets.only(
                  bottom: items.indexOf(item) < items.length - 1 ? _itemSpacing : 0,
                ),
                child: _buildButtonCard(label: item.$1, button: item.$2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final CButton elevated = CButton.elevated(
      onPressed: _onPressed,
      child: buttonText,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Buttons')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildButtonSection(
              context,
              'Button Types',
              [
                (
                  'Elevated Button',
                  CButton.elevated(
                    onPressed: _onPressed,
                    child: buttonText,
                  ),
                ),
                (
                  'Elevated with Gradient',
                  CButton.elevated(
                    gradient: demoGradient,
                    onPressed: _onPressed,
                    child: buttonText,
                  ),
                ),
                (
                  'Outlined Button',
                  CButton.outlined(
                    onPressed: _onPressed,
                    child: buttonText,
                  ),
                ),
                (
                  'Text Button',
                  CButton.text(
                    onPressed: _onPressed,
                    child: buttonText,
                  ),
                ),
              ],
            ),
            const SizedBox(height: _sectionSpacing),
            _buildButtonSection(
              context,
              'Button Sizes',
              [
                ('Extra Small', elevated.xSmall),
                ('Small', elevated.small),
                ('Medium', elevated.medium),
                ('Large', elevated.large),
                ('Extra Large', elevated.xLarge),
                ('Extra Extra Large', elevated.xxLarge),
              ],
            ),
            const SizedBox(height: _sectionSpacing),
            _buildButtonSection(
              context,
              'Button Elevation',
              [
                (
                  'No Elevation (0.0)',
                  CButton.elevated(
                    elevation: 0.0,
                    onPressed: _onPressed,
                    child: buttonText,
                  ),
                ),
                (
                  'Low Elevation (1.0 - default)',
                  CButton.elevated(
                    elevation: 1.0,
                    onPressed: _onPressed,
                    child: buttonText,
                  ),
                ),
                (
                  'Medium Elevation (2.0)',
                  CButton.elevated(
                    elevation: 2.0,
                    onPressed: _onPressed,
                    child: buttonText,
                  ),
                ),
                (
                  'High Elevation (4.0)',
                  CButton.elevated(
                    elevation: 4.0,
                    onPressed: _onPressed,
                    child: buttonText,
                  ),
                ),
                (
                  'Very High Elevation (8.0)',
                  CButton.elevated(
                    elevation: 8.0,
                    onPressed: _onPressed,
                    child: buttonText,
                  ),
                ),
                (
                  'Elevation with Gradient',
                  CButton.elevated(
                    elevation: 4.0,
                    gradient: demoGradient,
                    onPressed: _onPressed,
                    child: buttonText,
                  ),
                ),
                (
                  'Elevation with Icons',
                  CButton.elevated(
                    elevation: 3.0,
                    icon: demoIcon,
                    suffixIcon: suffixIcon,
                    onPressed: _onPressed,
                    child: buttonText,
                  ),
                ),
              ],
            ),
            const SizedBox(height: _sectionSpacing),
            _buildButtonSection(
              context,
              'Icons & Icon Padding',
              [
                (
                  'With Leading Icon (default padding: 8.0)',
                  CButton.elevated(
                    icon: demoIcon,
                    onPressed: _onPressed,
                    child: buttonText,
                  ),
                ),
                (
                  'With Suffix Icon (default padding: 8.0)',
                  CButton.elevated(
                    suffixIcon: suffixIcon,
                    onPressed: _onPressed,
                    child: buttonText,
                  ),
                ),
                (
                  'With Both Icons (default padding: 8.0)',
                  CButton.elevated(
                    icon: demoIcon,
                    suffixIcon: suffixIcon,
                    onPressed: _onPressed,
                    child: buttonText,
                  ),
                ),
                (
                  'Small Icon Padding (4.0)',
                  CButton.elevated(
                    icon: demoIcon,
                    suffixIcon: suffixIcon,
                    iconPadding: 4.0,
                    suffixIconPadding: 4.0,
                    onPressed: _onPressed,
                    child: buttonText,
                  ),
                ),
                (
                  'Medium Icon Padding (12.0)',
                  CButton.elevated(
                    icon: demoIcon,
                    suffixIcon: suffixIcon,
                    iconPadding: 12.0,
                    suffixIconPadding: 12.0,
                    onPressed: _onPressed,
                    child: buttonText,
                  ),
                ),
                (
                  'Large Icon Padding (20.0)',
                  CButton.elevated(
                    icon: demoIcon,
                    suffixIcon: suffixIcon,
                    iconPadding: 20.0,
                    suffixIconPadding: 20.0,
                    onPressed: _onPressed,
                    child: buttonText,
                  ),
                ),
                (
                  'Different Padding (icon: 4.0, suffix: 16.0)',
                  CButton.elevated(
                    icon: demoIcon,
                    suffixIcon: suffixIcon,
                    iconPadding: 4.0,
                    suffixIconPadding: 16.0,
                    onPressed: _onPressed,
                    child: buttonText,
                  ),
                ),
                (
                  'Outlined with Icons',
                  CButton.outlined(
                    icon: demoIcon,
                    suffixIcon: suffixIcon,
                    iconPadding: 8.0,
                    suffixIconPadding: 8.0,
                    onPressed: _onPressed,
                    child: buttonText,
                  ),
                ),
                (
                  'Text Button with Icons',
                  CButton.text(
                    icon: demoIcon,
                    suffixIcon: suffixIcon,
                    iconPadding: 8.0,
                    suffixIconPadding: 8.0,
                    onPressed: _onPressed,
                    child: buttonText,
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
