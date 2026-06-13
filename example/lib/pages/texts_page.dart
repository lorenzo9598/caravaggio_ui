import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/pages/demo_pages.dart';
import 'package:caravaggio_ui_app/widgets/demo_scaffold_title.dart';
import 'package:caravaggio_ui_app/widgets/scaffold.dart';
import 'package:caravaggio_ui_app/widgets/section.dart';
import 'package:flutter/material.dart';

class TextsPage extends StatelessWidget {
  const TextsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      demoPageId: DemoPageId.texts,
      title: demoScaffoldTitleFor(DemoPageId.texts),
      bodyBuilder: (context, topPadding) => Sections(
        padding: EdgeInsets.only(top: topPadding + 12, left: 16, right: 16, bottom: 12),
        sections: [
          Section(
            title: 'Types & Sizes',
            icon: Icons.text_fields,
            items: [
              ('Label Small', CText.label("Label", size: TextSize.small)),
              ('Label Medium', CText.label("Label", size: TextSize.medium)),
              ('Label Large', CText.label("Label", size: TextSize.large)),
              ('Body Small', CText.body("Body", size: TextSize.small)),
              ('Body Medium', CText.body("Body", size: TextSize.medium)),
              ('Body Large', CText.body("Body", size: TextSize.large)),
              ('Title Small', CText.title("Title", size: TextSize.small)),
              ('Title Medium', CText.title("Title", size: TextSize.medium)),
              ('Title Large', CText.title("Title", size: TextSize.large)),
              ('Headline Small', CText.headline("Headline", size: TextSize.small)),
              ('Headline Medium', CText.headline("Headline", size: TextSize.medium)),
              ('Headline Large', CText.headline("Headline", size: TextSize.large)),
              ('Display Small', CText.display("Display", size: TextSize.small)),
              ('Display Medium', CText.display("Display", size: TextSize.medium)),
              ('Display Large', CText.display("Display", size: TextSize.large)),
            ],
          ),
          Section(
            title: 'Modifiers',
            icon: Icons.tune,
            items: [
              ('Primary Color', CText.body("Primary", size: TextSize.medium).primary),
              ('Secondary Color', CText.body("Secondary", size: TextSize.medium).secondary),
              ('Bold', CText.body("Bold", size: TextSize.medium).bold),
              ('Italic', CText.body("Italic", size: TextSize.medium).italic),
              ('Underline', CText.body("Underline", size: TextSize.medium).underline),
              ('Custom Color', CText.body("withColor", size: TextSize.medium).withColor(Colors.blue)),
              ('Custom Size', CText.body("withSize", size: TextSize.medium).withSize(11)),
              ('Custom Weight', CText.body("withWeight", size: TextSize.medium).withWeight(FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
