import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/pages/demo_pages.dart';
import 'package:caravaggio_ui_app/widgets/demo_scaffold_title.dart';
import 'package:caravaggio_ui_app/widgets/scaffold.dart';
import 'package:caravaggio_ui_app/widgets/section.dart';
import 'package:flutter/material.dart';

class LoadersPage extends StatelessWidget {
  const LoadersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      demoPageId: DemoPageId.loaders,
      title: demoScaffoldTitleFor(DemoPageId.loaders),
      bodyBuilder: (context, topPadding) {
        return Sections(
          padding: EdgeInsets.only(top: topPadding + 12, left: 16, right: 16, bottom: 12),
          sections: [
            Section(
              title: 'Factory',
              icon: Icons.build_circle_outlined,
              items: [
                (
                  'Bouncing',
                  CLoader.bouncing(),
                ),
                (
                  'Orbit',
                  CLoader.orbit(),
                ),
                (
                  'Pulsing',
                  CLoader.pulsing(),
                ),
              ],
            ),
            Section(
              title: 'Customizzazioni',
              icon: Icons.tune,
              items: [
                (
                  'Bouncing - Primary (3 pallini)',
                  CLoader.bouncing(
                    color: CColors.primaryColor,
                    numberOfDots: 3,
                  ),
                ),
                (
                  'Bouncing - Secondary (5 pallini)',
                  CLoader.bouncing(
                    color: CColors.secondaryColor,
                    numberOfDots: 5,
                  ),
                ),
                (
                  'Orbit - Primary Light (4 pallini)',
                  CLoader.orbit(
                    color: CColors.primaryColorLight,
                    numberOfDots: 4,
                  ),
                ),
                (
                  'Orbit - Secondary Dark (6 pallini)',
                  CLoader.orbit(
                    color: CColors.secondaryColorDark,
                    numberOfDots: 6,
                  ),
                ),
                (
                  'Pulsing - Primary Dark (2 pallini)',
                  CLoader.pulsing(
                    color: CColors.primaryColorDark,
                    numberOfDots: 2,
                  ),
                ),
                (
                  'Pulsing - On Secondary (4 pallini)',
                  CLoader.pulsing(
                    color: CColors.secondary,
                    numberOfDots: 5,
                  ),
                ),
              ],
            ),
            Section(
              title: 'Circular Progress Indicators',
              icon: Icons.donut_large_outlined,
              items: [
                (
                  'Circular Progress (Primary)',
                  CCircularProgressIndicator.primary(),
                ),
                (
                  'Circular Progress (Secondary)',
                  CCircularProgressIndicator.secondary(),
                ),
              ],
            ),
            Section(
              title: 'Linear Progress Indicators',
              icon: Icons.linear_scale,
              items: [
                (
                  'Linear Progress (Primary)',
                  CLinearProgressIndicator.primary(),
                ),
                (
                  'Linear Progress (Secondary)',
                  CLinearProgressIndicator.secondary(),
                ),
              ],
            )
          ],
        );
      },
    );
  }
}
