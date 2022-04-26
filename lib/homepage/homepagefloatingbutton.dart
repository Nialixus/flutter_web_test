import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../addons/fadein.dart';
import '../animation/menu.dart';
import '../homepage/data/data.dart';
import '../homepage/state/go.dart';

class HomePageFloatingButton extends StatelessWidget {
  const HomePageFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
        width: size.width,
        height: size.height,
        alignment: Alignment.center,
        child: Builder(
            builder: (context) => FadeIn(
                sequence: 8,
                visible: context.select((Go go) => go.state[0].onStart),
                child: Stack(children: [bottom, top(context)]))));
  }
}

Widget bottom = Builder(
    builder: (context) => AnimatedPositioned(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeIn,
        width: 300,
        top: 0,
        bottom: 0,
        right: context.select((Go go) => go.drawer) ? 0 : -300,
        child: Container(
            color: Colors.black,
            child: Column(children: [
              for (int x = 0; x < 2; x++)
                Padding(
                    padding: EdgeInsets.only(
                      top: kToolbarHeight * 0.5 +
                          (x == 0 ? kToolbarHeight * 0.2 + 40 : 0),
                    ),
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
                        padding: EdgeInsets.symmetric(
                            vertical: kToolbarHeight * 0.2),
                        child: Text('PT ELCASE SETIA HARAPAN',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w100))),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: contacts(Axis.horizontal)..removeAt(0))
                  ]))
            ]))));

Widget top(BuildContext context) => Positioned(
    left: 0,
    top: 0,
    bottom: 0,
    right: 0,
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      SizedBox(
          width: kToolbarHeight,
          child: Column(children: contacts(Axis.vertical))),
      const Expanded(child: SizedBox()),
      Builder(
          builder: (go) => AnimatedContainer(
              alignment: Alignment.center,
              duration: const Duration(milliseconds: 200),
              width: go.select((Go go) => go.drawer) ? 300 : kToolbarHeight,
              margin: EdgeInsets.only(
                  right: go.select((Go go) => go.drawer)
                      ? 0
                      : MediaQuery.of(context).size.width * 0.01 + 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                        onTap: () {
                          context.read<Go>().tapDrawer();
                        },
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: kToolbarHeight * 0.2),
                            child: Builder(
                                builder: (context) => AnimatedMenu(
                                    play: context
                                        .select((Go go) => go.drawer))))),
                    FadeIn(
                        visible: go.select((Go go) =>
                            go.drawer == true ? false : go.topButton),
                        child: InkWell(
                            onTap: () {
                              context.read<Go>().toTop();
                            },
                            child: Container(
                                width: 40,
                                height: 40,
                                color: Colors.black,
                                child: const Icon(Icons.keyboard_arrow_up_sharp,
                                    color: Colors.white))))
                  ])))
    ]));
