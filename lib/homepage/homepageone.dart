import 'package:ellcase/addons/fadein.dart';
import 'package:ellcase/addons/texttopainter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typewritertext/typewritertext.dart';
import '../homepage/state/goone.dart';

export '../homepage/homepageone.dart' show HomePageOne;

/// Displaying company's logo.
class HomePageOne extends StatelessWidget {
  const HomePageOne({Key? key, required this.onBottom}) : super(key: key);
  final GestureDetector Function(Widget child) onBottom;

  @override
  Widget build(BuildContext context) {
    /// Animated title.
    const TypeWriterText animTtl = TypeWriterText(
      text: Text('ELLCASE',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 68,
            letterSpacing: 5,
          )),
      duration: Duration(milliseconds: 100),
      alignment: Alignment.centerLeft,
      maintainSize: true,
    );

    /// Animated subtitle.
    const TypeWriterText animSbtl = TypeWriterText(
        text: Text('エルチャセ',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold)),
        duration: Duration(milliseconds: 200),
        alignment: Alignment.center);

    return ChangeNotifierProvider(
        create: (context) => GoOne(),
        builder: (goOneContext, goOneChild) {
          Provider.of<GoOne>(goOneContext, listen: false).setVisibile();

          return Consumer<GoOne>(
              builder: (goOneCon, goOne, goOneChi) => Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        logo(goOne),
                        title(goOne, animTtl),
                        subtitle(goOne, animTtl, animSbtl),
                        company(goOne),
                        flags(goOne),
                      ]));
        });
  }
}

/// Company's Logo.
Widget logo(GoOne goOneVal) => FadeIn(
    visible: goOneVal.visible[5],
    duration: const Duration(milliseconds: 1000),
    size: const Size(150, 150),
    child: Image.asset(
      'assets/logo.png',
    ));

/// Company's Nickname.
Widget title(GoOne goOne, TypeWriterText animTtl) =>
    Visibility(visible: goOne.visible[1], child: animTtl);

/// Company's Motto.
Widget subtitle(GoOne goOne, TypeWriterText title, TypeWriterText subtitle) {
  return LayoutBuilder(
      builder: (builderContext, constrains) => SizedBox(
          width: title.text.toPainter(constrains).width,
          height: subtitle.text.toPainter(constrains).height,
          child: Visibility(
              visible: goOne.visible[2],
              child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeIn,
                  tween: Tween(begin: 0, end: 1),
                  builder: (_, __, ___) => Opacity(opacity: __, child: ___),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    for (int x = 0; x < 3; x++)
                      x.isEven
                          ? Expanded(
                              child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 5),
                              height: 3,
                              color: Colors.black,
                            ))
                          : subtitle
                  ])))));
}

/// Company's Name.
Widget company(GoOne goOne) => FadeIn.text(
      visible: goOne.visible[4],
      margin: const EdgeInsets.symmetric(vertical: 15.0),
      text: const Text('PT ELCASE SETIA HARAPAN',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              letterSpacing: 2.5,
              color: Colors.black)),
    );

/// Bottom Arrow.
Widget flags(GoOne goOne) => FadeIn(
      visible: goOne.visible[5],
      size: const Size(120, 50),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (int x = 0; x < 2; x++)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Image.asset(
                'assets/flag_${['id', 'jp'][x]}.png',
                width: 50,
                height: 50,
              ),
            )
        ],
      ),
    );
