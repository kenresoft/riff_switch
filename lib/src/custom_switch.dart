import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeTrackColor,
    this.activeText = const Text('ON'),
    this.inactiveText = const Text('OFF'),
    this.activeColor,
    this.inactiveTrackColor,
    this.inactiveThumbColor,
  }) : super(key: key);

  /// Whether this switch is on or off.
  ///
  /// This property must not be null.
  final bool value;

  /// Called when the user toggles the switch on or off.
  ///
  /// The switch passes the new value to the callback but does not actually
  /// change state until the parent widget rebuilds the switch with the new
  /// value.
  ///
  /// If null, the switch will be displayed as disabled.
  ///
  /// The callback provided to [onChanged] should update the state of the parent
  /// [StatefulWidget] using the [State.setState] method, so that the parent
  /// gets rebuilt; for example:
  ///
  /// ```dart
  /// RiffSwitch(
  ///   value: _toggle,
  ///   onChanged: (bool newValue) {
  ///     setState(() {
  ///       _toggle = newValue;
  ///     });
  ///   },
  /// )
  /// ```
  final ValueChanged<bool>? onChanged;

  /// The color to use when this switch is on.
  ///
  /// Defaults to [ColorScheme.onPrimary].
  final Color? activeColor;

  /// The color to use on the track when this switch is on.
  ///
  /// Defaults to [ColorScheme.onPrimary] with the opacity set at 50%.
  final Color? activeTrackColor;

  /// The color to use on the thumb when this switch is off.
  ///
  /// Defaults to the colors described in the Material design specification.
  final Color? inactiveThumbColor;

  /// The color to use on the track when this switch is off.
  ///
  /// Defaults to the colors described in the Material design specification.
  final Color? inactiveTrackColor;

  /// The text widget acting as the thumb when this switch is on.
  ///
  /// Defaults to [const Text("ON")].
  final Text? activeText;

  /// The text widget acting as the thumb when this switch is off.
  ///
  /// Defaults to [const Text("OFF")].
  final Text? inactiveText;

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Tween<double> tween;
  late CurvedAnimation animation;
  late ColorScheme colorScheme;

  @override
  void initState() {
    controller = AnimationController(duration: const Duration(milliseconds: 80), vsync: this);
    tween = Tween(begin: 0.9, end: 1.0);
    animation = CurvedAnimation(parent: tween.animate(controller), curve: Curves.easeOutBack);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    colorScheme = Theme.of(context).colorScheme;
    return LayoutBuilder(builder: (context, constraint) {
      var width = constraint.maxWidth;
      return Container(
        width: width,
        decoration: BoxDecoration(color: _getTrackColor, borderRadius: BorderRadius.circular(25)),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          AnimatedBuilder(
            builder: (context, child) {
              return FractionalTranslation(
                translation: Offset(!widget.value ? 1 - animation.value : 0, 0),
                child: child,
              );
            },
            animation: animation,
            child: Draggable(
              feedback: _getChild(_inactiveColor, width, widget.inactiveText!),
              childWhenDragging: const SizedBox(),
              axis: Axis.horizontal,
              child: GestureDetector(
                onTap: () => _onChanged(false),
                child: _getChild(_inactiveColor, width, widget.inactiveText!),
              ),
            ),
          ),
          AnimatedBuilder(
            builder: (context, child) {
              return FractionalTranslation(
                //opacity: !widget.value ? animation.value : 1,
                translation: Offset(widget.value ? animation.value - 1 : 0, 0),
                child: child,
              );
            },
            animation: animation,
            child: Draggable(
              feedback: _getChild(_inactiveColor, width, widget.inactiveText!),
              childWhenDragging: const SizedBox(),
              axis: Axis.horizontal,
              child: GestureDetector(
                onTap: () => _onChanged(true),
                child: _getChild(_activeColor, width, widget.activeText!),
              ),
            ),
          ),
        ]),
      );
    });
  }

  Container _getChild(Color color, double width, Text child) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      width: width / 2,
      height: 50,
      child: child,
    );
  }

  void _onChanged(bool value) {
    widget.onChanged!(value);
    controller.reset();
    controller.forward().whenComplete(() {
      controller.stop();
    });
  }

  Color? get _getTrackColor {
    if (widget.value) {
      if (widget.activeTrackColor != null) {
        return widget.activeTrackColor!;
      }
      if (widget.activeColor != null) {
        return _activeColor.withOpacity(0.5);
      }
      return colorScheme.primary;
    } else {
      if (widget.inactiveTrackColor != null) {
        return widget.inactiveTrackColor!;
      }
      return colorScheme.surfaceVariant;
    }
  }

  Color get _inactiveColor {
    if (widget.inactiveThumbColor != null) {
      return inActiveState(color: widget.inactiveThumbColor!);
    }
    return inActiveState(color: colorScheme.outline);
  }

  Color get _activeColor {
    if (widget.activeColor != null) {
      return activeState(color: widget.activeColor!);
    }
    return activeState(color: colorScheme.onPrimary);
  }

  Color inActiveState({required Color color}) {
    return !widget.value ? color : Colors.transparent;
  }

  Color activeState({required Color color}) {
    return widget.value ? color : Colors.transparent;
  }
}
