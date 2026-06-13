import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/pages/demo_pages.dart';
import 'package:caravaggio_ui_app/widgets/demo_scaffold_title.dart';
import 'package:caravaggio_ui_app/widgets/scaffold.dart';
import 'package:caravaggio_ui_app/widgets/section.dart';
import 'package:flutter/material.dart';

import 'page_constants.dart';

class ButtonsPage extends StatefulWidget {
  const ButtonsPage({super.key});

  @override
  State<ButtonsPage> createState() => _ButtonsPageState();
}

class _ButtonsPageState extends State<ButtonsPage> {
  void _onPressed() {
    CToast.of(context).showMessage(
      title: 'Button pressed',
      variant: CToastVariant.info,
    );
  }

  @override
  Widget build(BuildContext context) {
    final CButton elevated = CButton.elevated(
      onPressed: _onPressed,
      child: buttonText,
    );

    return CustomScaffold(
      demoPageId: DemoPageId.buttons,
      title: demoScaffoldTitleFor(DemoPageId.buttons),
      bodyBuilder: (context, topPadding) {
        return Sections(
          padding: EdgeInsets.only(top: topPadding + 12, left: 16, right: 16, bottom: 12),
          sections: [
            Section(
              title: 'Types',
              icon: Icons.category_outlined,
              items: [
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
                  'Gradient with custom text color',
                  CButton.elevated(
                    gradient: CGradient.primaryLightToSecondaryLight,
                    foregroundColor: CColors.primaryColorDark,
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
            Section(
              title: 'Icon button',
              icon: Icons.crop_square_outlined,
              items: [
                (
                  'CIconBadge vs CButton.icon',
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CIconBadge(icon: Icons.star_outline),
                      const SizedBox(width: 12),
                      CButton.icon(
                        icon: Icons.star_outline,
                        onPressed: _onPressed,
                        tooltip: 'Icon button',
                      ),
                    ],
                  ),
                ),
                (
                  'Disabled',
                  CButton.icon(
                    icon: Icons.star_outline,
                    onPressed: null,
                    semanticsLabel: 'Disabled icon button',
                  ),
                ),
              ],
            ),
            Section(
              title: 'Sizes',
              icon: Icons.straighten,
              items: [
                ('Extra Small', elevated.xSmall),
                ('Small', elevated.small),
                ('Medium', elevated.medium),
                ('Large', elevated.large),
                ('Extra Large', elevated.xLarge),
                ('Extra Extra Large', elevated.xxLarge),
              ],
            ),
            Section(
              title: 'Elevation',
              icon: Icons.layers_outlined,
              items: [
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
            Section(
              title: 'Hint',
              icon: Icons.lightbulb_outline,
              items: [
                (
                  'Elevated with hint (M)',
                  CButton.elevated(
                    onPressed: _onPressed,
                    hint: 'Continue',
                    child: CText.label('Free trial · no card required'),
                  ),
                ),
                (
                  'Hint size L',
                  CButton.elevated(
                    onPressed: _onPressed,
                    hint: 'Continue',
                    hintSize: CButtonHintSize.large,
                    child: CText.label('Same scale as the label'),
                  ),
                ),
                (
                  'Hint size S',
                  CButton.elevated(
                    onPressed: _onPressed,
                    hint: 'Continue',
                    hintSize: CButtonHintSize.small,
                    child: CText.label('Compact secondary line'),
                  ),
                ),
                (
                  'Gradient + icon + hint',
                  CButton.elevated(
                    gradient: demoGradient,
                    foregroundColor: Colors.white,
                    icon: demoIcon,
                    onPressed: _onPressed,
                    hint: 'Get started',
                    child: CText.label('Takes less than a minute'),
                  ),
                ),
              ],
            ),
            Section(
              title: 'Icons & Icon Padding',
              icon: Icons.add_circle_outline,
              items: [
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
                  'Icon alignment: spaceBetween',
                  CButton.elevated(
                    icon: demoIcon,
                    suffixIcon: suffixIcon,
                    iconAlignment: CButtonIconAlignment.spaceBetween,
                    onPressed: _onPressed,
                    child: buttonText,
                  ).large,
                ),
                (
                  'Icon alignment: spaceAround',
                  CButton.elevated(
                    icon: demoIcon,
                    suffixIcon: suffixIcon,
                    iconAlignment: CButtonIconAlignment.spaceAround,
                    onPressed: _onPressed,
                    child: buttonText,
                  ).large,
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
        );
      },
    );
  }
}
