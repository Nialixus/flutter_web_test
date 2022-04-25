import 'package:flutter/material.dart';

import '../addons/texttopainter.dart';

/// Animated opacity.
class FadeIn extends StatelessWidget {
  final Duration? duration;
  final bool? visible, play;
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
          child: play == true
              ? Visibility(
                  visible: visible ?? true,
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
                              : const SizedBox()))
              : child ?? text!,
        );
      });
}
