import 'package:ellcase/addons/fadein.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../animation/menu.dart';
import '../homepage/homepageone.dart';
import '../homepage/homepagetwo.dart';
import '../homepage/homepagethree.dart';
import '../homepage/state/go.dart';

export '../homepage/homepagewrapper.dart' show HomePageWrapper;

/// Widget wrapper of entire homepages.
class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// MediaQuery's width & height.
    Size size = Size(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);

    /// Scrollbar thickness.
    double thickness = size.width * 0.01;

    /// Column controller.
    ScrollController controller = ScrollController(initialScrollOffset: 0.0);

    /// Provider function.
    Go go = Provider.of<Go>(context, listen: false);

    return Scaffold(
        backgroundColor: Colors.white,
        body: RawKeyboardListener(
            focusNode: FocusNode(),
            autofocus: true,
            onKey: (key) => go.onPress(controller, key.logicalKey, size.height),
            child: Stack(children: [
              page(size, thickness, go, controller),
              floatLeft,
              floatDrawer,
              floatRight(thickness)
            ])));
  }
}

Widget floatDrawer = Consumer<Go>(builder: (_, go, ___) {
  return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      right: go.drawer ? 0 : -300,
      top: 0,
      bottom: 0,
      width: 300,
      child: Container(
          color: Colors.black,
          child: Column(children: [
            const SizedBox(height: kToolbarHeight * 0.2 + 40),
            for (int x = 0; x < 2; x++)
              Padding(
                  padding: const EdgeInsets.only(top: kToolbarHeight * 0.5),
                  child: Text(['HOME', 'DAFTAR PROGRAM'][x],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w100,
                          fontSize: 28))),
            Expanded(
                child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Image.asset('assets/logo.png',
                      width: 60, height: 60, color: Colors.white),
                  const Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: kToolbarHeight * 0.2),
                      child: Text('PT ELCASE SETIA HARAPAN',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w100))),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: contacts(Axis.horizontal)..removeAt(0))
                ]))
          ])));
});

Widget floatRight(double thickness) => Positioned(
    top: 0,
    right: 0,
    child: FadeIn(
        sequence: 5,
        onFinish: (b) => print(b),
        child: Consumer<Go>(builder: (_, go, ___) {
          return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              alignment: Alignment.center,
              width: go.drawer ? 300 : kToolbarHeight * 0.8,
              margin: EdgeInsets.only(
                  right: go.drawer ? 0 : thickness + kToolbarHeight * 0.2),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () => go.tapDrawer(),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kToolbarHeight * 0.2),
                            child: AnimatedMenu(play: go.drawer))),
                    Visibility(
                        visible: !go.drawer,
                        child: Container(
                            width: 40,
                            height: 40,
                            color: Colors.black,
                            child: const Icon(Icons.keyboard_arrow_up_sharp,
                                color: Colors.white)))
                  ]));
        })));

final Widget floatLeft = Positioned(
    left: 0,
    top: 0,
    bottom: 0,
    width: kToolbarHeight,
    child:
        FadeIn(sequence: 5, child: Column(children: contacts(Axis.vertical))));

List<Widget> contacts(Axis axis) => [
      ['0', 'Ellcase', 'https://ellcase.my.id', 'logo'],
      ['1', 'Telephone', 'tel:+6281282099920', 'telp'],
      ['2', 'Whatsapp', 'http://wa.me/6281282099920', 'wa'],
      ['3', 'Line', 'https://page.line.me/?accountId=038zztvh', 'line'],
      ['4', 'Email', 'mailto:id.ellcase@gmail.com', 'mail']
    ]
        .map((e) => Padding(
            padding: axis == Axis.vertical
                ? const EdgeInsets.only(top: kToolbarHeight * 0.1)
                : const EdgeInsets.symmetric(horizontal: kToolbarHeight * 0.1),
            child: Tooltip(
                message: e[1],
                child: InkWell(
                    onTap: () async => await launchUrl(Uri.parse(e[2])),
                    customBorder: const CircleBorder(),
                    child: Image.asset('assets/${e[3]}.png',
                        width: 40,
                        height: 40,
                        color: axis == Axis.vertical
                            ? (e[0] == '0' ? Colors.red : Colors.black)
                            : Colors.white)))))
        .toList();

/// Displaying homepage pages.
Widget page(Size size, double thickness, Go go, ScrollController controller) =>
    NotificationListener<ScrollEndNotification>(
        onNotification: (t) {
          go.getStart(controller.position.pixels, size.height);
          return false;
        },
        child: Scrollbar(
            controller: controller,
            thickness: thickness,
            isAlwaysShown: true,
            hoverThickness: thickness,
            trackVisibility: true,
            radius: Radius.zero,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                controller: controller,
                physics: const BouncingScrollPhysics(),
                child: Column(children: [
                  Consumer<Go>(
                      builder: (_, goVal, ___) =>
                          HomePageOne(done: goVal.state.pageOneEnd, go: go)),
                  const HomePageTwo(),
                  const HomePageThree()
                ]))));
