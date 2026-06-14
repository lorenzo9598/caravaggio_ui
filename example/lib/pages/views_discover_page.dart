import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/widgets/demo_scaffold_title.dart';
import 'package:caravaggio_ui_app/widgets/scaffold.dart';
import 'package:flutter/material.dart';

class _DiscoverExperience {
  const _DiscoverExperience({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.detail,
    required this.image,
    required this.tags,
    required this.rating,
    required this.actions,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final String description;
  final String detail;
  final ImageProvider image;
  final List<String> tags;
  final double rating;
  final List<_DiscoverAction> actions;
}

class _DiscoverAction {
  const _DiscoverAction({
    required this.icon,
    required this.title,
    required this.description,
    required this.toastTitle,
  });

  final IconData icon;
  final String title;
  final String description;
  final String toastTitle;
}

class ViewsDiscoverPage extends StatelessWidget {
  const ViewsDiscoverPage({super.key});

  static const double _cardWidth = 280;

  static const _experiences = [
    _DiscoverExperience(
      icon: Icons.landscape_outlined,
      title: 'Mountain retreat',
      subtitle: 'Weekend escape · Dolomiti',
      description: 'Chalet con vista panoramica e colazione inclusa.',
      detail:
          'Ritagliati un weekend lontano dalla città: sauna privata, sentieri segnalati '
          'e check-in flessibile dalle 14:00. Perfetto per coppie o piccoli gruppi.',
      image: NetworkImage(
        'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=600&h=340&fit=crop',
      ),
      tags: ['Nature', 'Popular'],
      rating: 4.8,
      actions: [
        _DiscoverAction(
          icon: Icons.calendar_month_outlined,
          title: 'Prenota ora',
          description: 'Blocca le date e risparmia il 20%',
          toastTitle: 'Booking started',
        ),
        _DiscoverAction(
          icon: Icons.map_outlined,
          title: 'Indicazioni',
          description: 'Apri il percorso in mappe',
          toastTitle: 'Opening maps',
        ),
        _DiscoverAction(
          icon: Icons.favorite_border,
          title: 'Salva nei preferiti',
          description: 'Trovalo più tardi nella tua lista',
          toastTitle: 'Saved to wishlist',
        ),
      ],
    ),
    _DiscoverExperience(
      icon: Icons.restaurant_outlined,
      title: 'Coastal cooking',
      subtitle: 'Chef experience · 3 ore',
      description: 'Lezione sul mare con degustazione finale.',
      detail:
          'Impara a preparare pasta fresca e crudi di pesce con uno chef stellato. '
          'Include grembiule, ricettario digitale e calice di vino locale.',
      image: NetworkImage(
        'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600&h=340&fit=crop',
      ),
      tags: ['Food', 'Limited'],
      rating: 4.6,
      actions: [
        _DiscoverAction(
          icon: Icons.event_available_outlined,
          title: 'Scegli data',
          description: 'Sabato e domenica disponibili',
          toastTitle: 'Pick a date',
        ),
        _DiscoverAction(
          icon: Icons.group_outlined,
          title: 'Invita amici',
          description: 'Condividi il link di prenotazione',
          toastTitle: 'Invite sent',
        ),
        _DiscoverAction(
          icon: Icons.chat_bubble_outline,
          title: 'Chiedi al chef',
          description: 'Risposta media entro 2 ore',
          toastTitle: 'Message sent',
        ),
      ],
    ),
    _DiscoverExperience(
      icon: Icons.music_note_outlined,
      title: 'Jazz night',
      subtitle: 'Live session · Centro storico',
      description: 'Quartetto internazionale e cocktail d\'autore.',
      detail:
          'Posti limitati in sala intima con acustica curata. Aperitivo incluso e '
          'possibilità di meet & greet con i musicisti dopo lo show.',
      image: NetworkImage(
        'https://images.unsplash.com/photo-1415201364774-f6f0bb35f28f?w=600&h=340&fit=crop',
      ),
      tags: ['Live', 'Tonight'],
      rating: 4.9,
      actions: [
        _DiscoverAction(
          icon: Icons.confirmation_number_outlined,
          title: 'Acquista biglietto',
          description: 'Da € 28 · posti in esaurimento',
          toastTitle: 'Ticket checkout',
        ),
        _DiscoverAction(
          icon: Icons.schedule_outlined,
          title: 'Orari e programma',
          description: 'Apertura porte ore 20:30',
          toastTitle: 'Schedule opened',
        ),
        _DiscoverAction(
          icon: Icons.share_outlined,
          title: 'Condividi evento',
          description: 'Invia ai tuoi contatti',
          toastTitle: 'Link copied',
        ),
      ],
    ),
    _DiscoverExperience(
      icon: Icons.wine_bar_outlined,
      title: 'Vineyard tour',
      subtitle: 'Tasting · Collina toscana',
      description: 'Passeggiata tra i filari e tre etichette in degustazione.',
      detail:
          'Visita guidata della cantina storica, spiegazione del processo di affinamento '
          'e assaggio di rossi e bianchi con tagliere di salumi locali.',
      image: NetworkImage(
        'https://images.unsplash.com/photo-1510812431400-5740424a8a83?w=600&h=340&fit=crop',
      ),
      tags: ['Wine', 'Weekend'],
      rating: 4.7,
      actions: [
        _DiscoverAction(
          icon: Icons.directions_car_outlined,
          title: 'Navetta inclusa',
          description: 'Partenza da Firenze SMN',
          toastTitle: 'Shuttle info',
        ),
        _DiscoverAction(
          icon: Icons.card_giftcard_outlined,
          title: 'Regala esperienza',
          description: 'Voucher digitale immediato',
          toastTitle: 'Gift voucher',
        ),
        _DiscoverAction(
          icon: Icons.info_outline,
          title: 'Dettagli tour',
          description: 'Durata 4 ore · min 2 persone',
          toastTitle: 'Tour details',
        ),
      ],
    ),
  ];

  Widget _ratingSubtitle(double rating) {
    final fullStars = rating.floor();
    final hasHalf = rating - fullStars >= 0.5;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 0; i < fullStars; i++)
          const Icon(Icons.star, size: 16, color: Color(0xFFF5A623)),
        if (hasHalf) const Icon(Icons.star_half, size: 16, color: Color(0xFFF5A623)),
        const SizedBox(width: 4),
        CText.body(rating.toStringAsFixed(1), size: TextSize.small),
      ],
    );
  }

  void _openDetailSheet(BuildContext context, _DiscoverExperience experience) {
    showCModalBottomSheet(
      context: context,
      icon: experience.icon,
      title: experience.title,
      subtitle: experience.subtitle,
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CText.body(experience.detail, size: TextSize.small),
          const SizedBox(height: 16),
          CText.label('Cosa vuoi fare?', size: TextSize.small),
          const SizedBox(height: 12),
          for (int i = 0; i < experience.actions.length; i++) ...[
            if (i > 0) const SizedBox(height: 10),
            CTile.icon(
              icon: experience.actions[i].icon,
              title: experience.actions[i].title,
              description: experience.actions[i].description,
              onTap: () {
                Navigator.of(context).pop();
                CToast.of(context).showMessage(
                  title: experience.actions[i].toastTitle,
                  subtitle: experience.title,
                  variant: CToastVariant.success,
                );
              },
            ),
          ],
        ],
      ),
      actions: [
        CPopupAction(
          label: 'Chiudi',
          style: CPopupActionStyle.outlined,
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: demoScaffoldTitle('Discover'),
      bodyBuilder: (context, topPadding) {
        return ListView(
          padding: EdgeInsets.fromLTRB(16, topPadding + 16, 16, 24),
          children: [
            CText.title('Esperienze in evidenza', size: TextSize.medium),
            const SizedBox(height: 6),
            CText.body(
              'Scorri le card e tocca per aprire il dettaglio con le azioni disponibili.',
              size: TextSize.small,
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: _cardWidth / (16 / 9) + 8,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _experiences.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final experience = _experiences[index];
                  return CCarousel.overlay(
                    width: _cardWidth,
                    image: Image(
                      image: experience.image,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    title: CText.title(
                      experience.title,
                      size: TextSize.medium,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: _ratingSubtitle(experience.rating),
                    description: CText.body(
                      experience.description,
                      size: TextSize.small,
                      style: const TextStyle(color: Colors.white),
                    ),
                    tags: experience.tags
                        .map((tag) => CTagChip(label: tag, variant: CTagChipVariant.overlay))
                        .toList(),
                    onTap: () => _openDetailSheet(context, experience),
                  );
                },
              ),
            ),
            const SizedBox(height: 28),
            CText.title('Altre proposte', size: TextSize.small),
            const SizedBox(height: 12),
            for (int i = 0; i < _experiences.length; i++) ...[
              if (i > 0) const SizedBox(height: 12),
              CTile.withDateTime(
                icon: _experiences[i].icon,
                title: _experiences[i].title,
                description: _experiences[i].description,
                tags: _experiences[i].tags,
                dateTime: DateTime(2026, 6, 13 + i, 18 + i, 30),
                onTap: () => _openDetailSheet(context, _experiences[i]),
              ),
            ],
          ],
        );
      },
    );
  }
}
