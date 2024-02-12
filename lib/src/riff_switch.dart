library;

import 'package:extensionresoft/extensionresoft.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// Enum representing the types of RiffSwitch.
enum RiffSwitchType { simple, decorative }

/// Enum representing the types of content within RiffSwitch (text, icon, image, color).
enum Type { text, icon, image, color }

/// A Flutter widget representing a custom switch with advanced features.
/// RiffSwitch widget allows users to toggle between two states (ON and OFF) with customizable appearance.
class RiffSwitch extends StatelessWidget {
  const RiffSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.height = 30,
    this.width = 150,
    this.borderWidth = 0,
    this.borderRadius = 25,
    this.borderColor = Colors.blue,
    this.thumbMargin = 0,
    this.elevation = 0,
    this.animateToggle = false,
    this.activeTrackColor,
    this.activeText = const Text('ON'),
    this.inactiveText = const Text('OFF'),
    this.activeChild = const Card(color: Colors.black87),
    this.inactiveChild = const Card(color: Colors.black38),
    this.activeColor,
    this.inactiveTrackColor,
    this.inactiveThumbColor,
    this.trackColor,
    this.thumbColor,
    required this.type,
    this.enableSlide = true,
  }) /*assert(height! <= width! / 2, '\n\nHeight must not be greater than half of the width. \nYour supplied height is: $height and width is: $width\n')*/;

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

  /// The height of the switch.
  ///
  /// This value must be less than or equal to half of the width of the switch.
  /// If not provided, a default height of 50.0 will be used.
  final double? height;

  /// The width of the switch.
  ///
  /// If not provided, the width will be calculated based on the constraints.
  final double? width;

  /// The width of the border around the switch.
  ///
  /// If not provided, the switch will have no border.
  final double? borderWidth;

  /// The radius of the switch corners.
  ///
  /// If not provided, a default radius of 25.0 will be used.
  final double? borderRadius;

  /// The color of the border around the switch.
  ///
  /// If not provided, the switch will have no border color.
  final Color? borderColor;

  final double? thumbMargin;
  final double? elevation;
  final bool? animateToggle;

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

  /// The custom widget acting as the thumb when this switch is on.
  ///
  /// Defaults to [const Text("Active")].
  final Widget? activeChild;

  /// The custom widget acting as the thumb when this switch is off.
  ///
  /// Defaults to [const Text("Inactive")].
  final Widget? inactiveChild;

  /// The color of this [Switch]'s thumb.
  ///
  /// Resolved in the following states:
  ///  * [MaterialState.selected].
  //  * [MaterialState.hovered].
  //  * [MaterialState.focused].
  ///  * [MaterialState.disabled].
  ///
  /// *sample implementation*
  /// ```
  /// MaterialStateProperty.resolveWith((Set<MaterialState> states) {
  ///   if (states.contains(MaterialState.disabled)) {
  ///    return Colors.blue;
  ///   }
  ///   if (states.contains(MaterialState.selected)) {
  ///     return Colors.orange;
  ///   }
  ///   return Colors.pinkAccent;
  /// });
  /// ```

  final MaterialStateProperty<Color?>? thumbColor;

  /// The color of this [Switch]'s track.
  ///
  /// Resolved in the following states:
  ///  * [MaterialState.selected].
  //  * [MaterialState.hovered].
  //  * [MaterialState.focused].
  ///  * [MaterialState.disabled].
  ///
  /// *sample implementation*
  /// ```
  /// MaterialStateProperty.resolveWith((Set<MaterialState> states) {
  ///   if (states.contains(MaterialState.disabled)) {
  ///    return Colors.grey;
  ///   }
  ///   if (states.contains(MaterialState.selected)) {
  ///     return Colors.white70;
  ///   }
  ///   return Colors.green;
  /// });
  /// ```

  final MaterialStateProperty<Color?>? trackColor;

  /// The type of the RiffSwitch.
  ///
  /// Defaults to `Type.text`.
  ///
  /// See also:
  /// * [Type], which contains the set of types available.
  final RiffSwitchType type;

  /// Determines whether the slider is slideable or not.
  ///
  /// Defaults to `true`.
  final bool? enableSlide;

  /// Returns the appropriate RiffSwitchType based on the specified type.
  RiffSwitchType get _type => type;

  @override
  Widget build(BuildContext context) {
    // Dart 2
    /*switch (_type) {
      case RiffSwitchType.simple:
        return _buildSimpleSwitch();
      case RiffSwitchType.decorative:
        return _buildDecorativeSwitch();
      default:
        return _buildSimpleSwitch();
    }*/

    // Using Dart 3 Pattern
    return switch (this) {
      RiffSwitch(_type: RiffSwitchType.simple) => _buildSimpleSwitch(),
      RiffSwitch(_type: RiffSwitchType.decorative) => _buildDecorativeSwitch(),
    };
  }

  Widget _buildSimpleSwitch() {
    return _SimpleSwitch(
      value: value,
      onChanged: onChanged,
      height: height,
      width: width,
      activeTrackColor: activeTrackColor,
      activeText: activeText,
      inactiveText: inactiveText,
      activeColor: activeColor,
      inactiveTrackColor: inactiveTrackColor,
      inactiveThumbColor: inactiveThumbColor,
      trackColor: trackColor,
      thumbColor: thumbColor,
      enableSlide: enableSlide,
    );
  }

  Widget _buildDecorativeSwitch() {
    return _SimpleSwitch.decorative(
      value: value,
      onChanged: onChanged,
      height: height,
      width: width,
      borderWidth: borderWidth,
      borderRadius: borderRadius,
      borderColor: borderColor,
      thumbMargin: thumbMargin,
      elevation: elevation,
      animateToggle: animateToggle,
      activeTrackColor: activeTrackColor,
      activeChild: activeChild,
      inactiveChild: inactiveChild,
      activeColor: activeColor,
      inactiveTrackColor: inactiveTrackColor,
      inactiveThumbColor: inactiveThumbColor,
      trackColor: trackColor,
      thumbColor: thumbColor,
      enableSlide: enableSlide,
    );
  }
}

