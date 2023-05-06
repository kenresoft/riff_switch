import 'package:flutter/material.dart';

enum RiffSwitchType { text, icon, image, color }

class RiffSwitch extends StatelessWidget {
  const RiffSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeTrackColor,
    this.activeText = const Text('ON'),
    this.inactiveText = const Text('OFF'),
    this.activeColor,
    this.inactiveTrackColor,
    this.inactiveThumbColor,
    this.trackColor,
    this.thumbColor,
    required this.type,
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

  /// The color of this [Switch]'s thumb.
  ///
  /// Resolved in the following states:
  ///  * [MaterialState.selected].
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  ///  * [MaterialState.disabled].
  ///
  final MaterialStateProperty<Color?>? thumbColor;

  /// The color of this [Switch]'s track.
  ///
  /// Resolved in the following states:
  ///  * [MaterialState.selected].
  ///  * [MaterialState.hovered].
  ///  * [MaterialState.focused].
  ///  * [MaterialState.disabled].
  ///
  final MaterialStateProperty<Color?>? trackColor;

  final RiffSwitchType type;

  RiffSwitchType get _type => type;

  @override
  Widget build(BuildContext context) {
    switch (_type) {
      case RiffSwitchType.text:
        return _buildTextSwitch();
      default:
        return _buildTextSwitch();
    }
  }

  Widget _buildTextSwitch() {
    return _TextSwitch(
      value: value,
      onChanged: onChanged,
      activeTrackColor: activeTrackColor,
      activeText: activeText,
      inactiveText: inactiveText,
      activeColor: activeColor,
      inactiveTrackColor: inactiveTrackColor,
      inactiveThumbColor: inactiveThumbColor,
      trackColor: trackColor,
      thumbColor: thumbColor,
    );
  }
}

/// TEXTSWITCH
class _TextSwitch extends StatefulWidget {
  const _TextSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeTrackColor,
    this.activeText = const Text('ON'),
    this.inactiveText = const Text('OFF'),
    this.activeColor,
    this.inactiveTrackColor,
    this.inactiveThumbColor,
    this.trackColor,
    this.thumbColor,
  }) : super(key: key);

  final bool value;
  final ValueChanged<bool>? onChanged;
  final Color? activeColor;
  final Color? activeTrackColor;
  final Color? inactiveThumbColor;
  final Color? inactiveTrackColor;
  final Text? activeText;
  final Text? inactiveText;
  final MaterialStateProperty<Color?>? thumbColor;
  final MaterialStateProperty<Color?>? trackColor;

  @override
  State<_TextSwitch> createState() => _TextSwitchState();
}

class _TextSwitchState extends State<_TextSwitch> with TickerProviderStateMixin, ToggleableStateMixin {
  late AnimationController _controller;
  late Tween<double> _tween;
  late CurvedAnimation _animation;
  late ColorScheme _colorScheme;
  late double _width;
  final double _horizontalPosition = 0.0;

  @override
  void initState() {
    _controller = AnimationController(duration: const Duration(milliseconds: 80), vsync: this);
    _tween = Tween(begin: 0.9, end: 1.0);
    _animation = CurvedAnimation(parent: _tween.animate(_controller), curve: Curves.easeOutBack);
    super.initState();
  }

