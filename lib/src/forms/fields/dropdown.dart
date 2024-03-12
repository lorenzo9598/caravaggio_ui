import 'package:caravaggio_ui/caravaggio_ui.dart';
import 'package:flutter/material.dart';

import 'package:rxdart/subjects.dart';

/// Represents an item in a dropdown.
class CDropdownItemModel<T> {
  /// The value of the dropdown item.
  T value;

  /// The text to display for the dropdown item.
  String text;

  /// Creates a [CDropdownItemModel] instance.
  CDropdownItemModel({required this.value, required this.text});
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

class CDropdownStyle extends CFieldStyle {
  final TextStyle? itemsTextStyle;
  final TextStyle? textStyle;

  /// Indicates whether the dropdown items should be filled.
  final bool? itemsFilled;
  CDropdownStyle({
    super.backgroundColor,
    super.foregroundColor,
    super.gradient,
    super.filled = false,
    super.bordered = false,
    this.itemsTextStyle,
    this.textStyle,
    this.itemsFilled,
  });

  /// Creates a simple dropdown style.
  @override
  factory CDropdownStyle.simple({
    Color? foregroundColor,
    TextStyle? itemsTextStyle,
    TextStyle? textStyle,
    bool? itemsFilled,
  }) {
    return CDropdownStyle(
      foregroundColor: foregroundColor,
      itemsTextStyle: itemsTextStyle,
      textStyle: textStyle,
      itemsFilled: itemsFilled,
    );
  }

  /// Creates a filled dropdown style.
  @override
  factory CDropdownStyle.filled({
    Color? backgroundColor,
    Color? foregroundColor,
    LinearGradient? gradient,
    TextStyle? itemsTextStyle,
    TextStyle? textStyle,
    bool? itemsFilled,
  }) {
    return CDropdownStyle(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      gradient: gradient,
      filled: true,
      itemsTextStyle: itemsTextStyle,
      textStyle: textStyle,
      itemsFilled: itemsFilled,
    );
  }

  /// Creates a bordered dropdown style.
  @override
  factory CDropdownStyle.bordered({
    Color? foregroundColor,
    TextStyle? itemsTextStyle,
    TextStyle? textStyle,
    bool? itemsFilled,
  }) {
    return CDropdownStyle(
      foregroundColor: foregroundColor,
      bordered: true,
      itemsTextStyle: itemsTextStyle,
      textStyle: textStyle,
      itemsFilled: itemsFilled,
    );
  }

  /// Creates a bordered and filled dropdown style.
  @override
  factory CDropdownStyle.borderedFilled({
    Color? backgroundColor,
    Color? foregroundColor,
    LinearGradient? gradient,
    TextStyle? itemsTextStyle,
    TextStyle? textStyle,
    bool? itemsFilled,
  }) {
    return CDropdownStyle(
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      gradient: gradient,
      filled: true,
      bordered: true,
      itemsTextStyle: itemsTextStyle,
      textStyle: textStyle,
      itemsFilled: itemsFilled,
    );
  }
}

/// A stylized dropdown widget.
class CDropdown<T> extends StatefulWidget {
  /// The list of items in the dropdown.
  final List<CDropdownItemModel<T>> items;

  /// The controller managing the selected item.
  final CDropdownController<T>? controller;

  /// Validator function for the dropdown.
  final String? Function(T?)? validator;

  /// Indicates whether the dropdown is disabled.
  final bool disabled;

  /// Function called when the selected item changes.
  final void Function(T?)? onChanged;

  final CFieldDecoration decoration;
  final CDropdownStyle style;

  /// Creates a [CDropdown] instance.
  CDropdown({
    Key? key,
    CDropdownStyle? style,
    required this.items,
    this.controller,
    this.validator,
    this.disabled = false,
    this.onChanged,
    required this.decoration,
  })  : style = style ?? CDropdownStyle.simple(),
        super(key: key);

  /// Creates a simple [CDropdown] instance.
  factory CDropdown.simple({
    required List<CDropdownItemModel<T>> items,
    CDropdownController<T>? controller,
    String? Function(T?)? validator,
    bool disabled = false,
    void Function(T?)? onChanged,
    CFieldDecoration decoration = const CFieldDecoration(),
    //style
    Color? foregroundColor,
    TextStyle? itemsTextStyle,
    TextStyle? textStyle,
    bool? itemsFilled,
  }) {
    return CDropdown(
      items: items,
      controller: controller,
      validator: validator,
      disabled: disabled,
      onChanged: onChanged,
      decoration: decoration,
      style: CDropdownStyle.simple(
        foregroundColor: foregroundColor,
        itemsTextStyle: itemsTextStyle,
        textStyle: textStyle,
        itemsFilled: itemsFilled,
      ),
    );
  }

