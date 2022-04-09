import 'dart:async';
import 'package:ellcase/addon/animatedtext.dart';
import 'package:ellcase/animation/arrow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubPage1 extends StatelessWidget {
  const SubPage1({Key? key, required this.bottomClick}) : super(key: key);
  final GestureDetector Function(Widget child) bottomClick;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SubPage1Provider(),
        builder: (providerContext, providerChild) {
          Provider.of<SubPage1Provider>(providerContext, listen: false)
              .changeVisibility();

          return Consumer<SubPage1Provider>(
              builder: (context, value, child) => Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 150,
                          child: Visibility(
                            visible: value.pageVisibility[4],
                            child: TweenAnimationBuilder<double>(
                                duration: const Duration(milliseconds: 1000),
                                curve: Curves.easeIn,
                                tween: Tween(begin: 0, end: 1),
                                builder: (context, value, child) {
                                  return Opacity(
                                    opacity: value,
                                    child: Image.asset(
                                      'assets/lambang.png',
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Visibility(
                          visible: value.pageVisibility[1],
                          child: const AnimatedText(
                            text: Text(
                              'ELLCASE',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 70,
                                  letterSpacing: 5),
                            ),
                            duration: Duration(milliseconds: 100),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(bottom: 15),
                            child: LayoutBuilder(
                              builder: (builderContext, builderConstraints) {
                                TextPainter titlePainter = TextPainter(
                                  textDirection: TextDirection.ltr,
                                  text: const TextSpan(
                                    text: 'ELLCASE',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 70,
                                        letterSpacing: 5),
                                  ),
                                )..layout(
                                    maxWidth: builderConstraints.maxWidth,
                                    minWidth: builderConstraints.minWidth);

                                TextPainter subtitlePainer = TextPainter(
                                  textDirection: TextDirection.ltr,
                                  textAlign: TextAlign.center,
                                  text: const TextSpan(
                                    text: 'エルチャセ',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                )..layout(
                                    maxWidth: builderConstraints.maxWidth,
                                    minWidth: builderConstraints.minWidth);

                                return SizedBox(
                                    width: titlePainter.width,
                                    height: subtitlePainer.height,
                                    child: Visibility(
                                        visible: value.pageVisibility[2],
                                        child: TweenAnimationBuilder<double>(
                                            duration: const Duration(
                                                milliseconds: 1000),
                                            curve: Curves.easeIn,
                                            tween: Tween(begin: 0, end: 1),
                                            builder: (context, val, valChild) =>
                                                Opacity(
                                                    opacity: val,
                                                    child: valChild),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Expanded(
                                                    child: Container(
                                                  margin: const EdgeInsets.only(
                                                      right: 10),
                                                  height: 3,
                                                  color: Colors.black,
                                                )),
                                                const AnimatedText(
                                                  text: Text(
                                                    'エルチャセ',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 200),
                                                ),
                                                Expanded(
                                                    child: Container(
                                                  margin: const EdgeInsets.only(
                                                      left: 10),
                                                  height: 3,
                                                  color: Colors.black,
                                                )),
                                              ],
                                            ))));
                              },
                            )),
                        LayoutBuilder(builder: (context, constraints) {
                          TextPainter painter = TextPainter(
                            textDirection: TextDirection.ltr,
                            text: const TextSpan(
                                text: 'PT ELLCASE SETIA HARAPAN',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2.5,
                                )),
                          )..layout(
                              maxWidth: constraints.maxWidth,
                              minWidth: constraints.minWidth);
                          return SizedBox(
                            width: painter.width,
                            height: painter.height,
                            child: Visibility(
                              visible: value.pageVisibility[4],
                              child: TweenAnimationBuilder<double>(
                                  duration: const Duration(milliseconds: 500),
                                  curve: Curves.easeIn,
                                  tween: Tween(begin: 0, end: 1),
                                  builder: (context, result, child) => Text(
                                      'PT ELLCASE SETIA HARAPAN',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 2.5,
                                          color: Colors.black
                                              .withOpacity(result)))),
                            ),
                          );
                        }),
                        SizedBox(
                          width: 100,
                          height: 100,
                          child: Visibility(
                            visible: value.pageVisibility[5],
                            child: bottomClick(
                              Container(
                                color: Colors.transparent,
                                child: Arrow(
                                    duration: const Duration(milliseconds: 750),
                                    color: const Color(0xff222222)
                                        .withOpacity(0.25)),
                              ),
                            ),
                          ),
                        )
                      ]));
        });
  }
}

class SubPage1Provider with ChangeNotifier {
  List<bool> pageVisibility = [false, false, false, false, false, false];

  void changeVisibility() async {
    pageVisibility[0] = true;

    Timer.periodic(const Duration(milliseconds: 750), (timer) {
      if (timer.tick >= pageVisibility.length) {
        timer.cancel();
      } else {
        pageVisibility[timer.tick] = true;
        notifyListeners();
      }
    });
  }
}
