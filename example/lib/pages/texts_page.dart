import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';

class TextsPage extends StatelessWidget {
  const TextsPage({super.key});

  static const double _cardPadding = 16.0;
  static const double _sectionSpacing = 24.0;
  static const double _itemSpacing = 12.0;

  Widget _buildTextCard(
    BuildContext context, {
    required String label,
    required Widget text,
  }) {
    return Container(
      padding: const EdgeInsets.all(_cardPadding),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.all(AppRadius.m),
        boxShadow: AppShadow.sm,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: CText.label(
              label,
              size: TextSize.small,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
              ),
            ),
          ),
          Expanded(child: text),
        ],
      ),
    );
  }

  Widget _buildTextSection(
    BuildContext context,
    String title,
    List<(String label, Widget text)> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: CText.headline(title, size: TextSize.medium),
        ),
        ...items.map((item) => Padding(
              padding: EdgeInsets.only(
                bottom: items.indexOf(item) < items.length - 1 ? _itemSpacing : 0,
              ),
              child: _buildTextCard(context, label: item.$1, text: item.$2),
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Texts')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextSection(
              context,
              'Text Types & Sizes',
              [
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
            const SizedBox(height: _sectionSpacing),
            _buildTextSection(
              context,
              'Text Modifiers',
              [
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
      ),
    );
  }
}
