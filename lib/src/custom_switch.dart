import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  const CustomSwitch({
    Key? key,
    this.onChanged,
    required this.trackColor,
    required this.value,
    required this.activatedText,
    required this.disabledText,
  }) : super(key: key);

  final void Function(bool value)? onChanged;
  final Color trackColor;
  final bool value;
  final Text activatedText;
  final Text disabledText;

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Tween<double> tween;
  late CurvedAnimation animation;

  @override
  void initState() {
    controller = AnimationController(duration: const Duration(milliseconds: 80), vsync: this);
    tween = Tween(begin: 0.9, end: 1.0);
    animation = CurvedAnimation(parent: tween.animate(controller), curve: Curves.easeOutBack);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      var width = constraint.maxWidth;
      return Container(
        width: width,
        decoration: BoxDecoration(color: widget.trackColor, borderRadius: BorderRadius.circular(25)),
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
              onPressed: () {
                widget.onChanged!(false);
                controller.reset();
                controller.forward().whenComplete(() {
                  controller.stop();
                });
              },
              color: !widget.value ? Colors.cyan : Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              minWidth: width / 2,
              height: 50,
              child: widget.activatedText,
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
              onPressed: () {
                widget.onChanged!(true);
                controller.reset();
                controller.forward().whenComplete(() {
                  controller.stop();
                });
              },
              color: widget.value ? Colors.cyan : Colors.transparent,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
              minWidth: width / 2,
              height: 50,
              child: widget.disabledText,
            ),
          ),
        ]),
      );
    });
  }
}
