import 'package:ellcase/animation/arrow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typewritertext/typewritertext.dart';

import '../homepage/state/gotwo.dart';

export '../homepage/homepagetwo.dart' show HomePageTwo;

/// Displaying synopsis.
class HomePageTwo extends StatelessWidget {
  const HomePageTwo({Key? key, required this.onBottom, required this.onTop})
      : super(key: key);
  final GestureDetector Function(Widget child) onBottom, onTop;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => GoTwo(),
        builder: (providerContext, providerChild) {
          GoTwo goTwo = Provider.of<GoTwo>(providerContext, listen: false);
          goTwo.setVisible();

          return Consumer<GoTwo>(
              builder: (goTwoCon, goTwoVal, goTwoChi) => GestureDetector(
                    onTap: () => (goTwoVal.play == true) ? goTwo.setPlay() : {},
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          topArrow(goTwoVal, onTop),
                          title(goTwoVal),
                          subtitle(goTwoVal),
                          bottomArrow(goTwoVal, onBottom)
                        ],
                      ),
                    ),
                  ));
        });
  }
}

/// Top navigation button.
Widget topArrow(GoTwo goTwoVal, GestureDetector Function(Widget child) onTop) =>
    SizedBox(
      width: 100,
      height: 100,
      child: Visibility(
        visible: goTwoVal.play == false ? true : goTwoVal.visible[1],
        child: onTop(
          Container(
            color: Colors.transparent,
            child: RotatedBox(
              quarterTurns: 2,
              child: Arrow(
                  duration: const Duration(milliseconds: 750),
                  color: const Color(0xff222222).withOpacity(0.25)),
            ),
          ),
        ),
      ),
    );

/// Synopsis title.
Widget title(GoTwo goTwoVal) => Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Visibility(
        visible: goTwoVal.play == false ? true : goTwoVal.visible[0],
        child: TypeWriterText(
            play: goTwoVal.visible[1] == true ? false : goTwoVal.play,
            text: const Text(
              '人をつなぐ。夢を実現する。',
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 1.25,
                  fontFamily: 'Mincho',
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            duration: const Duration(milliseconds: 100)),
      ),
    );

/// Synopsis content.
Widget subtitle(GoTwo goTwoVal) =>
    LayoutBuilder(builder: (context, constrainst) {
      TextPainter painter = TextPainter(
          text: const TextSpan(
            text:
                '私たちのビジョンは、若いインドネシア人が日本で働き、夢を実現できるよう支援することです。雇用主と求職者の架け橋、また日本とインドネシアの架け橋。',
            style: TextStyle(
                height: 1.75,
                fontFamily: 'Mincho',
                fontWeight: FontWeight.bold),
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr)
        ..layout(
            maxWidth: constrainst.maxWidth, minWidth: constrainst.minWidth);

      return SizedBox(
        width: painter.width,
        height: painter.height,
        child: Visibility(
          visible: goTwoVal.play == false ? true : goTwoVal.visible[1],
          child: TweenAnimationBuilder<double>(
            builder: (context, value, child) =>
                Opacity(opacity: value, child: child),
            tween: Tween(begin: 0, end: 1),
            duration: goTwoVal.play == false
                ? Duration.zero
                : const Duration(milliseconds: 750),
            child: const Text(
              '私たちのビジョンは、若いインドネシア人が日本で働き、夢を実現できるよう支援することです。雇用主と求職者の架け橋、また日本とインドネシアの架け橋。',
              textAlign: TextAlign.center,
              style: TextStyle(
                  height: 1.75,
                  fontFamily: 'Mincho',
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );
    });

/// Bottom navigation button.
Widget bottomArrow(
        GoTwo goTwoVal, GestureDetector Function(Widget child) onBottom) =>
    SizedBox(
      width: 100,
      height: 100,
      child: Visibility(
        visible: goTwoVal.play == false ? true : goTwoVal.visible[1],
        child: onBottom(
          Container(
            color: Colors.transparent,
            child: Arrow(
                duration: const Duration(milliseconds: 750),
                color: const Color(0xff222222).withOpacity(0.25)),
          ),
        ),
      ),
    );
