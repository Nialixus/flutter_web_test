import 'package:ellcase/homepage/homepagefive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../addons/fadein.dart';
import '../homepage/state/go.dart';
import '../homepage/state/homepagefourstate.dart';

export '../homepage/homepagefour.dart' show HomePageFour;

class HomePageFour extends StatelessWidget {
  const HomePageFour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        width: size.width,
        padding: EdgeInsets.only(
            left: size.width * 0.1,
            right: size.width * 0.1,
            top: kToolbarHeight),
        child: VisibilityDetector(
          key: const Key('pageFour'),
          onVisibilityChanged: (result) {
            if (result.visibleFraction >= 0.5) {
              context.read<Go>().showPage(3);
            }
          },
          child: DefaultTextStyle(
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Mincho',
                height: 1.75),
            child: Builder(
                builder: (context) => FadeIn(
                    visible: context.select((Go go) => go.state[3]),
                    child: ChangeNotifierProvider(
                        create: (context) => GoFourOne(),
                        builder: (fourOneContext, fourOneChild) =>
                            pageFourOne(fourOneContext)))),
          ),
        ));
  }
}

Widget pageFourOne(BuildContext context) => Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        for (int x = 0; x < 2; x++)
          Text(['流れ', 'PT ELCASE SETIA HARAPAN 送り出し機関と組合様(監理団体)との協定の締結\n'][x],
              style: TextStyle(
                  height: [1.25, 1.75][x], fontSize: <double?>[40, null][x])),
        Material(
            color: const Color(0xffD3D3D3),
            child: InkWell(
                onTap: () => context.read<GoFourOne>().onTap(),
                child: const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                    child: Text('確認書類')))),
        Builder(builder: (context) {
          bool open = context.select((GoFourOne fourOne) => fourOne.open);
          return Column(
            children: [
              ConstrainedBox(
                  constraints: const BoxConstraints(minWidth: 300),
                  child: FadeIn.text(
                      maintainSize: false,
                      visible:
                          context.select((GoFourOne fourOne) => fourOne.open),
                      text: const Text(
                          '\n• 講習期間内の待遇のご提示\n• 技能実習期間中の労働条件のご提示\n• 技能実習生受入れ希望人数のご提示\n• 受入れされる職種のご提示\n• 実習生の面接される時期指定\n• 技能実習生選抜申請依頼書\n• 募集申請依頼書',
                          textAlign: TextAlign.start,
                          style: TextStyle(height: 1.75)))),
              FadeIn.text(
                  maintainSize: false,
                  visible: open,
                  text: const Text(
                      '↓\nインドネシア国内にて、組合様からの要望(業種・待遇・労働条件・募集人数など)を基に候補者を募集し、一次面接を社内選考を実施行う\n\n',
                      style: TextStyle(height: 1.75))),
              FadeIn(
                  maintainSize: false,
                  visible: open,
                  child: ChangeNotifierProvider(
                      create: (context) => GoFourTwo(),
                      builder: (fourTwoContext, fourTwoChild) =>
                          pageFourTwo(fourTwoContext)))
            ],
          );
        }),
      ],
    );

Widget pageFourTwo(BuildContext context) => Column(children: [
      Material(
          color: const Color(0xffD3D3D3),
          child: InkWell(
              onTap: () => context.read<GoFourTwo>().onTap(),
              child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Text('募集活動')))),
      Builder(builder: (context) {
        bool open = context.select((GoFourTwo fourTwo) => fourTwo.open);
        return Column(children: [
          FadeIn.text(
              maintainSize: false,
              visible: open,
              text: const Text(
                  '\n1.説明会\n応募者に対して、技能実習制度の説明を行う\n↓\nIQ テスト・計算テスト・日本語テストを実施する\n2.トライアルコース(1週間)\n技能実習制度の知識と日本の知識教育を行う\n↓\n生活態度チェックや各種テストを行う\n\n',
                  style: TextStyle(height: 1.75))),
          FadeIn(
            maintainSize: false,
            visible: open,
            child: Container(
                color: const Color(0xffD3D3D3),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: const Text('面接候補者に対し、1 週間の講義を実施しており、合格者のみを面接に参加させます。')),
          ),
          const Text('\n'),
          FadeIn(
              maintainSize: false,
              visible: open,
              child: ChangeNotifierProvider(
                create: (context) => GoFourThree(),
                builder: (fourThreeContext, fourThreeChild) =>
                    pageFourThree(fourThreeContext),
              ))
        ]);
      })
    ]);

