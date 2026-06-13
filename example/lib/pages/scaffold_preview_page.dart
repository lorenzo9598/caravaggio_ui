import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:caravaggio_ui_app/widgets/demo_scaffold_title.dart';
import 'package:caravaggio_ui_app/widgets/scaffold.dart';
import 'package:caravaggio_ui_app/widgets/section.dart';
import 'package:flutter/material.dart' hide Card;

import 'page_constants.dart';

enum _GradientPreset {
  customDefault('Custom default'),
  primaryLightToSecondaryLight('Primary light → secondary light'),
  primaryToSecondary('Primary → secondary'),
  primaryDarkToSecondaryDark('Primary dark → secondary dark'),
  secondaryLight('Secondary light');

  const _GradientPreset(this.label);

  final String label;

  Gradient toGradient() {
    switch (this) {
      case _GradientPreset.customDefault:
        return LinearGradient(
          colors: [
            CColors.primary.shade50,
            CColors.secondary.shade50,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        );
      case _GradientPreset.primaryLightToSecondaryLight:
        return CGradient.primaryLightToSecondaryLight;
      case _GradientPreset.primaryToSecondary:
        return CGradient.primaryToSecondary;
      case _GradientPreset.primaryDarkToSecondaryDark:
        return CGradient.primaryDarkToSecondaryDark;
      case _GradientPreset.secondaryLight:
        return CGradient.secondaryLight;
    }
  }
}

enum _OverlayColorPreset {
  defaultSecondaryLight('Default'),
  primaryLight('Primary light'),
  primary('Primary'),
  secondaryLight('Secondary light'),
  secondary('Secondary'),
  white('White');

  const _OverlayColorPreset(this.label);

  final String label;

  Color? toColor() {
    switch (this) {
      case _OverlayColorPreset.defaultSecondaryLight:
        return null;
      case _OverlayColorPreset.primaryLight:
        return CColors.primaryColorLight;
      case _OverlayColorPreset.primary:
        return CColors.primaryColor;
      case _OverlayColorPreset.secondaryLight:
        return CColors.secondaryColorLight;
      case _OverlayColorPreset.secondary:
        return CColors.secondaryColor;
      case _OverlayColorPreset.white:
        return Colors.white;
    }
  }
}

enum _BackButtonScrolledColorPreset {
  defaultSecondary('Default'),
  primaryLight('Primary light'),
  primary('Primary'),
  secondaryLight('Secondary light'),
  secondary('Secondary'),
  white('White');

  const _BackButtonScrolledColorPreset(this.label);

  final String label;

  Color? toColor() {
    switch (this) {
      case _BackButtonScrolledColorPreset.defaultSecondary:
        return null;
      case _BackButtonScrolledColorPreset.primaryLight:
        return CColors.primaryColorLight;
      case _BackButtonScrolledColorPreset.primary:
        return CColors.primaryColor;
      case _BackButtonScrolledColorPreset.secondaryLight:
        return CColors.secondaryColorLight;
      case _BackButtonScrolledColorPreset.secondary:
        return CColors.secondaryColor;
      case _BackButtonScrolledColorPreset.white:
        return Colors.white;
    }
  }
}

/// Live playground for [CScaffold] / [CustomScaffold] styling and behavior.
class ScaffoldBackButtonPreviewPage extends StatefulWidget {
  const ScaffoldBackButtonPreviewPage({super.key});

  @override
  State<ScaffoldBackButtonPreviewPage> createState() => _ScaffoldBackButtonPreviewPageState();
}

class _ScaffoldBackButtonPreviewPageState extends State<ScaffoldBackButtonPreviewPage> {
  late final TextEditingController _titleController;

  bool _showTitle = true;
  bool _useLogoTitle = false;
  bool _hideTitleOnScroll = true;
  Alignment _titleAlignment = Alignment.center;

  bool _showAppDrawer = false;
  bool _showBackButton = true;
  bool _showCustomAction = false;
  bool _customBackPressed = false;

  double _backTopAlpha = 0.5;
  double _backScrolledAlpha = 0.7;
  bool _backBorder = false;
  IconData? _backIcon;

  bool _showBackgroundLayers = false;
  _GradientPreset _gradientPreset = _GradientPreset.customDefault;
  _OverlayColorPreset _overlayColorPreset = _OverlayColorPreset.defaultSecondaryLight;
  _BackButtonScrolledColorPreset _backScrolledColorPreset = _BackButtonScrolledColorPreset.defaultSecondary;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: 'Title');
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  BorderSide? get _backButtonBorder => _backBorder ? BorderSide(color: CColors.primaryColor.withValues(alpha: 0.35)) : null;

