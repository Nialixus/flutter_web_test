import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../addons/fadein.dart';
import '../homepage/state/go.dart';

export '../homepage/homepagethree.dart' show HomePageThree;

class HomePageThree extends StatelessWidget {
  const HomePageThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    const Text preposition = Text(
        'PT ELCASE SETIA HARAPANは外国人技能実習制度に基づくインドネシアの送り出し機関です。\n日本での技能修得を希望するインドネシア人の若者たちを募集し、日本語講習・事前講習の修了後、監理団体を通じて実習実施機関(採用企業)へ実習生を紹介します。採用企業への実績に基づいたアドバイス、実習期間中の日本語学習や技能習得も支援します。',
        textAlign: TextAlign.center,
        style: TextStyle(
            height: 1.75, fontFamily: 'Mincho', fontWeight: FontWeight.bold));

    Align right(int index) => Align(
        alignment: Alignment.centerLeft,
        child: Text(
            [
              'PT ELCASE SETIA HARAPAN',
              '',
              '+62 812-8209-9920',
              'Id.ellcase@gmail.com',
              '外国人技能実習生送り出し機関、日本語学校、教育訓練'
            ][index],
            textAlign: TextAlign.start,
            style: const TextStyle(
                height: 1.75,
                fontFamily: 'Mincho',
                fontWeight: FontWeight.bold)));

    Align left(int index) => Align(
        alignment: Alignment.centerRight,
        child: Text(['会社名 :', '住所 :', 'TEL :', 'メール :', '事業内容 :'][index],
            textAlign: TextAlign.end,
            style: const TextStyle(
                height: 1.75,
                fontFamily: 'Mincho',
                fontWeight: FontWeight.bold)));

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
        child: Builder(
            builder: (go) => FadeIn(
                visible: go.select((Go go) => go.state[2].onStart),
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Padding(
                          padding: EdgeInsets.only(bottom: 25),
                          child: preposition),
                      IntrinsicHeight(
                          child: Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                            Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: IntrinsicWidth(
                                    child: Column(
                                        children:
                                            List.generate(5, (x) => left(x))))),
                            Flexible(
                                child: IntrinsicWidth(
                                    child: Column(
                                        children:
                                            List.generate(5, (y) => right(y)))))
                          ]))
                    ]))));
  }
}
