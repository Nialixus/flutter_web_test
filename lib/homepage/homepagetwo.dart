import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typewritertext/typewritertext.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../addons/fadein.dart';
import '../homepage/state/go.dart';

export '../homepage/homepagetwo.dart' show HomePageTwo;

/// Displaying synopsis.
class HomePageTwo extends StatelessWidget {
  const HomePageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// Shortcut size.
    Size size = MediaQuery.of(context).size;

    /// Synopsis title.
    const Text title = Text('人をつなぐ。夢を実現する。',
        textAlign: TextAlign.center,
        style: TextStyle(
            height: 1.25,
            fontFamily: 'Mincho',
            fontSize: 40,
            fontWeight: FontWeight.bold));

    /// Synopsis subtitle.
    const Text subtitle = Text(
        '私たちのビジョンは、若いインドネシア人が日本で働き、夢を実現できるよう支援することです。そうして、 企業と人の懸け橋として、日本での人材不足を解決するためのサービスを提供して実習生や特定技能の送り出し機関です。',
        textAlign: TextAlign.center,
        style: TextStyle(
            height: 1.75, fontFamily: 'Mincho', fontWeight: FontWeight.bold));

    /// Shortcut duration
    const Duration duration = Duration(milliseconds: 200);

    return Container(
        constraints: BoxConstraints(minHeight: size.height),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              VisibilityDetector(
                key: const Key('pageTwo'),
                onVisibilityChanged: (result) {
                  if (result.visibleFraction >= 0.5) {
                    context.read<Go>().showPage(1);
                  }
                },
                child: Builder(builder: (context) {
                  return FadeIn(
                      visible: context.select((Go go) => go.state[1]),
                      child: const Padding(
                          padding: EdgeInsets.only(bottom: 25),
                          child:
                              TypeWriterText(text: title, duration: duration)));
                }),
              ),
              Builder(builder: (context) {
                return FadeIn.text(
                    visible: context.select((Go go) => go.state[1]),
                    duration: duration,
                    sequence: title.data!.length,
                    text: subtitle);
              })
            ]));
  }
}
