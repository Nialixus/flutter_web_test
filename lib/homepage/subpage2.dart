import 'dart:async';
import 'package:ellcase/animation/arrow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typewritertext/typewritertext.dart';

class SubPage2 extends StatelessWidget {
  const SubPage2({Key? key, required this.bottomClick, required this.topClick})
      : super(key: key);
  final GestureDetector Function(Widget child) bottomClick, topClick;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => SubPage2Provider(),
        builder: (providerContext, providerChild) {
          Provider.of<SubPage2Provider>(providerContext, listen: false)
              .changeVisibility();

          return Consumer<SubPage2Provider>(
              builder: (context, value, child) => GestureDetector(
                    onTap: () {
                      if (value.play == true) {
                        Provider.of<SubPage2Provider>(providerContext,
                                listen: false)
                            .changePlay();
                      }
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.transparent,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Visibility(
                              visible: value.play == false
                                  ? true
                                  : value.pageVisibility[1],
                              child: topClick(
                                Container(
                                  color: Colors.transparent,
                                  child: RotatedBox(
                                    quarterTurns: 2,
                                    child: Arrow(
                                        duration:
                                            const Duration(milliseconds: 750),
                                        color: const Color(0xff222222)
                                            .withOpacity(0.25)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 25),
                            child: Visibility(
                              visible: value.play == false
                                  ? true
                                  : value.pageVisibility[0],
                              child: TypeWriterText(
                                  play: value.pageVisibility[1] == true
                                      ? false
                                      : value.play,
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
                          ),
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
                                  maxWidth: constrainst.maxWidth,
                                  minWidth: constrainst.minWidth);

                            return SizedBox(
                              width: painter.width,
                              height: painter.height,
                              child: Visibility(
                                visible: value.play == false
                                    ? true
                                    : value.pageVisibility[1],
                                child: TweenAnimationBuilder<double>(
                                  builder: (context, value, child) =>
                                      Opacity(opacity: value, child: child),
                                  tween: Tween(begin: 0, end: 1),
                                  duration: value.play == false
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
                          }),
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: Visibility(
                              visible: value.play == false
                                  ? true
                                  : value.pageVisibility[1],
                              child: bottomClick(
                                Container(
                                  color: Colors.transparent,
                                  child: Arrow(
                                      duration:
                                          const Duration(milliseconds: 750),
                                      color: const Color(0xff222222)
                                          .withOpacity(0.25)),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ));
        });
  }
}

class SubPage2Provider with ChangeNotifier {
  List<bool> pageVisibility = [false, false];
  bool play = true;

  void changePlay() {
    play = false;
    notifyListeners();
  }

  void changeVisibility() async {
    pageVisibility[0] = true;

    await Future.delayed(
        Duration(milliseconds: '人をつなぐ。夢を実現する。'.characters.length * 150));
    pageVisibility[1] = true;
    notifyListeners();
  }
}
