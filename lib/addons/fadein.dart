import 'package:flutter/material.dart';

import '../addons/texttopainter.dart';

export '../addons/fadein.dart' show FadeIn;

/// Animated opacity.
class FadeIn extends StatelessWidget {
  final Duration? duration;
  final bool? visible, play, maintainSize;
  final Curve? curve;
  final Size? size;
  final Text? text;
  final Widget? child;
  final int? sequence;
  final EdgeInsetsGeometry? margin;
  final void Function(bool built)? onFinish;

  const FadeIn(
      {Key? key,
      required this.child,
      this.duration = const Duration(milliseconds: 750),
      this.maintainSize = true,
      this.size,
      this.margin,
      this.curve,
      this.visible,
      this.sequence = 0,
      this.play = true,
      this.onFinish})
      : text = null,
        super(key: key);

  const FadeIn.text(
      {Key? key,
      required this.text,
      this.maintainSize = true,
      this.duration = const Duration(milliseconds: 750),
      this.size,
      this.margin,
      this.curve,
      this.visible,
      this.sequence = 0,
      this.play = true,
      this.onFinish})
      : child = null,
        super(key: key);

  @override
  Widget build(BuildContext context) => LayoutBuilder(
      builder: (context, constraints) => Container(
          width:
              text != null ? text!.toPainter(constraints).width : size?.width,
          height:
              text != null ? text!.toPainter(constraints).height : size?.height,
          margin: margin,
          alignment: Alignment.center,
          child: play == false
              ? child ?? text!
              : Visibility(
                  visible: visible ?? true,
                  maintainSize: maintainSize!,
                  maintainAnimation: maintainSize!,
                  maintainState: maintainSize!,
                  child: FutureBuilder(
                      future: Future.delayed(duration! * sequence!),
                      builder: (context, snapshot) =>
                          snapshot.connectionState == ConnectionState.done
                              ? TweenAnimationBuilder<double>(
                                  duration: duration!,
                                  curve: curve ?? Curves.linear,
                                  tween: Tween(begin: 0, end: 1),
                                  builder: (_, value, ___) {
                                    onFinish != null
                                        ? value == 1
                                            ? onFinish!(!(value == 1))
                                            : null
                                        : null;
                                    return Opacity(
                                        opacity: value, child: child ?? text!);
                                  })
                              : const SizedBox()))));
}
