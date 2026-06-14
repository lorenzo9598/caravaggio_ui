import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/pages/demo_pages.dart';
import 'package:caravaggio_ui_app/widgets/demo_scaffold_title.dart';
import 'package:caravaggio_ui_app/widgets/scaffold.dart';
import 'package:caravaggio_ui_app/widgets/section.dart';
import 'package:flutter/material.dart';

class TilesPage extends StatelessWidget {
  const TilesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      demoPageId: DemoPageId.tiles,
      title: demoScaffoldTitleFor(DemoPageId.tiles),
      bodyBuilder: (context, topPadding) {
        return Sections(
          padding: EdgeInsets.only(top: topPadding + 12, left: 16, right: 16, bottom: 12),
          sections: [
            Section(
              title: 'Simple',
              icon: Icons.view_list_outlined,
              items: [
                (
                  'CTile.simple · onTap',
                  CTile.simple(
                    icon: Icons.restaurant_outlined,
                    title: 'Pasta al pomodoro',
                    description: 'Ricetta veloce con basilico e pomodorini freschi.',
                    tags: const ['Food', 'Popular'],
                    onTap: () {
                      CToast.of(context).showMessage(
                        title: 'Pasta al pomodoro',
                        subtitle: 'Tile tapped',
                        variant: CToastVariant.info,
                      );
                    },
                  ),
                ),
                (
                  'CTile.simple · static',
                  CTile.simple(
                    icon: Icons.info_outline,
                    title: 'Informazioni evento',
                    description: 'Nessun onTap: niente freccia a destra.',
                  ),
                ),
              ],
            ),
            Section(
              title: 'With date/time',
              icon: Icons.schedule_outlined,
              items: [
                (
                  'CTile.withDateTime',
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CTile.withDateTime(
                        icon: Icons.event_outlined,
                        title: 'Weekend brunch',
                        description: 'Ristorante Da Marco · 4 persone',
                        tags: const ['Booking'],
                        dateTime: DateTime(2026, 6, 13, 14, 30),
                        onTap: () {},
                      ),
                      const SizedBox(height: 12),
                      CTile.withDateTime(
                        icon: Icons.music_note_outlined,
                        title: 'Jazz night',
                        description: 'Auditorium centrale',
                        tags: const ['Live', 'Sold out'],
                        dateTime: DateTime(2026, 6, 20, 21, 0),
                        footer: 'Tap per i dettagli',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Section(
              title: 'Icon shortcut',
              icon: Icons.apps_outlined,
              items: [
                (
                  'CTile.icon',
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CTile.icon(
                        icon: Icons.settings_outlined,
                        title: 'Impostazioni account',
                        description: 'Email, password e preferenze',
                      ),
                      const SizedBox(height: 12),
                      CTile.icon(
                        icon: Icons.logout,
                        title: 'Esci',
                        description: 'Disconnetti da questo dispositivo',
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Section(
              title: 'Full widgets',
              icon: Icons.widgets_outlined,
              items: [
                (
                  'CTile · custom slots',
                  CTile(
                    leading: const CIconBadge(icon: Icons.star_outline),
                    header: CText.label(
                      'HEADER CUSTOM',
                      size: TextSize.small,
                      style: TextStyle(color: CColors.secondaryColor),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CText.title('Widget libero nel content', size: TextSize.medium),
                        const SizedBox(height: 4),
                        const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.star, size: 16, color: Color(0xFFF5A623)),
                            Icon(Icons.star, size: 16, color: Color(0xFFF5A623)),
                            Icon(Icons.star, size: 16, color: Color(0xFFF5A623)),
                            Icon(Icons.star_border, size: 16, color: Color(0xFFF5A623)),
                          ],
                        ),
                      ],
                    ),
                    footer: CText.body('Footer widget · azione secondaria', size: TextSize.small),
                    trailing: CText.label(
                      'Open',
                      style: TextStyle(color: CColors.primaryColor),
                    ),
                    onTap: () {},
                  ),
                ),
              ],
            ),
            Section(
              title: 'List context',
              icon: Icons.layers_outlined,
              items: [
                (
                  'Modal-style column',
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: const BorderRadius.all(AppRadius.m),
                      border: Border.all(
                        color: Theme.of(context).dividerColor.withValues(alpha: 0.6),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CText.title('Mountain retreat', size: TextSize.small),
                        const SizedBox(height: 4),
                        CText.body('Scegli un\'opzione', size: TextSize.small),
                        const SizedBox(height: 12),
                        CTile.icon(
                          icon: Icons.landscape_outlined,
                          title: 'Prenota ora',
                          description: 'Risparmia il 20%',
                          onTap: () {},
                        ),
                        const SizedBox(height: 12),
                        CTile.icon(
                          icon: Icons.map_outlined,
                          title: 'Indicazioni',
                          description: 'Apri in mappe',
                          onTap: () {},
                        ),
                        const SizedBox(height: 12),
                        CTile.icon(
                          icon: Icons.chat_bubble_outline,
                          title: 'Contatta host',
                          description: 'Risposta entro 1 ora',
                          onTap: () {},
                        ),
                      ],
                    ),
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
