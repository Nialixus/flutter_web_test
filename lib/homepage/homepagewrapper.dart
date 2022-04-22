import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../homepage/homepageone.dart';
import '../homepage/homepagetwo.dart';
import '../homepage/state/go.dart';
import 'homepagethree.dart';

export '../homepage/homepagewrapper.dart' show HomePageWrapper;

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
                children: [page(size, thickness, go, controller), floatLeft()],
              ),
            );
          },
        ));
  }
}

Widget floatLeft() => Positioned(
      left: 0,
      top: 0,
      bottom: 0,
      width: kToolbarHeight,
      child: Column(
        children: [
          for (int x = 0; x < 5; x++)
            Padding(
              padding: const EdgeInsets.only(top: kToolbarHeight * 0.1),
              child: Tooltip(
                message: [
                  'Ellcase',
                  'Telephone',
                  'Whatsapp',
                  'Line',
                  'Email'
                ][x],
                child: InkWell(
                  onTap: () {},
                  customBorder: const CircleBorder(),
                  child: Image.asset(
                    'assets/${['logo', 'telp', 'wa', 'line', 'mail'][x]}.png',
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
            )
        ],
      ),
    );

/// Displaying homepage pages.
Widget page(Size size, double thickness, Go go, ScrollController controller) {
  /// Shortcut function to animated navigation.
  GestureDetector Function(Widget child) onTap(int index, String key) {
    return (child) => GestureDetector(
          onTap: () => go.onTap(controller, key, index, size.height),
          child: child,
        );
  }

  /// List of pages in homepage.
  List<Widget> homePages(Go goVal) => [
        HomePageOne(onBottom: onTap(0, 'bottom')),
        HomePageTwo(onBottom: onTap(1, 'bottom'), onTop: onTap(1, 'top')),
        HomePageThree(onTop: onTap(2, 'top'))
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
          child: Consumer<Go>(
              builder: (goCon, goVal, goChi) => Column(
                  children: List.generate(homePages(goVal).length,
                      (index) => homePages(goVal)[index])))),
    ),
  );
}
