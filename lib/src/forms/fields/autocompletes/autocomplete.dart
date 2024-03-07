import 'package:caravaggio_ui/src/forms/fields/commons/internal_components.dart';
import 'package:caravaggio_ui/src/forms/fields/commons/classes.dart';
import 'package:flutter/material.dart';

/// A widget that provides autocomplete functionality for a given list of options.
class CAutocomplete<T extends Object> extends StatefulWidget {
  /// Style for the field.
  final CFieldStyle style;

  /// Decoration for the field.
  final CFieldDecoration decoration;

  /// List of options for autocomplete.
  final List<T> options;

  /// Function to convert an option value to a string for matching.
  final String Function(T option) optionsValueToMatch;

  /// Function to get the display string for an option.
  final String Function(T option) displayStringForOption;

  /// Function to trigger search for items.
  final void Function() searchItems;

  /// Callback when an option is selected.
  final void Function(T option)? onSelected;

  /// Initial value for the autocomplete field.
  final String? initialValue;

  /// Validator function for the autocomplete field.
  final String? Function(String?)? validator;

  /// Focus node for the autocomplete field.
  final FocusNode? focusNode;

  /// Private constructor for [CAutocomplete].
  const CAutocomplete._({
    Key? key,
    required this.style,
    required this.decoration,
    required this.options,
    required this.optionsValueToMatch,
    required this.searchItems,
    this.onSelected,
    this.initialValue,
    required this.displayStringForOption,
    this.validator,
    this.focusNode,
  }) : super(key: key);

  /// Creates a simple autocomplete field.
  factory CAutocomplete.simple({
    Color? foregroundColor,
    CFieldDecoration decoration = const CFieldDecoration(),
    required List<T> options,
    required String Function(T option) optionsValueToMatch,
    required String Function(T option) displayStringForOption,
    required void Function() searchItems,
    void Function(T option)? onSelected,
    String? initialValue,
    String? Function(String?)? validator,
    FocusNode? focusNode,
  }) {
    return CAutocomplete._(
      style: CFieldStyle.simple(foregroundColor: foregroundColor),
      decoration: decoration,
      options: options,
      optionsValueToMatch: optionsValueToMatch,
      searchItems: searchItems,
      onSelected: onSelected,
      initialValue: initialValue,
      displayStringForOption: displayStringForOption,
      validator: validator,
      focusNode: focusNode,
    );
  }

  /// Creates a bordered autocomplete field.
  factory CAutocomplete.bordered({
    Color? foregroundColor,
    CFieldDecoration decoration = const CFieldDecoration(),
    required List<T> options,
    required String Function(T option) optionsValueToMatch,
    required String Function(T option) displayStringForOption,
    required void Function() searchItems,
    void Function(T option)? onSelected,
    String? initialValue,
    String? Function(String?)? validator,
    FocusNode? focusNode,
  }) {
    return CAutocomplete._(
      style: CFieldStyle.bordered(foregroundColor: foregroundColor),
      decoration: decoration,
      options: options,
      optionsValueToMatch: optionsValueToMatch,
      searchItems: searchItems,
      onSelected: onSelected,
      initialValue: initialValue,
      displayStringForOption: displayStringForOption,
      validator: validator,
      focusNode: focusNode,
    );
  }

  /// Creates a filled autocomplete field.
  factory CAutocomplete.filled({
    Color? backgroundColor,
    Color? foregroundColor,
    LinearGradient? gradient,
    CFieldDecoration decoration = const CFieldDecoration(),
    required List<T> options,
    required String Function(T option) optionsValueToMatch,
    required String Function(T option) displayStringForOption,
    required void Function() searchItems,
    void Function(T option)? onSelected,
    String? initialValue,
    String? Function(String?)? validator,
    FocusNode? focusNode,
  }) {
    return CAutocomplete._(
      style: CFieldStyle.filled(backgroundColor: backgroundColor, foregroundColor: foregroundColor, gradient: gradient),
      decoration: decoration,
      options: options,
      optionsValueToMatch: optionsValueToMatch,
      searchItems: searchItems,
      onSelected: onSelected,
      initialValue: initialValue,
      displayStringForOption: displayStringForOption,
      validator: validator,
      focusNode: focusNode,
    );
  }

  /// Creates a bordered and filled autocomplete field.
  factory CAutocomplete.borderedFilled({
    Color? backgroundColor,
    Color? foregroundColor,
    LinearGradient? gradient,
    CFieldDecoration decoration = const CFieldDecoration(),
    required List<T> options,
    required String Function(T option) optionsValueToMatch,
    required String Function(T option) displayStringForOption,
    required void Function() searchItems,
    void Function(T option)? onSelected,
    String? initialValue,
    String? Function(String?)? validator,
    FocusNode? focusNode,
  }) {
    return CAutocomplete._(
      style: CFieldStyle.borderedFilled(backgroundColor: backgroundColor, foregroundColor: foregroundColor, gradient: gradient),
      decoration: decoration,
      options: options,
      optionsValueToMatch: optionsValueToMatch,
      searchItems: searchItems,
      onSelected: onSelected,
      initialValue: initialValue,
      displayStringForOption: displayStringForOption,
      validator: validator,
      focusNode: focusNode,
    );
  }

  @override
  State<CAutocomplete<T>> createState() => _CAutocompleteState<T>();
}

/// The state for [CAutocomplete].
class _CAutocompleteState<T extends Object> extends State<CAutocomplete<T>> {
  @override
  Widget build(BuildContext context) {
    return FieldContainer(
      decoration: widget.decoration,
      style: widget.style,
      child: Autocomplete<T>(
        initialValue: TextEditingValue(text: widget.initialValue ?? ""),
        optionsBuilder: (textEditingValue) {
          widget.searchItems.call();

          if (textEditingValue.text == '') {
            return Iterable<T>.empty();
          }
          return widget.options.where((option) => widget.optionsValueToMatch.call(option).contains(textEditingValue.text.toLowerCase()));
        },
        onSelected: widget.onSelected,
        displayStringForOption: widget.displayStringForOption,
        optionsViewBuilder: (context, onSelected, options) => Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: SizedBox(
              child: ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8.0),
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final option = options.elementAt(index);
                  return GestureDetector(
                    onTap: () {
                      onSelected(option);
                    },
                    child: ListTile(
                      title: Text(widget.displayStringForOption.call(option)),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        fieldViewBuilder: (context, textEditingController, focusNode, onFieldSubmitted) => FieldContent(
          decoration: widget.decoration.copyWith(suffixIcon: IconButton(onPressed: textEditingController.clear, icon: const Icon(Icons.close))),
          controller: textEditingController,
          style: widget.style,
          initialValue: widget.initialValue,
          validator: widget.validator,
          focusNode: focusNode,
        ),
      ),
    );
  }
}
