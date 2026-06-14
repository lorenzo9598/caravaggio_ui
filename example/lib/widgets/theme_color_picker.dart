import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';

/// Home-page controls to change Caravaggio primary and secondary colors at runtime.
class ThemeColorPicker extends StatelessWidget {
  const ThemeColorPicker({super.key, this.compact = false});

  final bool compact;

  Future<void> _pickColor(
    BuildContext context, {
    required String label,
    required Color currentColor,
    required ValueChanged<Color> onColorChanged,
  }) async {
    final pickedColor = await showDialog<Color>(
      context: context,
      builder: (context) => _ColorPickerDialog(
        title: label,
        initialColor: currentColor,
      ),
    );

    if (pickedColor != null) {
      onColorChanged(pickedColor);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 12 : 16,
        vertical: compact ? 10 : 16,
      ),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.all(compact ? AppRadius.m : AppRadius.l),
        border: compact
            ? Border.all(color: theme.dividerColor.withValues(alpha: 0.35))
            : null,
        boxShadow: compact ? null : AppShadow.sm,
      ),
      child: compact ? _buildCompactLayout(context) : _buildDefaultLayout(context),
    );
  }

  Widget _buildDefaultLayout(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CText.title('Theme colors', size: TextSize.medium),
        const SizedBox(height: 4),
        CText.body(
          'Tap a swatch to customize the palette across all demos.',
          size: TextSize.small,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _ColorSwatch(
                label: 'Primary',
                color: CColors.primaryColor,
                onTap: () => _pickColor(
                  context,
                  label: 'Primary color',
                  currentColor: CColors.primaryColor,
                  onColorChanged: (color) => CaravaggioUI.instance.updateColors(primaryColor: color),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _ColorSwatch(
                label: 'Secondary',
                color: CColors.secondaryColor,
                onTap: () => _pickColor(
                  context,
                  label: 'Secondary color',
                  currentColor: CColors.secondaryColor,
                  onColorChanged: (color) => CaravaggioUI.instance.updateColors(secondaryColor: color),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCompactLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CText.label('Theme colors', size: TextSize.small),
              const SizedBox(height: 2),
              CText.body(
                'Tap a swatch to customize',
                size: TextSize.small,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodySmall?.color?.withValues(alpha: 0.65),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        _ColorSwatch(
          label: 'Primary',
          color: CColors.primaryColor,
          height: 44,
          compact: true,
          onTap: () => _pickColor(
            context,
            label: 'Primary color',
            currentColor: CColors.primaryColor,
            onColorChanged: (color) => CaravaggioUI.instance.updateColors(primaryColor: color),
          ),
        ),
        const SizedBox(width: 8),
        _ColorSwatch(
          label: 'Secondary',
          color: CColors.secondaryColor,
          height: 44,
          compact: true,
          onTap: () => _pickColor(
            context,
            label: 'Secondary color',
            currentColor: CColors.secondaryColor,
            onColorChanged: (color) => CaravaggioUI.instance.updateColors(secondaryColor: color),
          ),
        ),
      ],
    );
  }
}

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({
    required this.label,
    required this.color,
    required this.onTap,
    this.height = 72,
    this.compact = false,
  });

  final String label;
  final Color color;
  final VoidCallback onTap;
  final double height;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final onColor = color.computeLuminance() > 0.5 ? Colors.black87 : Colors.white;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: const BorderRadius.all(AppRadius.m),
        child: Ink(
          width: compact ? 72 : null,
          height: height,
          decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(AppRadius.m),
            border: Border.all(color: Colors.black12),
          ),
          child: compact
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CText.label(
                      label,
                      size: TextSize.small,
                      style: TextStyle(color: onColor, fontSize: 11),
                    ),
                    Icon(Icons.colorize_outlined, size: 16, color: onColor),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CText.label(
                      label,
                      size: TextSize.small,
                      style: TextStyle(color: onColor),
                    ),
                    const SizedBox(height: 4),
                    Icon(Icons.colorize_outlined, size: 18, color: onColor),
                  ],
                ),
        ),
      ),
    );
  }
}

class _ColorPickerDialog extends StatefulWidget {
  const _ColorPickerDialog({
    required this.title,
    required this.initialColor,
  });

  final String title;
  final Color initialColor;

  @override
  State<_ColorPickerDialog> createState() => _ColorPickerDialogState();
}

class _ColorPickerDialogState extends State<_ColorPickerDialog> {
  late HSVColor _hsvColor;

  @override
  void initState() {
    super.initState();
    _hsvColor = HSVColor.fromColor(widget.initialColor);
  }

  void _updateHue(double hue) {
    setState(() => _hsvColor = _hsvColor.withHue(hue));
  }

  void _updateSaturation(double saturation) {
    setState(() => _hsvColor = _hsvColor.withSaturation(saturation));
  }

  void _updateValue(double value) {
    setState(() => _hsvColor = _hsvColor.withValue(value));
  }

  @override
  Widget build(BuildContext context) {
    final selectedColor = _hsvColor.toColor();

    return AlertDialog(
      title: CText.title(widget.title, size: TextSize.medium),
      content: SizedBox(
        width: 280,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 72,
              decoration: BoxDecoration(
                color: selectedColor,
                borderRadius: const BorderRadius.all(AppRadius.m),
                border: Border.all(color: Colors.black12),
              ),
            ),
            const SizedBox(height: 16),
            _SliderRow(
              label: 'Hue',
              value: _hsvColor.hue,
              max: 360,
              activeColor: HSVColor.fromAHSV(1, _hsvColor.hue, 1, 1).toColor(),
              onChanged: _updateHue,
            ),
            _SliderRow(
              label: 'Saturation',
              value: _hsvColor.saturation,
              max: 1,
              activeColor: selectedColor,
              onChanged: _updateSaturation,
            ),
            _SliderRow(
              label: 'Brightness',
              value: _hsvColor.value,
              max: 1,
              activeColor: selectedColor,
              onChanged: _updateValue,
            ),
          ],
        ),
      ),
      actions: [
        CButton.text(
          onPressed: () => Navigator.pop(context),
          child: CText.label('Cancel'),
        ),
        CButton.elevated(
          onPressed: () => Navigator.pop(context, selectedColor),
          child: CText.label('Apply'),
        ),
      ],
    );
  }
}

class _SliderRow extends StatelessWidget {
  const _SliderRow({
    required this.label,
    required this.value,
    required this.max,
    required this.activeColor,
    required this.onChanged,
  });

  final String label;
  final double value;
  final double max;
  final Color activeColor;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CText.label(label, size: TextSize.small),
          Slider(
            value: value.clamp(0, max),
            min: 0,
            max: max,
            activeColor: activeColor,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
