import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../addons/fadein.dart';
import '../homepage/state/go.dart';

class HomePageFour extends StatefulWidget {
  const HomePageFour({Key? key}) : super(key: key);

  @override
  State<HomePageFour> createState() => _HomePageFourState();
}

class _HomePageFourState extends State<HomePageFour> {
  bool open = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.2, vertical: kToolbarHeight),
        child: Builder(
            builder: (context) => FadeIn(
                visible: context.select((Go go) => go.state[3].onStart),
                play: open ? false : null,
                child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text.rich(
                          TextSpan(children: [
                            for (int x = 0; x < 2; x++)
                              TextSpan(
                                  text: [
                                    '流れ\n\n',
                                    'PT ELCASE SETIA HARAPAN 送り出し機関と組合様(監理団体)との協定の締結\n\n'
                                  ][x],
                                  style: TextStyle(
                                      fontFamily: 'Mincho',
                                      height: [1.25, 1.75][x],
                                      fontSize: <double?>[40, null][x],
                                      fontWeight: FontWeight.bold)),
                            WidgetSpan(
                                child: Material(
                                    color: const Color(0xffD3D3D3),
                                    child: InkWell(
                                        onTap: () {
                                          setState(() {
                                            open = !open;
                                          });
                                        },
                                        child: const Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10.0,
                                                vertical: 5.0),
                                            child: Text('確認書類',
                                                style: TextStyle(
                                                    fontFamily: 'Mincho',
                                                    fontWeight:
                                                        FontWeight.bold))))))
                          ]),
                          textAlign: TextAlign.center),
                      FadeIn.text(
                          visible: open,
                          text: const Text(
                              '\n● 講習期間内の待遇のご提示\n● 技能実習期間中の労働条件のご提示\n● 技能実習生受入れ希望人数のご提示\n● 受入れされる職種のご提示\n● 実習生の面接される時期指定\n● 技能実習生選抜申請依頼書\n● 募集申請依頼書',
                              style: TextStyle(
                                  fontFamily: 'Mincho',
                                  fontWeight: FontWeight.bold,
                                  height: 1.75)))
                    ]))));
  }
}