Widget pageFourThree(BuildContext context) => Column(children: [
      Material(
          color: const Color(0xffD3D3D3),
          child: InkWell(
              onTap: () => context.read<GoFourThree>().onTap(),
              child: const Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                  child: Text('トライアル期間の講義内容')))),
      Builder(builder: (context) {
        bool open = context.select((GoFourThree fourThree) => fourThree.open);
        return Column(children: [
          FadeIn.text(
              maintainSize: false,
              visible: open,
              text: const Text(
                  '\n1.説明会\n応募者に対して、技能実習制度の説明を行う\n↓\nIQ テスト・計算テスト・日本語テストを実施する\n2.トライアルコース(1週間)\n技能実習制度の知識と日本の知識教育を行う\n↓\n生活態度チェックや各種テストを行う',
                  style: TextStyle(height: 1.75))),
          ConstrainedBox(
              constraints: const BoxConstraints(minWidth: 300),
              child: FadeIn.text(
                  maintainSize: false,
                  visible: open,
                  text: const Text(
                      '\n• 実習生としての基礎知識\n• 日本での生活(健康管理・ごみの処理・食生活・交通安全・自転車の規則など)\n• 日本文化(四季・時間の概念・挨拶の意味・報連相・掃除・日本の産業・食べ物など)\n• 雇用条件書に対する知識\n• 日本語での自己紹介・挨拶・お辞儀\n• 各種テスト\n• 体力測定',
                      textAlign: TextAlign.start,
                      style: TextStyle(height: 1.75)))),
          FadeIn.text(
              maintainSize: false,
              visible: open,
              text: const Text(
                  '↓\nインドネシアで受け入れ企業・組合(監理団体)により、技能実習候補者に面接を行う(二次面接)\n↓\n技能実習生決定後、健康診断\n↓\n事前教育(約 4 ヶ月)と書類の申請など\n\n',
                  style: TextStyle(height: 1.75))),
          FadeIn(
              maintainSize: false,
              visible: open,
              child: ChangeNotifierProvider(
                create: (context) => GoFourFour(),
                builder: (fourFourContext, fourFourChild) =>
                    pageFourFour(fourFourContext),
              ))
        ]);
      })
    ]);

Widget pageFourFour(BuildContext context) {
  List<String> left = ['\n日本語教育', '基礎教育', '生活指導'];
  List<String> center = [
    '\n初級文法・会話\n聴解\n漢字\n語彙\n動作動詞',
    '仕事の基本\n専門用語\n労働衛生安全\n5S\n報連相',
    '日本の文化\n日本の習慣\n日常生活'
  ];
  List<String> right = [
    '\n『みんなの日本語I・II』『新日本語の基礎I・II』を使用\nやや長めの会話を聞いて理解できるようにする\n生活に必要な漢字が読めて意味が理解できるようにする\n日常生活で必要な N 4 レベルの語彙を理解する\n工場内で指示通り動けるようにする',
    '基礎や専門用語などを早い段階で覚えるようにする',
    '挨拶・買い物・銀行・交通機関・ゴミの分別等、インドネシアと日本 の違いを学ぶ'
  ];

  ScrollController newController = ScrollController(initialScrollOffset: 0.0);

  return Column(children: [
    Material(
        color: const Color(0xffD3D3D3),
        child: InkWell(
            onTap: () => context.read<GoFourFour>().onTap(),
            child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Text('カリキュラム')))),
    Builder(
        builder: (context) => Column(children: [
              FadeIn(
                maintainSize: false,
                visible: context.select((GoFourFour fourFour) => fourFour.open),
                child: Scrollbar(
                  controller: newController,
                  isAlwaysShown: true,
                  interactive: true,
                  scrollbarOrientation: ScrollbarOrientation.bottom,
                  child: SingleChildScrollView(
                    controller: newController,
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      children: [
                        for (int x = 0; x < 3; x++)
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for (int y = 0; y < 3; y++)
                                  Container(
                                      width: <double?>[100, 100, 300][y],
                                      padding: y == 1
                                          ? const EdgeInsets.symmetric(
                                              horizontal: 8.0)
                                          : EdgeInsets.zero,
                                      child: Text([left, center, right][y][x]))
                              ]),
                      ],
                    ),
                  ),
                ),
              ),
              FadeIn.text(
                  maintainSize: false,
                  visible:
                      context.select((GoFourFour fourFour) => fourFour.open),
                  text: const Text(
                      '↓\n出国\nインドネシアを出国して日本に入国して約1ヶ月間の講習を行う\n↓\nフォローサポート\n入国後も日本にいる実習生たちとコンタクトをとり、相談などをうける\n帰国後の実習生への職業紹介もする\n\n',
                      textAlign: TextAlign.center)),
              FadeIn(
                visible: context.select((GoFourFour fourFour) => fourFour.open),
                child: ChangeNotifierProvider(
                  create: (context) => GoFourFive(),
                  builder: (context, child) => pageFourFive(context),
                ),
              ),
            ]))
  ]);
}

Widget pageFourFive(BuildContext context) => VisibilityDetector(
      key: const Key('pageFive'),
      onVisibilityChanged: (result) {
        if (result.visibleFraction > 0.25) {
          context.read<GoFourFive>().onVisible();
        }
      },
      child: FadeIn(
        visible: context.select((GoFourFive fourFive) => fourFive.open),
        child: const HomePageFive(),
      ),
    );
