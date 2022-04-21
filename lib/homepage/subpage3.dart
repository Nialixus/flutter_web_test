import 'dart:async';
import 'package:ellcase/animation/arrow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typewritertext/typewritertext.dart';

class SubPage3 extends StatelessWidget {
  const SubPage3({Key? key, required this.topClick}) : super(key: key);
  final GestureDetector Function(Widget child) topClick;

  @override
  Widget build(BuildContext context) {
    print('Laman 3 dibangun');

    return ChangeNotifierProvider(
        create: (context) => SubPage3Provider(),
        builder: (providerContext, providerChild) {
          Provider.of<SubPage3Provider>(providerContext, listen: false)
              .changeVisibility();

          return Consumer<SubPage3Provider>(
              builder: (context, value, child) => GestureDetector(
                    onTap: () {
                      if (value.play == true) {
                        Provider.of<SubPage3Provider>(providerContext,
                                listen: false)
                            .changePlay();
                      }
                    },
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
                            child: Consumer<SubPage3Provider>(
                                builder: (context, value, child) => Visibility(
                                      visible: value.play == false
                                          ? true
                                          : value.pageVisibility[0],
                                      child: TypeWriterText(
                                          play: value.pageVisibility[1] == true
                                              ? false
                                              : value.play,
                                          text: const Text(
                                            'PT ELCASE SETIA HARAPANは外国人技能実習制度に基づくインドネシアの送り出し機関です。日本での技能修得を希望するインドネシア人の若者たちを募集し、日本語講習・事前講習の修了後、監理団体を通じて実習実施機関（採用企業）へ実習生を紹介します。採用企業への実績に基づいたアドバイス、実習期間中の日本語学習や技能習得も支援します。',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                height: 1.75,
                                                fontFamily: 'Mincho',
                                                fontWeight: FontWeight.bold),
                                          ),
                                          duration:
                                              const Duration(milliseconds: 50)),
                                    )),
                          ),
                          LayoutBuilder(builder: (context, constraints) {
                            TextPainter painter = TextPainter(
                              textDirection: TextDirection.ltr,
                              text: const TextSpan(
                                text:
                                    '会社名 :PT ELCASE SETIA HARAPAN\n住所 :\nTEL :+62 812-8209-9920\nメール :Id.ellcase@gmail.com\n事業内容 :外国人技能実習生送り出し機関、日本語学校、教育訓練',
                                style: TextStyle(
                                    height: 1.75,
                                    fontFamily: 'Mincho',
                                    fontWeight: FontWeight.bold),
                              ),
                            )..layout(
                                maxWidth: constraints.maxWidth,
                                minWidth: constraints.minWidth);

                            return SizedBox(
                              width: value.pageVisibility[1] == true
                                  ? null
                                  : painter.width,
                              height: value.pageVisibility[1] == true
                                  ? null
                                  : painter.height,
                              child: Visibility(
                                  visible: value.play == false
                                      ? true
                                      : value.pageVisibility[1],
                                  child: TweenAnimationBuilder<double>(
                                    builder: (context, val, child) =>
                                        Opacity(opacity: val, child: child),
                                    tween: Tween(begin: 0, end: 1),
                                    duration: value.play == false
                                        ? Duration.zero
                                        : const Duration(milliseconds: 750),
                                    child: IntrinsicHeight(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          IntrinsicWidth(
                                            child: Column(
                                              children: List.generate(
                                                  5,
                                                  (leftRow) => Align(
                                                        alignment: Alignment
                                                            .centerRight,
                                                        child: Text(
                                                          [
                                                            '会社名 :',
                                                            '住所 :',
                                                            'TEL :',
                                                            'メール :',
                                                            '事業内容 :'
                                                          ][leftRow],
                                                          textAlign:
                                                              TextAlign.end,
                                                          style: const TextStyle(
                                                              height: 1.75,
                                                              fontFamily:
                                                                  'Mincho',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
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
                                                          alignment: Alignment
                                                              .centerLeft,
                                                          child: Text(
                                                            [
                                                              'PT ELCASE SETIA HARAPAN',
                                                              '',
                                                              '+62 812-8209-9920',
                                                              'Id.ellcase@gmail.com',
                                                              '外国人技能実習生送り出し機関、日本語学校、教育訓練'
                                                            ][rightRow],
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: const TextStyle(
                                                                height: 1.75,
                                                                fontFamily:
                                                                    'Mincho',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
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
                          })
                        ],
                      ),
                    ),
                  ));
        });
  }
}

class SubPage3Provider with ChangeNotifier {
  List<bool> pageVisibility = [false, false];
  bool play = true;

  void changePlay() {
    play = false;
    notifyListeners();
  }

  void changeVisibility() async {
    pageVisibility[0] = true;

    await Future.delayed(Duration(
        milliseconds:
            'PT ELCASE SETIA HARAPANは外国人技能実習制度に基づくインドネシアの送り出し機関です。日本での技能修得を希望するインドネシア人の若者たちを募集し、日本語講習・事前講習の修了後、監理団体を通じて実習実施機関（採用企業）へ実習生を紹介します。採用企業への実績に基づいたアドバイス、実習期間中の日本語学習や技能習得も支援します。'
                    .characters
                    .length *
                50));
    pageVisibility[1] = true;
    notifyListeners();
  }
}
