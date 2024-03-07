import 'package:flutter/material.dart';

import 'package:rxdart/subjects.dart';

import 'package:caravaggio_ui/src/generics/gradients/gradients.dart';
import 'package:caravaggio_ui/src/theme.dart';

/// Represents an item in a dropdown.
class DropdownItemModel<T> {
  /// The value of the dropdown item.
  T value;

  /// The text to display for the dropdown item.
  String text;

  /// Creates a [DropdownItemModel] instance.
  DropdownItemModel({required this.value, required this.text});
}

/// Controller for managing the state of a [CDropdown].
class CDropdownController<T> {
  final BehaviorSubject<T?> _controller;

  /// Constructs a [CDropdownController] with an optional initial value.
  CDropdownController({T? initialValue}) : _controller = BehaviorSubject<T?>.seeded(initialValue);

  /// Retrieves the current value of the dropdown.
  T? get value => _controller.value;

  /// Retrieves the stream of boolean values representing the state of the dropdown.
  Stream<T?> get stream => _controller.stream;

  /// Listens for changes in the dropdown state.
  void listen(void Function(T?) onData) {
    _controller.listen(onData);
  }

  /// Adds a new value to the dropdown state.
  void add(T? value) {
    _controller.add(value);
  }

  /// Disposes the controller.
  void dispose() {
    _controller.close();
  }
}

/// A stylized dropdown widget.
class CDropdown<T> extends StatefulWidget {
  /// The list of items in the dropdown.
  final List<DropdownItemModel<T>> items;

  /// The controller managing the selected item.
  final CDropdownController<T>? controller;

  /// Indicates whether the dropdown items should be filled.
  final bool? itemsFilled;

  /// Text style for the dropdown items.
  final TextStyle? itemsTextStyle;

  /// Indicates whether the dropdown should be filled.
  final bool? filled;

  /// Text style for the dropdown.
  final TextStyle? textStyle;

  /// Indicates whether the dropdown should be bordered.
  final bool bordered;

  /// Widget to display as a hint.
  final Widget? hint;

  /// Widget to display as a label.
  final Widget? label;

  /// Validator function for the dropdown.
  final String? Function(T?)? validator;

  /// Indicates whether the dropdown is disabled.
  final bool disabled;

  /// The border radius of the dropdown.
  final double borderRadius;

  /// Function called when the selected item changes.
  final void Function(T?)? onChanged;

  /// Creates a [CDropdown] instance.
  const CDropdown({
    Key? key,
    required this.items,
    this.controller,
    this.itemsFilled,
    this.itemsTextStyle,
    this.filled,
    this.textStyle,
    this.bordered = false,
    this.hint,
    this.label,
    this.validator,
    this.disabled = false,
    this.borderRadius = 15,
    this.onChanged,
  }) : super(key: key);

  /// Creates a simple [CDropdown] instance.
  factory CDropdown.simple({
    required List<DropdownItemModel<T>> items,
    CDropdownController<T>? controller,
    bool? itemsFilled,
    TextStyle? itemsTextStyle,
    TextStyle? textStyle,
    Widget? hint,
    Widget? label,
    String? Function(T?)? validator,
    bool disabled = false,
    void Function(T?)? onChanged,
  }) {
    return CDropdown(
      items: items,
      controller: controller,
      itemsFilled: itemsFilled,
      itemsTextStyle: itemsTextStyle,
      textStyle: textStyle,
      hint: hint,
      label: label,
      validator: validator,
      disabled: disabled,
      onChanged: onChanged,
    );
  }

  /// Creates a bordered [CDropdown] instance.
  factory CDropdown.bordered({
    required List<DropdownItemModel<T>> items,
    CDropdownController<T>? controller,
    bool? itemsFilled,
    TextStyle? itemsTextStyle,
    TextStyle? textStyle,
    Widget? hint,
    Widget? label,
    String? Function(T?)? validator,
    bool disabled = false,
    void Function(T?)? onChanged,
  }) {
    return CDropdown(
      items: items,
      controller: controller,
      itemsFilled: itemsFilled,
      itemsTextStyle: itemsTextStyle,
      textStyle: textStyle,
      hint: hint,
      label: label,
      validator: validator,
      disabled: disabled,
      bordered: true,
      onChanged: onChanged,
    );
  }

