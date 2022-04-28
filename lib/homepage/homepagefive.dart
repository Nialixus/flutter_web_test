import 'package:ellcase/addons/texttopainter.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

export '../homepage/homepagefive.dart' show HomePageFive;

class HomePageFive extends StatelessWidget {
  const HomePageFive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        alignment: Alignment.center,
        padding:
            EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 0),
        child: DefaultTextStyle(
            style: const TextStyle(
                height: 1.75,
                fontFamily: 'Mincho',
                fontWeight: FontWeight.bold),
            child: Text.rich(
              TextSpan(
                children: [
                  for (int x = 0; x < 2; x++)
                    TextSpan(
                        text: [
                          '\nお問い合わせ\n\n',
                          'Phone : (+62) 812-8209-9920\nメールアドレス :id.ellcase@gmail.com\n\n'
                        ][x],
                        style: TextStyle(fontSize: <double?>[40.0, null][x])),
                  WidgetSpan(child: table()),
                  const TextSpan(
                      text:
                          '\nお名前 例)鈴木 一郎\nフリガナ 例)スズキイチロウ\n\n電話番号 例)090-1234-5678\nメールアドレス 例)aaaa@yahoo.co.jp\nお問い合わせ内容 お問い合わせ内容をご記入ください。\n\nこちらの内容で送信します\n\n送信\n\n\n\n\n'),
                  WidgetSpan(child: footer(context))
                ],
              ),
              textAlign: TextAlign.center,
            )));
  }
}

Widget table() {
  List<String> left = ['お名前', 'フリガナ', '電話番号', 'メールアドレス', 'お問い合わせ内容'];
  List<String> right = [
    '例) 鈴木 一郎',
    '例) スズキ イチロウ',
    '例) 090-1234-5678',
    '例) aaaa@yahoo.co.jp',
    'お 問い合わせ 内容 を ご 記入 ください 。'
  ];
  List<String> center = ['ロ こちら の 内容 で 送信 し ます', '送信'];

  BoxBorder border = Border.all(color: const Color(0xffDDDDDD), width: 1);
  return Container(
    decoration: BoxDecoration(color: const Color(0xffFAFAFA), border: border),
    padding: const EdgeInsets.all(5),
    child: Column(
      children: [
        for (int x = 0; x < 5; x++)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  width: 150,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(border: border),
                  child: Text(
                    left[x],
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(border: border),
                  child: Container(
                    color: Colors.white,
                    child: TextField(
                      maxLines: x == 4 ? 5 : null,
                      decoration: InputDecoration(
                          hintText: right[x],
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                  color: Color(0xffDDDDDD), width: 1))),
                    ),
                  ),
                ))
              ],
            ),
          ),
        Container(
            alignment: Alignment.center,
            constraints: const BoxConstraints(minWidth: double.infinity),
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(border: border),
            child: Text(center[0])),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(border: border),
          child: Material(
            color: const Color(0xff333333),
            child: InkWell(
              onTap: () {},
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 5.0),
                child: Text(
                  center[1],
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

Widget footer(BuildContext context) {
  const Text ttl = Text(
    'ELLCASE',
    style: TextStyle(fontSize: 40),
  );
  const Text sbtl =
      Text('エルチャセ', textAlign: TextAlign.center, style: TextStyle(height: 1.0));
  return DefaultTextStyle(
      style: const TextStyle(fontFamily: 'Mincho', fontWeight: FontWeight.bold),
      child: Column(children: [
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              for (int x = 0; x < 2; x++)
                InkWell(
                    onTap: () async => launchUrl(Uri.parse([
                          'https://www.jitco.or.jp/ja/regulation/',
                          'https://www.jitco.or.jp/ja/skill/'
                        ][x])),
                    child: Text(['技能実習生について', '特定技能について'][x]))
            ]..insert(
                1,
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ))),
        Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(children: [
              ttl,
              LayoutBuilder(builder: (context, constraints) {
                return SizedBox(
                    width: ttl.toPainter(constraints).width,
                    height: sbtl.toPainter(constraints).height,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                              child: Container(
                                  height: 3,
                                  color: Colors.black,
                                  margin: const EdgeInsets.only(right: 5.0))),
                          sbtl,
                          Expanded(
                              child: Container(
                                  height: 3,
                                  color: Colors.black,
                                  margin: const EdgeInsets.only(left: 5.0)))
                        ]));
              })
            ]))
      ]));
}