/// Internal implementation of the simple RiffSwitch.
class _SimpleSwitch extends StatefulWidget {
  const _SimpleSwitch({
    required this.value,
    required this.onChanged,
    this.height,
    this.width,
    this.trackColor,
    this.thumbColor,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.inactiveThumbColor,
    this.activeText = const Text('ON'),
    this.inactiveText = const Text('OFF'),
    this.enableSlide,
  })  : borderWidth = 0,
        borderRadius = 25,
        borderColor = Colors.blue,
        thumbMargin = 0,
        animateToggle = false,
        elevation = 0,
        activeChild = null,
        inactiveChild = null,
        type = RiffSwitchType.simple;

  /// Creates a decorative RiffSwitch.
  const _SimpleSwitch.decorative({
    required this.value,
    required this.onChanged,
    this.height,
    this.width = double.infinity,
    this.borderWidth = 3,
    this.borderRadius = 25,
    this.borderColor = Colors.blue,
    this.thumbMargin = 0,
    this.elevation = 0,
    this.animateToggle = false,
    this.trackColor,
    this.thumbColor,
    this.activeColor,
    this.activeTrackColor,
    this.inactiveTrackColor,
    this.inactiveThumbColor,
    this.activeChild,
    this.inactiveChild,
    this.enableSlide,
  })  : activeText = null,
        inactiveText = null,
        type = RiffSwitchType.decorative;

  final bool value;
  final ValueChanged<bool>? onChanged;
  final double? height;
  final double? width;
  final double? borderWidth;
  final double? borderRadius;
  final Color? borderColor;
  final double? thumbMargin;
  final double? elevation;
  final bool? animateToggle;
  final Color? activeColor;
  final Color? activeTrackColor;
  final Color? inactiveThumbColor;
  final Color? inactiveTrackColor;
  final Text? activeText;
  final Text? inactiveText;
  final Widget? activeChild;
  final Widget? inactiveChild;
  final MaterialStateProperty<Color?>? thumbColor;
  final MaterialStateProperty<Color?>? trackColor;
  final RiffSwitchType type;
  final bool? enableSlide;

  @override
  State<_SimpleSwitch> createState() => _SimpleSwitchState();
}

