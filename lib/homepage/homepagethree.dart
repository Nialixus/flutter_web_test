import 'package:ellcase/animation/arrow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typewritertext/typewritertext.dart';

import '../homepage/state/goThree.dart';

export '../homepage/homepagethree.dart' show HomePageThree;

class HomePageThree extends StatelessWidget {
  const HomePageThree({Key? key, required this.onTop}) : super(key: key);
  final GestureDetector Function(Widget child) onTop;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => GoThree(),
        builder: (goThreeContext, goThreeChild) {
          GoThree goThree = Provider.of<GoThree>(goThreeContext, listen: false);
          goThree.setVisible();

          return Consumer<GoThree>(
              builder: (goThreeCon, goThreeVal, goThreeChi) => GestureDetector(
                    onTap: () => goThree.play == true ? goThree.setPlay() : {},
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      color: Colors.transparent,
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          arrow(goThreeVal, onTop),
                          synopsis(goThreeVal),
                          form(goThreeVal)
                        ],
                      ),
                    ),
                  ));
        });
  }
}

/// Navigate to top.
Widget arrow(
        GoThree goThreeVal, GestureDetector Function(Widget child) onTop) =>
    SizedBox(
      width: 100,
      height: 100,
      child: Visibility(
        visible: goThreeVal.play == false ? true : goThreeVal.visible[1],
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

Widget synopsis(GoThree goThreeVal) => Padding(
    padding: const EdgeInsets.only(bottom: 25),
    child: Visibility(
      visible: goThreeVal.play == false ? true : goThreeVal.visible[0],
      child: TypeWriterText(
          play: goThreeVal.visible[1] == true ? false : goThreeVal.play,
          text: const Text(
            'PT ELCASE SETIA HARAPANは外国人技能実習制度に基づくインドネシアの送り出し機関です。日本での技能修得を希望するインドネシア人の若者たちを募集し、日本語講習・事前講習の修了後、監理団体を通じて実習実施機関（採用企業）へ実習生を紹介します。採用企業への実績に基づいたアドバイス、実習期間中の日本語学習や技能習得も支援します。',
            textAlign: TextAlign.center,
            style: TextStyle(
                height: 1.75,
                fontFamily: 'Mincho',
                fontWeight: FontWeight.bold),
          ),
          duration: const Duration(milliseconds: 50)),
    ));

Widget form(GoThree goThreeVal) =>
    LayoutBuilder(builder: (context, constraints) {
      TextPainter painter = TextPainter(
        textDirection: TextDirection.ltr,
        text: const TextSpan(
          text:
              '会社名 :PT ELCASE SETIA HARAPAN\n住所 :\nTEL :+62 812-8209-9920\nメール :Id.ellcase@gmail.com\n事業内容 :外国人技能実習生送り出し機関、日本語学校、教育訓練',
          style: TextStyle(
              height: 1.75, fontFamily: 'Mincho', fontWeight: FontWeight.bold),
        ),
      )..layout(maxWidth: constraints.maxWidth, minWidth: constraints.minWidth);

      return SizedBox(
        width: goThreeVal.visible[1] == true ? null : painter.width,
        height: goThreeVal.visible[1] == true ? null : painter.height,
        child: Visibility(
            visible: goThreeVal.play == false ? true : goThreeVal.visible[1],
            child: TweenAnimationBuilder<double>(
              builder: (context, val, child) =>
                  Opacity(opacity: val, child: child),
              tween: Tween(begin: 0, end: 1),
              duration: goThreeVal.play == false
                  ? Duration.zero
                  : const Duration(milliseconds: 750),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IntrinsicWidth(
                      child: Column(
                        children: List.generate(
                            5,
                            (leftRow) => Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    [
                                      '会社名 :',
                                      '住所 :',
                                      'TEL :',
                                      'メール :',
                                      '事業内容 :'
                                    ][leftRow],
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        height: 1.75,
                                        fontFamily: 'Mincho',
                                        fontWeight: FontWeight.bold),
                                  ),
                                )),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Flexible(
                      child: IntrinsicWidth(
                        child: Column(
                          children: List.generate(
                              5,
                              (rightRow) => Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      [
                                        'PT ELCASE SETIA HARAPAN',
                                        '',
                                        '+62 812-8209-9920',
                                        'Id.ellcase@gmail.com',
                                        '外国人技能実習生送り出し機関、日本語学校、教育訓練'
                                      ][rightRow],
                                      textAlign: TextAlign.start,
                                      style: const TextStyle(
                                          height: 1.75,
                                          fontFamily: 'Mincho',
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )),
      );
    });
