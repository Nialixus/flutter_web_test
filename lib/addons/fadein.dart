import 'package:flutter/material.dart';

import '../addons/texttopainter.dart';

/// Animated opacity.
class FadeIn extends StatelessWidget {
  final bool visible;
  final Duration? duration;
  final Curve? curve;
  final Size? size;
  final Text? text;
  final Widget? child;
  final EdgeInsetsGeometry? margin;

  const FadeIn({
    Key? key,
    required this.visible,
    required this.child,
    this.size,
    this.margin,
    this.duration,
    this.curve,
  })  : text = null,
        super(key: key);

  const FadeIn.text({
    Key? key,
    required this.visible,
    required this.text,
    this.size,
    this.margin,
    this.curve,
    this.duration,
  })  : child = null,
        super(key: key);

  @override
  Widget build(BuildContext context) =>
      LayoutBuilder(builder: (context, constraints) {
        double? width =
            text != null ? text!.toPainter(constraints).width : size?.width;
        double? height =
            text != null ? text!.toPainter(constraints).height : size?.height;

        return Container(
          width: width,
          height: height,
          margin: margin,
          alignment: Alignment.center,
          child: Visibility(
              visible: visible,
              child: TweenAnimationBuilder<double>(
                  duration: duration ?? const Duration(milliseconds: 500),
                  curve: curve ?? Curves.easeIn,
                  tween: Tween(begin: 0, end: 1),
                  builder: (_, value, ___) => Opacity(
                      opacity: value, child: child == null ? text! : child!))),
        );
      });
}
