import 'package:flutter/material.dart';

TextPainter textPainter(Text text, BoxConstraints constraints) => TextPainter(
      textDirection: text.textDirection ?? TextDirection.ltr,
      text: TextSpan(
          text: text.data!,
          locale: text.locale,
          semanticsLabel: text.semanticsLabel,
          style: text.style),
    )..layout(maxWidth: constraints.maxWidth, minWidth: constraints.minWidth);

extension TextToPainter on Text {
  TextPainter toPainter(BoxConstraints constraints) =>
      textPainter(this, constraints);
}