  /// Creates a filled [CDropdown] instance.
  factory CDropdown.filled({
    required List<DropdownItemModel<T>> items,
    CDropdownController<T>? controller,
    bool? itemsFilled,
    TextStyle? itemsTextStyle,
    TextStyle? textStyle,
    Widget? hint,
    Widget? label,
    String? Function(T?)? validator,
    bool disabled = false,
    void Function(T?)? onChanged,
  }) {
    return CDropdown(
      items: items,
      controller: controller,
      itemsFilled: itemsFilled,
      itemsTextStyle: itemsTextStyle,
      textStyle: textStyle,
      hint: hint,
      label: label,
      validator: validator,
      disabled: disabled,
      filled: true,
      onChanged: onChanged,
    );
  }

  /// Creates a bordered and filled [CDropdown] instance.
  factory CDropdown.borderedFilled({
    required List<DropdownItemModel<T>> items,
    CDropdownController<T>? controller,
    bool? itemsFilled,
    TextStyle? itemsTextStyle,
    TextStyle? textStyle,
    Widget? hint,
    Widget? label,
    String? Function(T?)? validator,
    bool disabled = false,
    void Function(T?)? onChanged,
  }) {
    return CDropdown(
      items: items,
      controller: controller,
      itemsFilled: itemsFilled,
      itemsTextStyle: itemsTextStyle,
      textStyle: textStyle,
      hint: hint,
      label: label,
      validator: validator,
      disabled: disabled,
      filled: true,
      bordered: true,
      onChanged: onChanged,
    );
  }

  @override
  State<CDropdown<T>> createState() => _CDropdownState<T>();
}

/// The state of a [CDropdown] widget.
class _CDropdownState<T> extends State<CDropdown<T>> {
  late T? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.controller?.value;
    widget.controller?.listen((value) {
      if (mounted) {
        setState(() {
          selectedValue = value;
        });
      }
    });
  }

  static final Color _borderColor = CaravaggioUI.instance.primaryColor;

  @override
  Widget build(BuildContext context) {
    final items = widget.items
        .map(
          (e) => DropdownMenuItem<T>(value: e.value, child: Text(e.text, overflow: TextOverflow.ellipsis, style: widget.itemsTextStyle)),
        )
        .toList();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(widget.borderRadius),
        ),
        gradient: (widget.filled ?? false) && !widget.disabled ? CaravaggioGradient.primaryToSecondary.opacity(0.3) : null,
      ),
      child: DropdownButtonFormField<T>(
        borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
        value: selectedValue,
        validator: widget.validator,
        isExpanded: true,
        hint: widget.hint,
        iconEnabledColor: CaravaggioUI.instance.primaryColor,
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        decoration: InputDecoration(
            hintStyle: TextStyle(
              fontStyle: FontStyle.italic,
              color: widget.disabled ? Colors.grey[350] ?? Colors.grey : CaravaggioUI.instance.primaryColorLight,
            ),
            label: widget.label,
            isDense: false,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
              borderSide: widget.bordered ? BorderSide(color: widget.disabled ? Colors.grey[350] ?? Colors.grey : _borderColor, width: 1) : BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
              borderSide: widget.bordered ? BorderSide(color: widget.disabled ? Colors.grey[350] ?? Colors.grey : _borderColor, width: 1) : BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(widget.borderRadius)),
              borderSide: widget.bordered
                  ? BorderSide(
                      color: _borderColor,
                      width: 2,
                    )
                  : BorderSide.none,
            ),
            errorStyle: const TextStyle(height: 0)),
        items: items,
        style: widget.itemsTextStyle,
        onChanged: _onChanged,
        selectedItemBuilder: (context) => widget.items
            .map(
              (e) => DropdownMenuItem<T>(
                value: e.value,
                child: Text(
                  e.text,
                  overflow: TextOverflow.ellipsis,
                  style: widget.textStyle,
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  void _onChanged(T? value) {
    if (widget.disabled) return;
    if (widget.onChanged != null) {
      widget.onChanged?.call(value);
      return;
    }
    if (value != null) {
      widget.controller?.add(value);
    }
  }
}