class _SimpleSwitchState extends State<_SimpleSwitch> with TickerProviderStateMixin, ToggleableStateMixin {
  late AnimationController _controller;
  late Tween<double> _tween;
  late CurvedAnimation _animation;
  double _horizontalPosition = 0.0;
  bool _onDragLeft = false;
  bool _onDragRight = false;

  /// Initializes the state of the _SimpleSwitch.
  @override
  void initState() {
    _controller = AnimationController(duration: const Duration(milliseconds: 80), vsync: this);
    _tween = Tween(begin: 0.9, end: 1.0);
    _animation = CurvedAnimation(parent: _tween.animate(_controller), curve: Curves.easeOutBack);
    _controller.forward(from: 1.0);
    super.initState();
  }

  @override
  void didUpdateWidget(_SimpleSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      // During a drag we may have modified the curve, reset it if its possible
      // to do without visual discontinuation.

      /*if (widget.value == false || widget.value == true) {
        _onChanged(widget.value);
      }*/
    }
  }

  /// Disposes resources when the state is no longer needed.
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
    final ThemeData theme = Theme.of(context);
    final SwitchThemeData switchTheme = SwitchTheme.of(context);
    final SwitchThemeData defaults = _SwitchDefaultsM3(context);

    // Colors need to be resolved in selected and non selected states separately
    // so that they can be lerped between. [Reference: Material Switch]
    final Set<MaterialState> activeStates = states..add(MaterialState.selected);
    final Set<MaterialState> inactiveStates = states..remove(MaterialState.selected);

    final Color? activeThumbColor = widget.thumbColor?.resolve(activeStates) ?? _widgetThumbColor.resolve(activeStates) ?? switchTheme.thumbColor?.resolve(activeStates);

    final Color effectiveActiveThumbColor = activeThumbColor ?? defaults.thumbColor!.resolve(activeStates)!;

    final Color? inactiveThumbColor = widget.thumbColor?.resolve(inactiveStates) ?? _widgetThumbColor.resolve(inactiveStates) ?? switchTheme.thumbColor?.resolve(inactiveStates);

    final Color effectiveInactiveThumbColor = inactiveThumbColor ?? defaults.thumbColor!.resolve(inactiveStates)!;

    final Color effectiveActiveTrackColor = widget.trackColor?.resolve(activeStates) ??
        _widgetTrackColor.resolve(activeStates) ??
        switchTheme.trackColor?.resolve(activeStates) ??
        _widgetThumbColor.resolve(activeStates)?.withAlpha(0x80) ??
        defaults.trackColor!.resolve(activeStates)!;

    final Color effectiveInactiveTrackColor =
        widget.trackColor?.resolve(inactiveStates) ?? _widgetTrackColor.resolve(inactiveStates) ?? switchTheme.trackColor?.resolve(inactiveStates) ?? defaults.trackColor!.resolve(inactiveStates)!;

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
        return activeState(color: theme.colorScheme.onPrimary);
      }
    }

    Color inactiveColor() {
      if (widget.thumbColor != null) {
        return inActiveState(color: effectiveInactiveThumbColor);
      } else {
        if (widget.inactiveThumbColor != null) {
          return inActiveState(color: widget.inactiveThumbColor!);
        }
        return inActiveState(color: theme.colorScheme.outline);
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
          return theme.colorScheme.primary;
        } else {
          if (widget.inactiveTrackColor != null) {
            return widget.inactiveTrackColor!;
          }
          return theme.colorScheme.surfaceVariant;
        }
      }
    }

    return condition(
      widget.enableSlide!,
      buildSlidableSwitch(
        getTrackColor,
        inactiveColor,
        activeColor,
      ),
      buildNonSlidableSwitch(
        getTrackColor,
        inactiveColor,
        activeColor,
      ),
    );
  }

  Semantics buildNonSlidableSwitch(Color? Function() getTrackColor, Color Function() inactiveColor, Color Function() activeColor) {
    return Semantics(
      toggled: widget.value,
      child: LayoutBuilder(builder: (context, constraint) {
        // Calculate the available width for the switch.
        var width = widget.width!;
        width = condition(width > constraint.maxWidth, constraint.maxWidth, width);

        // Calculate the available height for the switch.
        var height = widget.height!;

        var borderWidth = widget.borderWidth!;
        borderWidth = condition(borderWidth > 5, 5, borderWidth);

        var thumbMargin = widget.thumbMargin!;
        thumbMargin = condition(thumbMargin > (5 + height / 2), height / 8, thumbMargin);

        var borderColor = widget.borderColor!;

        // Ensure height is not greater than half of the width
        if (height != double.infinity) {
          assert(height <= width / 2, '\n\nHeight must not be greater than half of the width. \nYour supplied height is: $height and width is: $width\n');
        }

        return UnconstrainedBox(
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: borderColor,
              border: Border.all(width: borderWidth, color: borderColor),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 25),
            ),
            child: Container(
              width: width - (thumbMargin * 2) - (borderWidth * 2),
              height: height - (thumbMargin * 2) - (borderWidth * 2),
              decoration: BoxDecoration(
                color: getTrackColor(),
                //border: Border.all(width: borderWidth, color: borderColor),
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 25),
              ),
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
                      child: _getChild(
                        value,
                        inactiveColor(),
                        width - (thumbMargin * 2) - (borderWidth * 2),
                        height - (thumbMargin * 2) - (borderWidth * 2),
                        RiffSwitchChild(isActiveChild: false, child: _inactiveChild),
                      ),
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
                      child: _getChild(
                        value,
                        activeColor(),
                        width - (thumbMargin * 2) - (borderWidth * 2),
                        height - (thumbMargin * 2) - (borderWidth * 2),
                        RiffSwitchChild(isActiveChild: true, child: _activeChild),
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ),
        );
      }),
    );
  }

  Semantics buildSlidableSwitch(Color? Function() getTrackColor, Color Function() inactiveColor, Color Function() activeColor) {
    return Semantics(
      toggled: widget.value,
      child: LayoutBuilder(builder: (context, constraint) {
        // Calculate the available width for the switch.
        var width = widget.width!;
        width = condition(width > constraint.maxWidth, constraint.maxWidth, width);

        // Calculate the available height for the switch.
        var height = widget.height!;

        var borderWidth = widget.borderWidth!;
        borderWidth = condition(borderWidth > 5, 5, borderWidth);

        var thumbMargin = widget.thumbMargin!;
        thumbMargin = condition(thumbMargin > (5 + height / 2), height / 8, thumbMargin);

        var borderColor = widget.borderColor!;

        // Ensure height is not greater than half of the width
        if (height != double.infinity) {
          assert(height <= width / 2, '\n\nHeight must not be greater than half of the width. \nYour supplied height is: $height and width is: $width\n');
        }

        debugPrint(width.toString());
        return UnconstrainedBox(
          child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: borderColor,
              border: Border.all(width: borderWidth, color: borderColor),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 25),
            ),
            child: Container(
              width: width - (thumbMargin * 2) - (borderWidth * 2),
              height: height - (thumbMargin * 2) - (borderWidth * 2),
              decoration: BoxDecoration(
                color: getTrackColor(),
                //border: Border.all(width: borderWidth, color: borderColor),
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 25),
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                // Left side of the switch (OFF state).
                GestureDetector(
                  excludeFromSemantics: true,
                  onTap: () {
                    // Handle tap to turn OFF.
                    setState(() {
                      _onChanged(false);
                      _horizontalPosition = 0;
                    });
                  },
                  onHorizontalDragUpdate: (details) {
                    // Update the x-axis position within the constrained area
                    // Handle horizontal drag to update position (OFF state).
                    setState(() {
                      if (!widget.value) {
                        //width = context.size?.width ?? width;
                        _horizontalPosition += details.primaryDelta! / width;
                        _horizontalPosition = _horizontalPosition.clamp(0.0, 1.0);
                        _onDragLeft = _horizontalPosition <= 0 ? false : true;
                      }
                    });
                  },
                  onHorizontalDragEnd: (details) {
                    // Snap the switch to the on/off position when dragging ends
                    // Handle drag end to snap the switch to the desired position (OFF state).
                    setState(() {
                      _onChanged(_horizontalPosition > 0.6);
                      _onDragLeft = false;
                    });
                  },
                  child: AnimatedBuilder(
                    builder: (context, child) {
                      // Animate the transition of the switch thumb based on drag or tap.
                      return FractionalTranslation(
                        translation: Offset(
                            condition(
                              !widget.value,
                              (_onDragLeft ? _horizontalPosition : 1 - _animation.value),
                              0,
                            ),
                            0),
                        child: child,
                      );
                    },
                    animation: _animation,
                    child: _getChild(
                      value,
                      !value! ? inactiveColor() : Colors.transparent,
                      width - (thumbMargin * 2) - (borderWidth * 2),
                      height - (thumbMargin * 2) - (borderWidth * 2),
                      _onDragRight ? const SizedBox() : condition(!value!, _inactiveChild, const SizedBox()) /*RiffSwitchChild(isActiveChild: false, child: _inactiveChild)*/,
                    ),
                  ),
                ),
                // Right side of the switch (ON state).
                GestureDetector(
                  excludeFromSemantics: true,
                  onTap: () {
                    // Handle tap to turn ON.
                    setState(() {
                      _onChanged(true);
                      _horizontalPosition = 1;
                    });
                  },
                  onHorizontalDragUpdate: (details) {
                    // Update the x-axis position within the constrained area
                    // Handle horizontal drag to update position (ON state).
                    setState(() {
                      if (widget.value) {
                        //width = context.size?.width ?? width;
                        _horizontalPosition += details.primaryDelta! / width;
                        _horizontalPosition = _horizontalPosition.clamp(0.0, 1.0);
                        _onDragRight = _horizontalPosition >= 1 ? false : true;
                      }
                    });
                  },
                  onHorizontalDragEnd: (details) {
                    // Snap the switch to the on/off position when dragging ends
                    // Handle drag end to snap the switch to the desired position (ON state).
                    setState(() {
                      _onChanged(_horizontalPosition > 0.4);
                      _onDragRight = false;
                    });
                  },
                  child: AnimatedBuilder(
                    builder: (context, child) {
                      // Animate the transition of the switch thumb based on drag or tap.
                      return FractionalTranslation(
                        translation: Offset(
                            condition(
                              widget.value,
                              (_onDragRight ? _horizontalPosition : _animation.value) - 1,
                              0,
                            ),
                            0),
                        child: child,
                      );
                    },
                    animation: _animation,
                    child: _getChild(
                      value,
                      value! ? activeColor() : Colors.transparent,
                      width - (thumbMargin * 2) - (borderWidth * 2),
                      height - (thumbMargin * 2) - (borderWidth * 2),
                      _onDragLeft ? const SizedBox() : condition(value!, _activeChild, const SizedBox()),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        );
      }),
    );
  }

  Widget get _activeChild {
    return widget.type == RiffSwitchType.simple ? widget.activeText! : RiffSwitchChild(isActiveChild: true, child: widget.activeChild!);
  }

  Widget get _inactiveChild {
    return widget.type == RiffSwitchType.simple ? widget.inactiveText! : RiffSwitchChild(isActiveChild: true, child: widget.inactiveChild!);
  }

  Widget _getChild(bool? value, Color color, double width, double height, Widget riffSwitchChild) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(widget.borderRadius!),
        //borderRadius: BorderRadius.horizontal(left: Radius.circular(widget.borderRadius ?? 25), right: Radius.circular(widget.borderRadius!),),
      ),
      width: width / 2,
      height: height,
      child: Material(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius!),
          child: ColorFiltered(
            colorFilter: ColorFilter.mode(color, BlendMode.color),
            child: riffSwitchChild,
          ),
        ),
      ),
    );
  }

  void _onChanged(bool value) {
    onChanged!(value);
    _controller.reset();
    _controller.forward().whenComplete(() => _controller.stop());
  }

  /// Method to fill in the properties of this widget for debugging purposes.
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('value', widget.value, showName: true, defaultValue: false));
    properties.add(DoubleProperty('height', widget.height, defaultValue: null));
    properties.add(DoubleProperty('width', widget.width, defaultValue: null));
    properties.add(DoubleProperty('borderWidth', widget.borderWidth, defaultValue: null));
    properties.add(DoubleProperty('borderRadius', widget.borderRadius, defaultValue: null));
    properties.add(ColorProperty('borderColor', widget.borderColor, defaultValue: null));
    properties.add(ColorProperty('activeColor', widget.activeColor, defaultValue: null));
    properties.add(ColorProperty('activeTrackColor', widget.activeTrackColor, defaultValue: null));
    properties.add(ColorProperty('inactiveTrackColor', widget.inactiveTrackColor, defaultValue: null));
    properties.add(ColorProperty('inactiveThumbColor', widget.inactiveThumbColor, defaultValue: null));
    properties.add(ObjectFlagProperty<ValueChanged<bool>>.has('onChanged', widget.onChanged));
    properties.add(FlagProperty('enableSlide', value: widget.enableSlide, ifTrue: 'slide enabled'));
  }
}

