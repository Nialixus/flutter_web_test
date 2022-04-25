import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../addons/fadein.dart';
import '../animation/menu.dart';
import 'data/data.dart';
import 'state/go.dart';

class HomePageFloatingButton extends StatelessWidget {
  const HomePageFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      alignment: Alignment.center,
      child: Row(
        children: [
          floatLeft,
          const Expanded(child: SizedBox()),
          floatRight(context, size.width * 0.01)
        ],
      ),
    );
  }
}

Widget floatDrawer = Consumer<Go>(
    builder: (_, go, ___) => AnimatedPositioned(
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

Widget floatRight(BuildContext context, double thickness) => Consumer<Go>(
    builder: (_, go, ___) => AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        width: go.drawer ? 300 : kToolbarHeight * 0.8,
        margin: EdgeInsets.only(
            right: go.drawer ? 0 : thickness + kToolbarHeight * 0.2),
        child: ___!),
    child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
      GestureDetector(
          onTap: () => context.read<Go>().tapDrawer(),
          child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: kToolbarHeight * 0.2),
              child: Consumer<Go>(
                  builder: (_, go, ___) => FadeIn(
                      visible: go.state[0].onStart,
                      sequence: 5,
                      child: AnimatedMenu(play: go.drawer))))),
      Consumer<Go>(
          builder: (_, go, child) =>
              FadeIn(visible: go.drawer ? false : go.topButton, child: child!),
          child: InkWell(
              onTap: () => context.read<Go>().controller.animateTo(0.0,
                  duration: const Duration(milliseconds: 750),
                  curve: Curves.easeIn),
              child: Container(
                  width: 40,
                  height: 40,
                  color: Colors.black,
                  child: const Icon(Icons.keyboard_arrow_up_sharp,
                      color: Colors.white))))
    ]));

Widget floatLeft = SizedBox(
  width: kToolbarHeight,
  child: Consumer<Go>(
      builder: (_, go, child) =>
          FadeIn(sequence: 5, visible: go.state[0].onStart, child: child!),
      child: Column(children: contacts(Axis.vertical))),
);
