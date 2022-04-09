import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimatedText extends StatelessWidget {
  const AnimatedText(
      {Key? key, required this.text, required this.duration, this.play})
      : super(key: key);
  final Text text;
  final Duration duration;
  final bool? play;

  @override
  Widget build(BuildContext context) {
    return (play ?? true) == false
        ? text
        : ChangeNotifierProvider<AnimatedTextState>.value(
            value: AnimatedTextState(text: text),
            builder: (animatedContext, animatedChild) {
              Provider.of<AnimatedTextState>(animatedContext, listen: false)
                  .animate(duration);

              return LayoutBuilder(
                  builder: (builderContext, builderConstraints) {
                TextPainter textPainter = TextPainter(
                    locale: text.locale,
                    maxLines: text.maxLines,
                    strutStyle: text.strutStyle,
                    text: TextSpan(
                        text: text.data!,
                        style: text.style,
                        locale: text.locale,
                        semanticsLabel: text.semanticsLabel),
                    textAlign: text.textAlign ?? TextAlign.start,
                    textDirection: text.textDirection ?? TextDirection.ltr,
                    textHeightBehavior: text.textHeightBehavior,
                    textScaleFactor: text.textScaleFactor ?? 1.0,
                    textWidthBasis:
                        text.textWidthBasis ?? TextWidthBasis.parent)
                  ..layout(
                      maxWidth: builderConstraints.maxWidth,
                      minWidth: builderConstraints.minWidth);

                return Container(
                    alignment: text.textAlign == TextAlign.center
                        ? Alignment.center
                        : text.textAlign == TextAlign.end
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                    width: text.textAlign == TextAlign.center
                        ? null
                        : textPainter.width,
                    height: text.textAlign == TextAlign.center
                        ? null
                        : textPainter.height,
                    child: Consumer<AnimatedTextState>(
                        builder: (context, value, child) => Text(
                              value.textContent,
                              key: text.key,
                              locale: text.locale,
                              maxLines: text.maxLines,
                              overflow: text.overflow,
                              semanticsLabel: text.semanticsLabel,
                              softWrap: text.softWrap,
                              strutStyle: text.strutStyle,
                              style: text.style,
                              textAlign: text.textAlign,
                              textDirection: text.textDirection,
                              textHeightBehavior: text.textHeightBehavior,
                              textScaleFactor: text.textScaleFactor,
                              textWidthBasis: text.textWidthBasis,
                            )));
              });
            });
  }
}

class AnimatedTextState with ChangeNotifier {
  AnimatedTextState({required this.text});
  final Text text;

  late List<String> textList = [
    for (int x = 0; x < text.data!.characters.length; x++)
      text.data!.characters.string.substring(0, x + 1)
  ];

  String textContent = '';

  void animate(Duration duration) async {
    textContent = textList[0];

    Timer.periodic(duration, (timer) {
      if (timer.tick >= textList.length) {
        timer.cancel();
      } else {
        textContent = textList[timer.tick];
        notifyListeners();
      }
    });
  }
}