class RiffSwitchChild extends StatelessWidget {
  const RiffSwitchChild({super.key, required this.isActiveChild, required this.child});

  final bool isActiveChild;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}

/// Decorative Switch

/// Default theme data for the switch.
class _SwitchDefaultsM3 extends SwitchThemeData {
  _SwitchDefaultsM3(BuildContext context) : _colors = Theme.of(context).colorScheme;

  final ColorScheme _colors;

  @override
  MaterialStateProperty<Color> get thumbColor {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        if (states.contains(MaterialState.selected)) {
          return _colors.surface.withOpacity(1.0);
        }
        return _colors.onSurface.withOpacity(0.38);
      }
      if (states.contains(MaterialState.selected)) {
        if (states.contains(MaterialState.pressed)) {
          return _colors.primaryContainer;
        }
        if (states.contains(MaterialState.hovered)) {
          return _colors.primaryContainer;
        }
        if (states.contains(MaterialState.focused)) {
          return _colors.primaryContainer;
        }
        return _colors.onPrimary;
      }
      if (states.contains(MaterialState.pressed)) {
        return _colors.onSurfaceVariant;
      }
      if (states.contains(MaterialState.hovered)) {
        return _colors.onSurfaceVariant;
      }
      if (states.contains(MaterialState.focused)) {
        return _colors.onSurfaceVariant;
      }
      return _colors.outline;
    });
  }

  @override
  MaterialStateProperty<Color> get trackColor {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        if (states.contains(MaterialState.selected)) {
          return _colors.onSurface.withOpacity(0.12);
        }
        return _colors.surfaceVariant.withOpacity(0.12);
      }
      if (states.contains(MaterialState.selected)) {
        if (states.contains(MaterialState.pressed)) {
          return _colors.primary;
        }
        if (states.contains(MaterialState.hovered)) {
          return _colors.primary;
        }
        if (states.contains(MaterialState.focused)) {
          return _colors.primary;
        }
        return _colors.primary;
      }
      if (states.contains(MaterialState.pressed)) {
        return _colors.surfaceVariant;
      }
      if (states.contains(MaterialState.hovered)) {
        return _colors.surfaceVariant;
      }
      if (states.contains(MaterialState.focused)) {
        return _colors.surfaceVariant;
      }
      return _colors.surfaceVariant;
    });
  }

  @override
  MaterialStateProperty<Color?> get overlayColor {
    return MaterialStateProperty.resolveWith((Set<MaterialState> states) {
      if (states.contains(MaterialState.selected)) {
        if (states.contains(MaterialState.pressed)) {
          return _colors.primary.withOpacity(0.12);
        }
        if (states.contains(MaterialState.hovered)) {
          return _colors.primary.withOpacity(0.08);
        }
        if (states.contains(MaterialState.focused)) {
          return _colors.primary.withOpacity(0.12);
        }
        return null;
      }
      if (states.contains(MaterialState.pressed)) {
        return _colors.onSurface.withOpacity(0.12);
      }
      if (states.contains(MaterialState.hovered)) {
        return _colors.onSurface.withOpacity(0.08);
      }
      if (states.contains(MaterialState.focused)) {
        return _colors.onSurface.withOpacity(0.12);
      }
      return null;
    });
  }

  @override
  double get splashRadius => 40.0 / 2;
}
