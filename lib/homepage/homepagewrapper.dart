import 'package:ellcase/homepage/homepagefloatingbutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    Size size = MediaQuery.of(context).size;

    return Scaffold(
        backgroundColor: Colors.white,
        body: RawKeyboardListener(
            focusNode: FocusNode(),
            autofocus: true,
            onKey: (key) =>
                context.read<Go>().onPress(key.logicalKey, size.height),
            child: Stack(children: [
              page(context, size, size.width * 0.01),
              const HomePageFloatingButton()
            ])));
  }
}

/// Displaying homepage pages.
Widget page(BuildContext context, Size size, double thickness) =>
    NotificationListener<ScrollEndNotification>(
        onNotification: (t) {
          context.read<Go>().getStart(t.metrics.extentBefore, size.height);
          return false;
        },
        child: Scrollbar(
            controller: context.read<Go>().controller,
            thickness: thickness,
            isAlwaysShown: true,
            hoverThickness: thickness,
            trackVisibility: true,
            radius: Radius.zero,
            child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                controller: context.read<Go>().controller,
                physics: const BouncingScrollPhysics(),
                child: Column(children: const [
                  HomePageOne(),
                  HomePageTwo(),
                  HomePageThree(),
                ]))));
