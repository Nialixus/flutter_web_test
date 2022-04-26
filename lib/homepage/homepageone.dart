import 'package:flutter/material.dart';
import 'package:typewritertext/typewritertext.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';

import '../addons/fadein.dart';
import '../addons/texttopainter.dart';
import '../homepage/state/go.dart';

export '../homepage/homepageone.dart' show HomePageOne;

/// Displaying company's logo.
class HomePageOne extends StatelessWidget {
  const HomePageOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    /// Animated title.
    TypeWriterText animTtl = const TypeWriterText(
        text: Text('ELLCASE',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 68,
              letterSpacing: 5,
            )),
        duration: Duration(milliseconds: 100),
        alignment: Alignment.centerLeft,
        maintainSize: true);

    /// Animated subtitle.
    TypeWriterText animSbtl = const TypeWriterText(
      text: Text('エルチャセ',
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold)),
      duration: Duration(milliseconds: 200),
      maintainSize: true,
    );

    return Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              logo,
              title(animTtl),
              subtitle(animTtl, animSbtl),
              company,
              flags
            ]));
  }
}

/// Company's Logo.
Widget logo = Builder(
    builder: (context) => FadeIn(
        visible: context.select((Go go) => go.state[0].onStart),
        sequence: 6,
        size: const Size(150, 150),
        child: Image.asset('assets/logo.png')));

/// Company's Nickname.
Widget title(TypeWriterText animTtl) => Builder(
    builder: (context) => FadeIn(
        visible: context.select((Go go) => go.state[0].onStart),
        child: animTtl));

/// Company's Motto.
Widget subtitle(TypeWriterText title, TypeWriterText subtitle) => Builder(
    builder: (context) => FadeIn(
        visible: context.select((Go go) => go.state[0].onStart),
        sequence: 3,
        child: LayoutBuilder(
            builder: (_, constraints) => SizedBox(
                width: title.text.toPainter(constraints).width,
                height: subtitle.text.toPainter(constraints).height,
                child: Stack(
                    fit: StackFit.loose,
                    alignment: Alignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height: 3,
                          color: Colors.black),
                      Container(color: Colors.white, width: 80, child: subtitle)
                    ])))));

/// Company's Name.
Widget company = Builder(
    builder: (context) => FadeIn.text(
        visible: context.select((Go go) => go.state[0].onStart),
        sequence: 6,
        margin: const EdgeInsets.symmetric(vertical: 15.0),
        text: const Text('PT ELCASE SETIA HARAPAN',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 2.5,
                color: Colors.black))));

/// Bottom Arrow.
Widget flags = Builder(
    builder: (context) => FadeIn(
        visible: context.select((Go go) => go.state[0].onStart),
        sequence: 6,
        size: const Size(120, 50),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          for (int x = 0; x < 2; x++)
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: GestureDetector(
                    onTap: () async => launchUrl(
                        Uri.parse('https://ellcase.my.id/${['id', 'ja'][x]}')),
                    child: Image.asset('assets/flag_${['id', 'jp'][x]}.png',
                        width: 50, height: 50)))
        ])));
