import 'package:caravaggio_ui/src/generics/fonts/fonts.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/subjects.dart';

import 'package:rxdart/rxdart.dart';

/// Controller for managing the state of a checkbox.
class CCheckboxController {
  final BehaviorSubject<bool> _controller;

  /// Constructs a [CCheckboxController] with an optional initial value.
  CCheckboxController({bool? initialValue}) : _controller = BehaviorSubject<bool>.seeded(initialValue ?? false);

  /// Retrieves the current value of the checkbox.
  bool get value => _controller.value;

  /// Retrieves the stream of boolean values representing the state of the checkbox.
  Stream<bool> get stream => _controller.stream;

  /// Listens for changes in the checkbox state.
  void listen(void Function(bool) onData) {
    _controller.listen(onData);
  }

  /// Adds a new value to the checkbox state.
  void add(bool value) {
    _controller.add(value);
  }

  /// Disposes the controller.
  void dispose() {
    _controller.close();
  }
}

/// A stylized checkbox widget.
class CCheckbox extends StatefulWidget {
  /// The initial value of the checkbox.
  final bool? initialValue;

  /// The controller managing the state of the checkbox.
  final CCheckboxController? controller;

  /// Callback function called when the state of the checkbox changes.
  final void Function(bool?)? onChanged;

  /// The label displayed next to the checkbox.
  final String? label;

  /// Creates a [CCheckbox] instance.
  const CCheckbox({
    Key? key,
    this.initialValue,
    this.controller,
    this.onChanged,
    this.label,
  })  : assert(initialValue == null || controller == null),
        super(key: key);

  @override
  State<CCheckbox> createState() => _CCheckboxState();
}

/// The state of a [CCheckbox] widget.
class _CCheckboxState extends State<CCheckbox> {
  bool value = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      value = widget.controller!.value;
      widget.controller!.listen((value) {
        setState(() {
          this.value = value;
        });
      });
    }
    if (widget.initialValue != null) {
      value = widget.initialValue!;
    }
  }

  @override
  void dispose() {
    widget.controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          value: value,
          onChanged: (val) {
            if (widget.controller != null) {
              widget.controller!.add(val!);
            } else {
              setState(() {
                value = val ?? false;
              });
            }
            widget.onChanged?.call(val);
          },
        ),
        if (widget.label != null) Text(widget.label!, style: CaravaggioText.style.labelMedium),
      ],
    );
  }
}
