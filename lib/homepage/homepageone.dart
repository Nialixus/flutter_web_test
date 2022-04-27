import 'package:flutter/material.dart';
import 'package:typewritertext/typewritertext.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:provider/provider.dart';
import 'package:visibility_detector/visibility_detector.dart';

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
    Text animTtl = const Text('ELLCASE',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 68,
          letterSpacing: 5,
        ));

    /// Animated subtitle.
    Text animSbtl = const Text('エルチャセ',
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold));

    return Container(
        constraints: BoxConstraints(minHeight: size.height),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
        child: VisibilityDetector(
          key: const Key('pageOne'),
          onVisibilityChanged: (result) {
            if (result.visibleFraction >= 0.5) {
              context.read<Go>().showPage(0);
            }

            if (result.visibleFraction == 0) {
              context.read<Go>().stopPlay(0);
            }
          },
          child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                logo,
                title(animTtl),
                subtitle(animTtl, animSbtl),
                company,
                flags
              ]),
        ));
  }
}

List<int> sequences = [2, 5, 7];

/// Company's Logo.
Widget logo = Builder(
    builder: (context) => FadeIn(
        play: context.select((Go go) => go.stateEnd[0]),
        visible: context.select((Go go) => go.state[0]),
        sequence: sequences[2],
        size: const Size(150, 150),
        child: Image.asset('assets/logo.png')));

/// Company's Nickname.
Widget title(Text ttl) => Builder(
    builder: (context) => FadeIn(
        play: context.select((Go go) => go.stateEnd[0]),
        sequence: sequences[0],
        visible: context.select((Go go) => go.state[0]),
        child: TypeWriterText(
            play: context.select((Go go) => go.stateEnd[0]),
            text: ttl,
            alignment: Alignment.centerLeft,
            duration: const Duration(milliseconds: 300))));

/// Company's Motto.
Widget subtitle(Text ttl, Text sbtl) => LayoutBuilder(
    builder: (_, constraints) => SizedBox(
        width: ttl.toPainter(constraints).width,
        height: sbtl.toPainter(constraints).height,
        child: Builder(
            builder: (context) => FadeIn(
                play: context.select((Go go) => go.stateEnd[0]),
                visible: context.select((Go go) => go.state[0]),
                sequence: sequences[1],
                child: Stack(
                    fit: StackFit.loose,
                    alignment: Alignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height: 3,
                          color: Colors.black),
                      Container(
                          color: Colors.white,
                          width: 80,
                          child: TypeWriterText(
                              play: context.select((Go go) => go.stateEnd[0]),
                              text: sbtl,
                              alignment: Alignment.center,
                              duration: const Duration(milliseconds: 100)))
                    ])))));

/// Company's Name.
Widget company = Builder(
    builder: (context) => FadeIn.text(
        play: context.select((Go go) => go.stateEnd[0]),
        visible: context.select((Go go) => go.state[0]),
        sequence: sequences[1],
        margin: const EdgeInsets.symmetric(vertical: 15.0),
        text: const Text('PT ELCASE SETIA HARAPAN',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                letterSpacing: 2.5,
                color: Colors.black))));

/// Bottom Arrow.
Widget flags = Builder(
    builder: (context) => FadeIn(
        play: context.select((Go go) => go.stateEnd[0]),
        visible: context.select((Go go) => go.state[0]),
        sequence: sequences[2],
        size: const Size(120, 50),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          for (int x = 0; x < 2; x++)
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Tooltip(
                  message: 'https://ellcase.my.id/${['id', 'ja'][x]}',
                  child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: () async => launchUrl(Uri.parse(
                          'https://ellcase.my.id/${['id', 'ja'][x]}')),
                      child: Image.asset('assets/flag_${['id', 'jp'][x]}.png',
                          width: 50, height: 50)),
                ))
        ])));
