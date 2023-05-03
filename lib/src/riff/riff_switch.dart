import 'dart:developer';

import 'package:flutter/material.dart';

enum RiffSwitchType { text }

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

  final MaterialStateProperty<Color?>? thumbColor;

  final MaterialStateProperty<Color?>? trackColor;

  final RiffSwitchType type;

  RiffSwitchType get _type => type;

  @override
  Widget build(BuildContext context) {
    switch (_type) {
      case RiffSwitchType.text:
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
  late AnimationController controller;
  late Tween<double> tween;
  late CurvedAnimation animation;
  late ColorScheme colorScheme;

  late double width;
  double horizontalPosition = 0.0;

  @override
  void initState() {
    controller = AnimationController(duration: const Duration(milliseconds: 80), vsync: this);
    tween = Tween(begin: 0.9, end: 1.0);
    animation = CurvedAnimation(parent: tween.animate(controller), curve: Curves.easeOutBack);
    super.initState();
  }

  @override
  void didUpdateWidget(_TextSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      // During a drag we may have modified the curve, reset it if its possible
      // to do without visual discontinuation.
      if (widget.value == false || widget.value == true) {
        /// TODO
      }
      //animateToValue();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  ValueChanged<bool?>? get onChanged => widget.onChanged != null ? _handleChanged : null;

  @override
  bool get tristate => false;

  @override
  bool? get value => widget.value;

  void _handleDragStart(DragStartDetails details) {
    if (isInteractive) {
      reactionController.forward();
    }
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (isInteractive) {
      /*position
        ..curve = Curves.linear
        ..reverseCurve = null;*/
      final double delta = details.primaryDelta!;
      log(delta.toString());

      /*switch (Directionality.of(context)) {
        case TextDirection.rtl:
          positionController.value -= delta;
          break;
        case TextDirection.ltr:
          positionController.value += delta;
          break;
      }*/
    }
  }

  bool _needsPositionAnimation = false;

  void _handleDragEnd(DragEndDetails details) {
    if (position.value >= 0.5 != widget.value) {
      widget.onChanged?.call(!widget.value);
      // Wait with finishing the animation until widget.value has changed to
      // !widget.value as part of the widget.onChanged call above.
      setState(() {
        _needsPositionAnimation = true;
      });
    } else {
      animateToValue();
    }
    reactionController.reverse();
  }

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
    colorScheme = Theme.of(context).colorScheme;

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
        return activeState(color: colorScheme.onPrimary);
      }
    }

    Color inactiveColor() {
      if (widget.thumbColor != null) {
        return inActiveState(color: effectiveInactiveThumbColor);
      } else {
        if (widget.inactiveThumbColor != null) {
          return inActiveState(color: widget.inactiveThumbColor!);
        }
        return inActiveState(color: colorScheme.outline);
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
          return colorScheme.primary;
        } else {
          if (widget.inactiveTrackColor != null) {
            return widget.inactiveTrackColor!;
          }
          return colorScheme.surfaceVariant;
        }
      }
    }

    return Semantics(
      toggled: widget.value,
      child: LayoutBuilder(builder: (context, constraint) {
        width = constraint.maxWidth;
        return Container(
          width: 100,
          decoration: BoxDecoration(color: getTrackColor(), borderRadius: BorderRadius.circular(25)),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            AnimatedBuilder(
              builder: (context, child) {
                return FractionalTranslation(
                  translation: Offset(!value! ? 1 - animation.value : 0, 0),
                  child: child,
                );
              },
              animation: animation,
              child: FractionalTranslation(
                translation: Offset(horizontalPosition, 0),
                child: GestureDetector(
                  excludeFromSemantics: true,
                  onTap: () => _onChanged(false),
                  onHorizontalDragStart: (_) => horizontalPosition = 0,
                  onHorizontalDragUpdate: (dragUpdateDetails) => _onHorizontalDragUpdate(dragUpdateDetails),
                  onHorizontalDragEnd: (_) => _onHorizontalDragEnd(),
                  child: _getChild(inactiveColor(), width, widget.inactiveText!),
                ),
              ),
              //),
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
              child: FractionalTranslation(
                translation: Offset(horizontalPosition, 0),
                child: GestureDetector(
                  excludeFromSemantics: true,
                  onTap: () => _onChanged(true),
                  onHorizontalDragStart: (_) => horizontalPosition = 0,
                  onHorizontalDragUpdate: (dragUpdateDetails) => _onHorizontalDragUpdate(dragUpdateDetails),
                  onHorizontalDragEnd: (_) => _onHorizontalDragEnd(),
                  child: _getChild(activeColor(), width, widget.activeText!),
                ),
              ),
            )
          ]),
        );
      }),
    );
  }

  void _onHorizontalDragUpdate(DragUpdateDetails dragUpdateDetails) {
    setState(() {
      horizontalPosition = _horizontalPosition(dragUpdateDetails);
    });
    log("horizontalPosition: $horizontalPosition");
  }

  void _onHorizontalDragEnd() {
    if (widget.value) {
      if (horizontalPosition == -1) {
        horizontalPosition = 0;
      }
      widget.onChanged?.call(false);
    }

    if (!widget.value) {
      if (horizontalPosition == 1) {
        horizontalPosition = 0;
      }
      widget.onChanged?.call(true);
    }
  }

  double _horizontalPosition(DragUpdateDetails dragUpdateDetails) {
    if (widget.value) {
      double delta = (dragUpdateDetails.localPosition.dx - 1 / width) - 1;
      if (delta > 0) {
        return 0;
      }
      if (delta < -1) {
        return -1;
      }
      return delta;
    } else {
      double delta = (dragUpdateDetails.localPosition.dx / width);
      if (delta < 0) {
        return 0;
      }
      if (delta > 1) {
        return 1;
      }
      return delta;
    }
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

  /*
  * feedbackOffset: Offset(position, 0),
      hitTestBehavior: HitTestBehavior.translucent,
      feedback: Container(color: Colors.green, width: width),
      childWhenDragging: SizedBox(width: width / 2) /*Container(color: Colors.yellow, width: width/2, height: 50,)*/,
      onDragUpdate: (details) {
        position = details.delta.dx;
        log(position.toString());
      },
      onDragEnd: (details) {
        if (details.offset.dx > width || details.offset.dx < 0) {
          //position = width / 2;
        }
      },
      axis: Axis.horizontal,
  * */

  void _onChanged(bool value) {
    onChanged!(value);
    controller.reset();
    controller.forward().whenComplete(() {
      controller.stop();
    });
  }

/*Color? get _getTrackColor {
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
  }*/

/*Color get _inactiveColor {
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
  }*/
}