  @override
  void didUpdateWidget(_TextSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      // During a drag we may have modified the curve, reset it if its possible
      // to do without visual discontinuation.
      if (widget.value == false || widget.value == true) {
        _onChanged(widget.value);
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  ValueChanged<bool?>? get onChanged => widget.onChanged != null ? _handleChanged : null;

  @override
  bool get tristate => false;

  @override
  bool? get value => widget.value;

  void _handleChanged(bool? value) {
    assert(value != null);
    assert(widget.onChanged != null);
    widget.onChanged?.call(value!);
  }

  MaterialStateProperty<Color?> get _widgetThumbColor {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return widget.inactiveThumbColor;
      }
      if (states.contains(MaterialState.selected)) {
        return widget.activeColor;
      }
      return widget.inactiveThumbColor;
    });
  }

  MaterialStateProperty<Color?> get _widgetTrackColor {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        return widget.activeTrackColor;
      }
      return widget.inactiveTrackColor;
    });
  }

  @override
  Widget build(BuildContext context) {
    _colorScheme = Theme.of(context).colorScheme;

    // [state definitions here to enable change after any form of rebuild.]

    // Colors need to be resolved in selected and non selected states separately
    // so that they can be lerped between. [Reference: Material Switch]
    final Set<MaterialState> activeStates = states..add(MaterialState.selected);
    final Set<MaterialState> inactiveStates = states..remove(MaterialState.selected);

    final Color? activeThumbColor = widget.thumbColor?.resolve(activeStates) ?? _widgetThumbColor.resolve(activeStates) ?? widget.thumbColor?.resolve(activeStates);

    final Color effectiveActiveThumbColor = activeThumbColor ?? widget.thumbColor!.resolve(activeStates)!;

    final Color? inactiveThumbColor = widget.thumbColor?.resolve(inactiveStates) ?? _widgetThumbColor.resolve(inactiveStates) ?? widget.thumbColor?.resolve(inactiveStates);

    final Color effectiveInactiveThumbColor = inactiveThumbColor ?? widget.thumbColor!.resolve(inactiveStates)!;

    final Color effectiveActiveTrackColor = widget.trackColor?.resolve(activeStates) ??
        _widgetTrackColor.resolve(activeStates) ??
        widget.trackColor?.resolve(activeStates) ??
        _widgetThumbColor.resolve(activeStates)?.withAlpha(0x80) ??
        widget.trackColor!.resolve(activeStates)!;

    final Color effectiveInactiveTrackColor = widget.trackColor?.resolve(inactiveStates) ??
        _widgetTrackColor.resolve(inactiveStates) ??
        widget.trackColor?.resolve(inactiveStates) ??
        widget.trackColor!.resolve(inactiveStates)!;

    // Thumb states colors method
    Color activeState({required Color color}) {
      return widget.value ? color : Colors.transparent;
    }

    Color inActiveState({required Color color}) {
      return !widget.value ? color : Colors.transparent;
    }

    // Thumb colors
    Color activeColor() {
      if (widget.thumbColor != null) {
        return activeState(color: effectiveActiveThumbColor);
      } else {
        if (widget.activeColor != null) {
          return activeState(color: widget.activeColor!);
        }
        return activeState(color: _colorScheme.onPrimary);
      }
    }

    Color inactiveColor() {
      if (widget.thumbColor != null) {
        return inActiveState(color: effectiveInactiveThumbColor);
      } else {
        if (widget.inactiveThumbColor != null) {
          return inActiveState(color: widget.inactiveThumbColor!);
        }
        return inActiveState(color: _colorScheme.outline);
      }
    }

    // Track colors
    Color? getTrackColor() {
      if (widget.trackColor != null) {
        if (widget.value) {
          return effectiveActiveTrackColor;
        } else {
          return effectiveInactiveTrackColor;
        }
      } else {
        if (widget.value) {
          if (widget.activeTrackColor != null) {
            return widget.activeTrackColor!;
          }
          if (widget.activeColor != null) {
            return activeColor().withOpacity(0.5);
          }
          return _colorScheme.primary;
        } else {
          if (widget.inactiveTrackColor != null) {
            return widget.inactiveTrackColor!;
          }
          return _colorScheme.surfaceVariant;
        }
      }
    }

    return Semantics(
      toggled: widget.value,
      child: LayoutBuilder(builder: (context, constraint) {
        _width = constraint.maxWidth;
        return Container(
          width: _width,
          decoration: BoxDecoration(color: getTrackColor(), borderRadius: BorderRadius.circular(25)),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            AnimatedBuilder(
              builder: (context, child) {
                return FractionalTranslation(
                  translation: Offset(!value! ? 1 - _animation.value : 0, 0),
                  child: child,
                );
              },
              animation: _animation,
              child: FractionalTranslation(
                translation: Offset(_horizontalPosition, 0),
                child: GestureDetector(
                  excludeFromSemantics: true,
                  onTap: () => _onChanged(false),
                  child: _getChild(inactiveColor(), _width, widget.inactiveText!),
                ),
              ),
              //),
            ),
            AnimatedBuilder(
              builder: (context, child) {
                return FractionalTranslation(
                  translation: Offset(widget.value ? _animation.value - 1 : 0, 0),
                  child: child,
                );
              },
              animation: _animation,
              child: FractionalTranslation(
                translation: Offset(_horizontalPosition, 0),
                child: GestureDetector(
                  excludeFromSemantics: true,
                  onTap: () => _onChanged(true),
                  child: _getChild(activeColor(), _width, widget.activeText!),
                ),
              ),
            )
          ]),
        );
      }),
    );
  }

  Widget _getChild(Color color, double width, Text? child) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(25),
      ),
      width: width / 2,
      height: 50,
      child: Material(color: Colors.transparent, child: child),
    );
  }

  void _onChanged(bool value) {
    onChanged!(value);
    _controller.reset();
    _controller.forward().whenComplete(() {
      _controller.stop();
    });
  }
}
