import 'package:flutter/material.dart';

import '../addons/texttopainter.dart';

/// Animated opacity.
class FadeIn extends StatelessWidget {
  final Duration? duration;
  final bool? visible, built;
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
      this.duration,
      this.size,
      this.margin,
      this.curve,
      this.visible,
      this.sequence,
      this.built,
      this.onFinish})
      : text = null,
        super(key: key);

  const FadeIn.text(
      {Key? key,
      required this.text,
      this.duration,
      this.size,
      this.margin,
      this.curve,
      this.visible,
      this.sequence,
      this.built,
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

        Duration durasi = duration ?? const Duration(milliseconds: 750);

        return Container(
          width: width,
          height: height,
          margin: margin,
          alignment: Alignment.center,
          child: built ?? false
              ? child == null
                  ? text!
                  : child!
              : FutureBuilder(
                  future: Future.delayed(durasi * (sequence ?? 0)),
                  builder: (context, snapshot) => Visibility(
                      visible: visible ??
                          snapshot.connectionState == ConnectionState.done,
                      child: TweenAnimationBuilder<double>(
                          duration: durasi,
                          curve: curve ?? Curves.easeIn,
                          tween: Tween(begin: 0, end: 1),
                          builder: (_, value, ___) {
                            onFinish != null
                                ? value == 1
                                    ? onFinish!(value == 1)
                                    : null
                                : null;
                            return Opacity(
                                opacity: value,
                                child: child == null ? text! : child!);
                          }))),
        );
      });
}
