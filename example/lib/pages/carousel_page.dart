import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/pages/demo_pages.dart';
import 'package:caravaggio_ui_app/widgets/demo_scaffold_title.dart';
import 'package:caravaggio_ui_app/widgets/scaffold.dart';
import 'package:caravaggio_ui_app/widgets/section.dart';
import 'package:flutter/material.dart';

class CarouselPage extends StatelessWidget {
  const CarouselPage({super.key});

  static const double _cardWidth = 280;

  static const _demoImage = NetworkImage(
    'https://images.unsplash.com/photo-1504674900247-0877df9cc836?w=600&h=340&fit=crop',
  );

  Widget _horizontalCarousel(List<Widget> cards) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (int i = 0; i < cards.length; i++) ...[
            if (i > 0) const SizedBox(width: 16),
            cards[i],
          ],
        ],
      ),
    );
  }

  Widget _starSubtitle() {
    return const Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star, size: 16, color: Color(0xFFF5A623)),
        Icon(Icons.star, size: 16, color: Color(0xFFF5A623)),
        Icon(Icons.star, size: 16, color: Color(0xFFF5A623)),
        Icon(Icons.star, size: 16, color: Color(0xFFF5A623)),
        Icon(Icons.star_border, size: 16, color: Color(0xFFF5A623)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      demoPageId: DemoPageId.carousel,
      title: demoScaffoldTitleFor(DemoPageId.carousel),
      bodyBuilder: (context, topPadding) {
        return Sections(
          padding: EdgeInsets.only(top: topPadding + 12, left: 16, right: 16, bottom: 12),
          sections: [
            Section(
              title: 'Stacked',
              icon: Icons.view_agenda_outlined,
              items: [
                (
                  'stackedSimple · gradient',
                  _horizontalCarousel([
                    CCarousel.stackedSimple(
                      width: _cardWidth,
                      gradient: CGradient.primaryToSecondary,
                      title: 'Pasta al pomodoro',
                      subtitle: '4.2 · 320 kcal',
                      description: 'Ricetta veloce con basilico fresco e pomodorini.',
                      tags: const ['Food', 'Trending'],
                    ),
                    CCarousel.stackedSimple(
                      width: _cardWidth,
                      image: _demoImage,
                      backgroundColor: const Color(0xFFF0EBE6),
                      title: 'Weekend brunch',
                      description: 'Custom backgroundColor on the content area.',
                      tags: const ['Chef'],
                      bottom: CButton.outlined(
                        onPressed: () {},
                        elevation: 0,
                        child: CText.label('Discover'),
                      ),
                    ),
                    CCarousel.stackedSimple(
                      width: _cardWidth,
                      title: 'Fallback header',
                      description: 'Uses CGradient.primaryToSecondary when no header is set.',
                    ),
                  ]),
                ),
                (
                  'stacked · custom widgets',
                  CCarousel.stacked(
                    width: _cardWidth,
                    gradient: CGradient.primaryLightToSecondaryLight,
                    title: CText.title('Custom subtitle', size: TextSize.medium),
                    subtitle: _starSubtitle(),
                    description: CText.body(
                      'Subtitle slot accepts any widget, e.g. a star rating row.',
                      size: TextSize.small,
                    ),
                    tags: const [
                      _CCarouselDemoTag(label: 'Custom'),
                    ],
                  ),
                ),
              ],
            ),
            Section(
              title: 'Overlay',
              icon: Icons.layers_outlined,
              items: [
                (
                  'overlaySimple · image',
                  _horizontalCarousel([
                    CCarousel.overlaySimple(
                      width: _cardWidth,
                      image: _demoImage,
                      title: 'Mountain retreat',
                      subtitle: 'Weekend escape',
                      description: 'Tap the card to show a toast.',
                      tags: const ['New', '4.8'],
                      onTap: () {
                        CToast.of(context).showMessage(
                          title: 'Mountain retreat',
                          subtitle: 'Card tapped',
                          variant: CToastVariant.info,
                        );
                      },
                    ),
                    CCarousel.overlaySimple(
                      width: _cardWidth,
                      gradient: CGradient.primaryToSecondary,
                      backgroundColor: CColors.secondaryColor,
                      title: 'Live cooking',
                      description: 'Scrim uses backgroundColor when provided.',
                      tags: const ['Event'],
                    ),
                    CCarousel.overlaySimple(
                      width: _cardWidth,
                      color: CColors.secondaryColorLight,
                      title: 'Minimal overlay',
                      description: 'Solid color header with bottom scrim.',
                    ),
                  ]),
                ),
                (
                  'overlay · bottom action',
                  CCarousel.overlay(
                    width: _cardWidth,
                    image: const Image(
                      image: _demoImage,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                    title: CText.title(
                      'Book now',
                      size: TextSize.medium,
                      style: const TextStyle(color: Colors.white),
                    ),
                    description: CText.body(
                      'Save 20% on your next booking.',
                      size: TextSize.small,
                      style: const TextStyle(color: Colors.white),
                    ),
                    bottom: CButton.outlined(
                      onPressed: () {},
                      color: Colors.white,
                      child: CText.label(
                        'Participate',
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    tags: const [
                      _CCarouselDemoTag(label: 'Promo', overlay: true),
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

class _CCarouselDemoTag extends StatelessWidget {
  const _CCarouselDemoTag({
    required this.label,
    this.overlay = false,
  });

  final String label;
  final bool overlay;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: overlay ? Colors.white.withValues(alpha: 0.15) : CColors.primaryColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.all(AppRadius.custom(10)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: CText.label(
        label,
        size: TextSize.small,
        style: TextStyle(color: overlay ? Colors.white : CColors.primaryColor),
      ),
    );
  }
}
