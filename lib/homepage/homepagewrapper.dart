import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/go.dart';
import 'pageone.dart';
import 'subpage2.dart';
import 'subpage3.dart';

/// Widget wrapper of entire homepages.
class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Size(
        MediaQuery.of(context).size.width, MediaQuery.of(context).size.height);
    double thickness = size.width * 0.01;
    ScrollController controller = ScrollController(initialScrollOffset: 0.0);

    return Scaffold(
        backgroundColor: Colors.white,
        body: ChangeNotifierProvider(
          create: (context) => Go(),
          builder: (goContext, goChild) {
            Go go = Provider.of<Go>(goContext, listen: false);

            return RawKeyboardListener(
              focusNode: FocusNode(),
              autofocus: true,
              onKey: (key) =>
                  go.onPress(controller, key.logicalKey, size.height),
              child: Stack(
                children: [
                  scrollbarBackground(thickness),
                  page(size, thickness, go, controller)
                ],
              ),
            );
          },
        ));
  }
}

Widget page(Size size, double thickness, Go go, ScrollController controller) {
  GestureDetector Function(Widget child) onTap(int index, String key) {
    return (child) => GestureDetector(
          onTap: () => go.onTap(controller, key, index, size.height),
          child: child,
        );
  }

  List<Widget> homePages(Go goVal) => [
        PageOne(bottomClick: onTap(0, 'bottom')),
        SubPage2(bottomClick: onTap(1, 'bottom'), topClick: onTap(1, 'top')),
        SubPage3(topClick: onTap(2, 'top'))
      ].asMap().entries.map((e) {
        return Container(
            width: size.width,
            height: size.height,
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.2),
            alignment: Alignment.center,
            child: goVal.built[e.key] == true ? e.value : const SizedBox());
      }).toList();

  return NotificationListener<ScrollEndNotification>(
    onNotification: (t) {
      go.getPost(controller.position.pixels, size.height);
      return false;
    },
    child: RawScrollbar(
      controller: controller,
      thickness: thickness,
      thumbColor: const Color(0xffD52438),
      isAlwaysShown: true,
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          controller: controller,
          physics: const BouncingScrollPhysics(),
          child: Consumer<Go>(
              builder: (goCon, goVal, goChi) => Column(
                  children: List.generate(homePages(goVal).length,
                      (index) => homePages(goVal)[index])))),
    ),
  );
}

Widget scrollbarBackground(double thickness) => Positioned(
    top: 0,
    bottom: 0,
    right: 0,
    width: thickness,
    child: Container(
      color: const Color(0xff222222).withOpacity(0.1),
    ));