  /// Creates a bordered [CDropdown] instance.
  factory CDropdown.bordered({
    required List<CDropdownItemModel<T>> items,
    CDropdownController<T>? controller,
    String? Function(T?)? validator,
    bool disabled = false,
    void Function(T?)? onChanged,
    CFieldDecoration decoration = const CFieldDecoration(),
    //style
    Color? foregroundColor,
    TextStyle? itemsTextStyle,
    TextStyle? textStyle,
    bool? itemsFilled,
  }) {
    return CDropdown(
      decoration: decoration,
      style: CDropdownStyle.bordered(
        foregroundColor: foregroundColor,
        itemsTextStyle: itemsTextStyle,
        textStyle: textStyle,
        itemsFilled: itemsFilled,
      ),
      items: items,
      controller: controller,
      validator: validator,
      disabled: disabled,
      onChanged: onChanged,
    );
  }

  /// Creates a filled [CDropdown] instance.
  factory CDropdown.filled({
    required List<CDropdownItemModel<T>> items,
    CDropdownController<T>? controller,
    String? Function(T?)? validator,
    bool disabled = false,
    void Function(T?)? onChanged,
    CFieldDecoration decoration = const CFieldDecoration(),
    //style
    Color? backgroundColor,
    Color? foregroundColor,
    LinearGradient? gradient,
    TextStyle? itemsTextStyle,
    TextStyle? textStyle,
    bool? itemsFilled,
  }) {
    return CDropdown(
      items: items,
      decoration: decoration,
      style: CDropdownStyle.filled(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        gradient: gradient,
        itemsTextStyle: itemsTextStyle,
        textStyle: textStyle,
        itemsFilled: itemsFilled,
      ),
      controller: controller,
      validator: validator,
      disabled: disabled,
      onChanged: onChanged,
    );
  }

  /// Creates a bordered and filled [CDropdown] instance.
  factory CDropdown.borderedFilled({
    required List<CDropdownItemModel<T>> items,
    CDropdownController<T>? controller,
    String? Function(T?)? validator,
    bool disabled = false,
    void Function(T?)? onChanged,
    CFieldDecoration decoration = const CFieldDecoration(),
    //style
    Color? backgroundColor,
    Color? foregroundColor,
    LinearGradient? gradient,
    TextStyle? itemsTextStyle,
    TextStyle? textStyle,
    bool? itemsFilled,
  }) {
    return CDropdown(
      items: items,
      decoration: decoration,
      style: CDropdownStyle.borderedFilled(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        gradient: gradient,
        itemsTextStyle: itemsTextStyle,
        textStyle: textStyle,
        itemsFilled: itemsFilled,
      ),
      controller: controller,
      validator: validator,
      disabled: disabled,
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

  InputDecoration get inputDecoration => InputDecoration(
      prefixIcon: widget.decoration.prefixIcon,
      suffixIcon: widget.decoration.suffixIcon,
      hintText: widget.decoration.hintText,
      hintStyle: TextStyle(
        fontStyle: FontStyle.italic,
        color: widget.disabled ? Colors.grey[350] ?? Colors.grey : CaravaggioUI.instance.primaryColorLight,
      ),
      labelText: widget.decoration.labelText,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(widget.decoration.borderRadius)),
        borderSide: widget.style.bordered ? BorderSide(color: widget.disabled ? Colors.grey[350] ?? Colors.grey : _borderColor, width: 1) : BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(widget.decoration.borderRadius)),
        borderSide: widget.style.bordered ? BorderSide(color: widget.disabled ? Colors.grey[350] ?? Colors.grey : _borderColor, width: 1) : BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(widget.decoration.borderRadius)),
        borderSide: widget.style.bordered
            ? BorderSide(
                color: _borderColor,
                width: 2,
              )
            : BorderSide.none,
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(widget.decoration.borderRadius)),
        borderSide: BorderSide(color: Colors.red[900] ?? Colors.red, width: 2),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(widget.decoration.borderRadius)),
        borderSide: BorderSide(color: Colors.red[900] ?? Colors.red, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(widget.decoration.borderRadius)),
        borderSide: widget.style.bordered ? const BorderSide(color: Colors.grey, width: 2) : BorderSide.none,
      ),
      errorStyle: const TextStyle(height: 0));

  @override
  Widget build(BuildContext context) {
    final items = widget.items
        .map(
          (e) => DropdownMenuItem<T>(value: e.value, child: Text(e.text, overflow: TextOverflow.ellipsis, style: widget.style.itemsTextStyle)),
        )
        .toList();

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(widget.decoration.borderRadius),
        ),
        gradient: (widget.style.filled) && !widget.disabled ? CGradient.primaryToSecondary.opacity(0.3) : null,
      ),
      child: DropdownButtonFormField<T>(
        borderRadius: BorderRadius.all(Radius.circular(widget.decoration.borderRadius)),
        value: selectedValue,
        validator: widget.validator,
        isExpanded: true,
        hint: widget.decoration.hintText != null ? Text(widget.decoration.hintText!) : null,
        iconEnabledColor: CaravaggioUI.instance.primaryColor,
        icon: const Icon(Icons.keyboard_arrow_down_rounded),
        decoration: inputDecoration,
        items: items,
        style: widget.style.itemsTextStyle,
        onChanged: _onChanged,
        selectedItemBuilder: (context) => widget.items
            .map(
              (e) => DropdownMenuItem<T>(
                value: e.value,
                child: Text(
                  e.text,
                  overflow: TextOverflow.ellipsis,
                  style: widget.style.textStyle,
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
