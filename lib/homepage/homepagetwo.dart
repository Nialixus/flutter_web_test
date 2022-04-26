import 'package:flutter/material.dart';
import 'package:typewritertext/typewritertext.dart';
import 'package:provider/provider.dart';

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

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
        child: Builder(builder: (context) {
          bool select = context.select((Go go) => go.state[1].onStart);
          return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeIn(
                    visible: select,
                    child: const Padding(
                        padding: EdgeInsets.only(bottom: 25),
                        child:
                            TypeWriterText(text: title, duration: duration))),
                FadeIn.text(
                    visible: select,
                    duration: duration,
                    sequence: title.data!.length,
                    text: subtitle)
              ]);
        }));
  }
}
