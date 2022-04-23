import 'package:ellcase/addons/fadein.dart';
import 'package:ellcase/addons/texttopainter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typewritertext/typewritertext.dart';

import '../homepage/state/gotwo.dart';

export '../homepage/homepagetwo.dart' show HomePageTwo;

/// Displaying synopsis.
class HomePageTwo extends StatelessWidget {
  const HomePageTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Text title = Text(
      '人をつなぐ。夢を実現する。',
      textAlign: TextAlign.center,
      style: TextStyle(
          height: 1.25,
          fontFamily: 'Mincho',
          fontSize: 40,
          fontWeight: FontWeight.bold),
    );
    const Text subtitle = Text(
        '私たちのビジョンは、若いインドネシア人が日本で働き、夢を実現できるよう支援することです。雇用主と求職者の架け橋、また日本とインドネシアの架け橋。',
        textAlign: TextAlign.center,
        style: TextStyle(
            height: 1.75, fontFamily: 'Mincho', fontWeight: FontWeight.bold));

    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.2),
      child: ChangeNotifierProvider(
          create: (context) => GoTwo(),
          builder: (providerContext, providerChild) {
            GoTwo goTwo = Provider.of<GoTwo>(providerContext, listen: false);
            goTwo.setVisible();

            return Consumer<GoTwo>(
                builder: (goTwoCon, goTwoVal, goTwoChi) => GestureDetector(
                      onTap: () =>
                          (goTwoVal.play == true) ? goTwo.setPlay() : {},
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        color: Colors.transparent,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 25),
                              child: FadeIn(
                                sequence: 0,
                                child: TypeWriterText(
                                    play: true,
                                    text: title,
                                    duration: Duration(milliseconds: 100)),
                              ),
                            ),
                            LayoutBuilder(
                                builder: (context, constraints) => SizedBox(
                                    width:
                                        subtitle.toPainter(constraints).width,
                                    height:
                                        subtitle.toPainter(constraints).height,
                                    child: FadeIn(
                                        sequence: 1,
                                        duration: Duration(
                                            milliseconds:
                                                100 * title.data!.length),
                                        child: subtitle))),
                          ],
                        ),
                      ),
                    ));
          }),
    );
  }
}
