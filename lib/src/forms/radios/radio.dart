import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

/// Enumeration defining the orientation of a CRadioGroup.
enum CRadioGroupOrientation {
  /// Displays the radio buttons vertically.
  vertical,

  /// Displays the radio buttons horizontally.
  horizontal
}

/// Enumeration defining the cross axis alignment for a CRadioGroup.
enum CRadioCrossAxisAlignment {
  /// Aligns the radio buttons at the start of the cross axis.
  start,

  /// Aligns the radio buttons at the center of the cross axis.
  center,

  /// Aligns the radio buttons at the end of the cross axis.
  end;

  /// Returns the equivalent CrossAxisAlignment value.
  CrossAxisAlignment get value {
    switch (this) {
      case CRadioCrossAxisAlignment.start:
        return CrossAxisAlignment.start;
      case CRadioCrossAxisAlignment.center:
        return CrossAxisAlignment.center;
      case CRadioCrossAxisAlignment.end:
        return CrossAxisAlignment.end;
    }
  }

  /// Returns the equivalent WrapAlignment value.
  WrapAlignment get wrapValue {
    switch (this) {
      case CRadioCrossAxisAlignment.start:
        return WrapAlignment.start;
      case CRadioCrossAxisAlignment.center:
        return WrapAlignment.center;
      case CRadioCrossAxisAlignment.end:
        return WrapAlignment.end;
    }
  }
}

/// Represents an item for a radio button.
class CRadioItem<T> {
  /// The value associated with the radio item.
  final T value;

  /// The label text of the radio item.
  final String label;

  /// Creates a [CRadioItem] with the provided [value] and [label].
  const CRadioItem({
    required this.value,
    required this.label,
  });

  /// Creates a copy of this [CRadioItem] with the provided values.
  CRadioItem<T> copyWith({
    T? value,
    String? label,
  }) {
    return CRadioItem<T>(
      value: value ?? this.value,
      label: label ?? this.label,
    );
  }
}

/// Controller for managing the state of a radio.
class CRadioController<T> {
  final BehaviorSubject<T?> _controller;

  /// Constructs a [CRadioController] with an optional initial value.
  CRadioController({T? initialValue}) : _controller = BehaviorSubject<T?>.seeded(initialValue);

  /// Retrieves the current value of the radio.
  T? get value => _controller.value;

  /// Retrieves the stream of boolean values representing the state of the radio.
  Stream<T?> get stream => _controller.stream;

  /// Listens for changes in the radio state.
  void listen(void Function(T?) onData) {
    _controller.listen(onData);
  }

  /// Adds a new value to the radio state.
  void add(T value) {
    _controller.add(value);
  }

  /// Disposes the controller.
  void dispose() {
    _controller.close();
  }
}

/// A group of radio buttons allowing selection from a list of values.
class CRadioGroup<T> extends StatefulWidget {
  /// The list of radio items.
  final List<CRadioItem<T>> values;

  /// The callback function called when the selection changes.
  final void Function(T?)? onChanged;

  /// The initial value of the radio group.
  final T? initialValue;

  /// The controller managing the state of the radio group.
  final CRadioController<T?>? controller;

  /// The orientation of the radio group.
  final CRadioGroupOrientation orientation;

  /// The alignment of the radio buttons along the cross axis.
  final CRadioCrossAxisAlignment crossAxisAlignment;

  /// Creates a [CRadioGroup] widget.
  const CRadioGroup({
    Key? key,
    required this.values,
    this.onChanged,
    this.initialValue,
    this.controller,
    this.orientation = CRadioGroupOrientation.vertical,
    this.crossAxisAlignment = CRadioCrossAxisAlignment.start,
  })  : assert(initialValue != null || controller != null, 'initialValue or controller must be provided'),
        super(key: key);

  @override
  State<CRadioGroup> createState() => _CRadioGroupState<T>();
}

class _CRadioGroupState<T> extends State<CRadioGroup<T>> {
  T? _selectedItem;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _selectedItem = widget.controller!.value;
      widget.controller!.listen((value) {
        setState(() {
          _selectedItem = value;
        });
      });
    }
    if (widget.initialValue != null) {
      _selectedItem = widget.initialValue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.orientation == CRadioGroupOrientation.vertical
        ? Column(
            crossAxisAlignment: widget.crossAxisAlignment.value,
            children: _buildRadioButtons(),
          )
        : Wrap(
            alignment: widget.crossAxisAlignment.wrapValue,
            children: _buildRadioButtons(),
          );
  }

  List<_CRadioButton<T>> _buildRadioButtons() {
    return widget.values.map((item) {
      return _CRadioButton<T>(
        item: item,
        itemSelected: _selectedItem,
        onChanged: (T? value) {
          widget.controller != null
              ? widget.controller!.add(value)
              : setState(() {
                  _selectedItem = value;
                });
          widget.onChanged?.call(value);
        },
      );
    }).toList();
  }
}

/// A custom radio button widget for displaying radio options.
class _CRadioButton<T> extends StatelessWidget {
  /// The radio item to display.
  final CRadioItem<T> item;

  /// The currently selected item.
  final T? itemSelected;

  /// Callback function for when the radio button is changed.
  final void Function(T?)? onChanged;

  /// Creates a [_CRadioButton] widget.
  const _CRadioButton({
    Key? key,
    required this.item,
    this.itemSelected,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<T>(
          value: item.value,
          groupValue: itemSelected,
          onChanged: onChanged,
        ),
        Text(item.label),
      ],
    );
  }
}