  Widget? get _title {
    if (!_showTitle) return null;
    if (_useLogoTitle) return demoScaffoldColorsTitle();
    return demoScaffoldTitle(_titleController.text);
  }

  Widget? get _action {
    if (!_showCustomAction) return null;
    return IconButton(
      tooltip: 'Custom action',
      onPressed: () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Custom action pressed')),
        );
      },
      icon: Icon(Icons.favorite_border, color: CColors.primaryColor),
    );
  }

  VoidCallback? get _onBackPressed {
    if (!_customBackPressed) return null;
    return () {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Custom back pressed (page not popped)')),
      );
    };
  }

  void _notifyChanged([VoidCallback? update]) {
    setState(update ?? () {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      showAppDrawer: _showAppDrawer,
      showBackButton: _showBackButton,
      title: _title,
      titleAlignment: _titleAlignment,
      hideTitleOnScroll: _hideTitleOnScroll,
      action: _action,
      showBackgroundLayers: _showBackgroundLayers,
      backgroundGradient: _gradientPreset.toGradient(),
      scrollOverlayColor: _overlayColorPreset.toColor(),
      onBackPressed: _onBackPressed,
      backButtonTopBackgroundAlpha: _backTopAlpha,
      backButtonScrolledBackgroundAlpha: _backScrolledAlpha,
      backButtonScrolledBackgroundColor: _backScrolledColorPreset.toColor(),
      backButtonBorder: _backButtonBorder,
      backButtonIcon: _backIcon,
      bodyBuilder: (context, topPadding) {
        return SingleChildScrollView(
          padding: EdgeInsets.only(top: topPadding + 12, left: 16, right: 16, bottom: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                label: 'showTitle',
                content: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: CText.label('Show title in app bar'),
                  value: _showTitle,
                  onChanged: (value) => _notifyChanged(() => _showTitle = value),
                ),
              ),
              if (_showTitle) ...[
                const SizedBox(height: 16),
                Card(
                  label: 'title',
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: CText.label('Use logo title widget'),
                        value: _useLogoTitle,
                        onChanged: (value) => _notifyChanged(() => _useLogoTitle = value),
                      ),
                      if (!_useLogoTitle) ...[
                        const SizedBox(height: 8),
                        CTextField.bordered(
                          controller: _titleController,
                          decoration: const CFieldDecoration(
                            labelText: 'Title text',
                          ),
                          onChanged: (_) => _notifyChanged(),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  label: 'hideTitleOnScroll',
                  content: Column(
                    children: [
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: CText.label('Hide title while scrolling down'),
                        value: _hideTitleOnScroll,
                        onChanged: (value) => _notifyChanged(() => _hideTitleOnScroll = value),
                      ),
                      CText.body(
                        'Fade range: ${kCScaffoldTitleHideScrollRange.toStringAsFixed(0)} px. '
                        'Scroll the area below to test.',
                        size: TextSize.small,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  label: 'titleAlignment',
                  content: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      _AlignmentChip(
                        label: 'Center',
                        selected: _titleAlignment == Alignment.center,
                        onTap: () => _notifyChanged(() => _titleAlignment = Alignment.center),
                      ),
                      _AlignmentChip(
                        label: 'Center left',
                        selected: _titleAlignment == Alignment.centerLeft,
                        onTap: () => _notifyChanged(() => _titleAlignment = Alignment.centerLeft),
                      ),
                      _AlignmentChip(
                        label: 'Center right',
                        selected: _titleAlignment == Alignment.centerRight,
                        onTap: () => _notifyChanged(() => _titleAlignment = Alignment.centerRight),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 12),
              Card(
                label: 'showBackButton',
                content: Column(
                  children: [
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: CText.label('Show default back pill'),
                      value: _showBackButton,
                      onChanged: (value) => _notifyChanged(() => _showBackButton = value),
                    ),
                    CText.body(
                      _showAppDrawer ? 'Drawer menu takes the left slot; back pill stays hidden while drawer is on.' : 'When off, the left app bar slot is empty.',
                      size: TextSize.small,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Card(
                label: 'action',
                content: Column(
                  children: [
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: CText.label('Show custom action widget'),
                      value: _showCustomAction,
                      onChanged: (value) => _notifyChanged(() => _showCustomAction = value),
                    ),
                    CText.body(
                      'Pinned to the right; independent of the back pill or drawer menu on the left.',
                      size: TextSize.small,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              if (!_showAppDrawer && _showBackButton) ...[
                const SizedBox(height: 16),
                Card(
                  label: 'onBackPressed',
                  content: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: CText.label('Custom back handler (snackbar, no pop)'),
                    value: _customBackPressed,
                    onChanged: (value) => _notifyChanged(() => _customBackPressed = value),
                  ),
                ),
              ],
              const SizedBox(height: 12),
              if (!_showAppDrawer && _showBackButton) ...[
                Card(
                  label: 'backButtonTopBackgroundAlpha',
                  content: Column(
                    children: [
                      Slider(
                        value: _backTopAlpha,
                        min: 0,
                        max: 1,
                        divisions: 20,
                        label: _backTopAlpha.toStringAsFixed(2),
                        onChanged: (value) => _notifyChanged(() => _backTopAlpha = value),
                      ),
                      CText.body(
                        'White pill opacity at scroll offset 0',
                        size: TextSize.small,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  label: 'backButtonScrolledBackgroundAlpha',
                  content: Column(
                    children: [
                      Slider(
                        value: _backScrolledAlpha,
                        min: 0,
                        max: 1,
                        divisions: 20,
                        label: _backScrolledAlpha.toStringAsFixed(2),
                        onChanged: (value) => _notifyChanged(() => _backScrolledAlpha = value),
                      ),
                      CText.body(
                        'Secondary pill opacity after scroll fade',
                        size: TextSize.small,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  label: 'backButtonScrolledBackgroundColor',
                  content: Column(
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        alignment: WrapAlignment.center,
                        children: [
                          for (final preset in _BackButtonScrolledColorPreset.values)
                            _PresetChip(
                              label: preset.label,
                              selected: _backScrolledColorPreset == preset,
                              onTap: () => _notifyChanged(() => _backScrolledColorPreset = preset),
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      CText.body(
                        'Background tint of the back pill after scroll fade. '
                        'Alpha is controlled by backButtonScrolledBackgroundAlpha.',
                        size: TextSize.small,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  label: 'backButtonBorder',
                  content: SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: CText.label('Draw border on back pill'),
                    value: _backBorder,
                    onChanged: (value) => _notifyChanged(() => _backBorder = value),
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  label: 'backButtonIcon',
                  content: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    alignment: WrapAlignment.center,
                    children: [
                      _IconChip(
                        label: 'Default',
                        selected: _backIcon == null,
                        onTap: () => _notifyChanged(() => _backIcon = null),
                      ),
                      _IconChip(
                        label: 'arrow_back',
                        icon: Icons.arrow_back,
                        selected: _backIcon == Icons.arrow_back,
                        onTap: () => _notifyChanged(() => _backIcon = Icons.arrow_back),
                      ),
                      _IconChip(
                        label: 'close',
                        icon: Icons.close,
                        selected: _backIcon == Icons.close,
                        onTap: () => _notifyChanged(() => _backIcon = Icons.close),
                      ),
                      _IconChip(
                        label: 'chevron_left',
                        icon: Icons.chevron_left,
                        selected: _backIcon == Icons.chevron_left,
                        onTap: () => _notifyChanged(() => _backIcon = Icons.chevron_left),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
              ],
              Card(
                label: 'showBackgroundLayers',
                content: SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  title: CText.label('Show animated pattern layers'),
                  value: _showBackgroundLayers,
                  onChanged: (value) => _notifyChanged(() => _showBackgroundLayers = value),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                label: 'backgroundGradient',
                content: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  alignment: WrapAlignment.center,
                  children: [
                    for (final preset in _GradientPreset.values)
                      _PresetChip(
                        label: preset.label,
                        selected: _gradientPreset == preset,
                        onTap: () => _notifyChanged(() => _gradientPreset = preset),
                      ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Card(
                label: 'scrollOverlayColor',
                content: Column(
                  children: [
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      alignment: WrapAlignment.center,
                      children: [
                        for (final preset in _OverlayColorPreset.values)
                          _PresetChip(
                            label: preset.label,
                            selected: _overlayColorPreset == preset,
                            onTap: () => _notifyChanged(() => _overlayColorPreset = preset),
                          ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    CText.body(
                      'Secondary light tint of the top gradient overlay while scrolling. '
                      'Default uses CColors.secondaryColorLight.',
                      size: TextSize.small,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              CText.body(
                'Scroll the area below to exercise title hide, back-button transition, '
                'and scroll overlay color.',
                size: TextSize.small,
                textAlign: TextAlign.center,
              ),
              fillSpacer,
            ],
          ),
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

class _IconChip extends StatelessWidget {
  const _IconChip({
    required this.label,
    required this.selected,
    required this.onTap,
    this.icon,
  });

  final String label;
  final IconData? icon;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      avatar: icon != null ? Icon(icon, size: 18) : null,
      label: CText.label(label, size: TextSize.small),
      selected: selected,
      onSelected: (_) => onTap(),
    );
  }
}

class _PresetChip extends StatelessWidget {
  const _PresetChip({
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
