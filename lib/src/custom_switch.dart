import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({
    Key? key,
    required this.value,
    required this.onChanged,
    this.activeTrackColor,
    this.selectedText = const Text('On'),
    this.defaultText = const Text('Off'),
    this.activeColor,
    this.inactiveTrackColor,
    this.inactiveThumbColor,
  }) : super(key: key);

  final void Function(bool value) onChanged;
  final bool value;

  final Text? selectedText;

  final Text? defaultText;

  /// The color to use when this switch is on.
  ///
  /// Defaults to [ColorScheme.secondary].
  final Color? activeColor;

  final Color? activeTrackColor;

  final Color? inactiveTrackColor;

  final Color? inactiveThumbColor;

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
            child: MaterialButton(
              elevation: 0,
              hoverElevation: 0,
              focusElevation: 0,
              highlightElevation: 0,
              disabledElevation: 0,
              splashColor: null,
              onPressed: () {
                widget.onChanged(false);
                controller.reset();
                controller.forward().whenComplete(() {
                  controller.stop();
                });
              },
              color: _inActiveColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              minWidth: width / 2,
              height: 50,
              child: widget.defaultText,
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
            child: MaterialButton(
              elevation: 0,
              hoverElevation: 0,
              focusElevation: 0,
              highlightElevation: 0,
              disabledElevation: 0,
              splashColor: null,
              onPressed: () {
                widget.onChanged(true);
                controller.reset();
                controller.forward().whenComplete(() {
                  controller.stop();
                });
              },
              color: _activeColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              minWidth: width / 2,
              height: 50,
              child: widget.selectedText,
            ),
          ),
        ]),
      );
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

  Color get _inActiveColor {
    if (widget.activeColor != null) {
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
