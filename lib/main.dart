import 'package:ellcase/homepage/subpage1.dart';
import 'package:ellcase/homepage/subpage2.dart';
import 'package:ellcase/homepage/subpage3.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MaterialApp(title: 'Ellcase', home: Index()));
}

class Index extends StatelessWidget {
  const Index({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double lebar = MediaQuery.of(context).size.width;
    double tinggi = MediaQuery.of(context).size.height;
    ScrollController kendali = ScrollController(initialScrollOffset: 0.0);

    return Scaffold(
        backgroundColor: Colors.white,
        body: ChangeNotifierProvider(
          create: (context) => IndexProvider(),
          builder: (providerContext, providerChild) {
            IndexProvider provider =
                Provider.of<IndexProvider>(providerContext, listen: false);

            return RawKeyboardListener(
              focusNode: FocusNode(),
              autofocus: true,
              onKey: (event) {
                if (event.isKeyPressed(LogicalKeyboardKey.arrowDown)) {
                  provider.onBottomPress(controller: kendali, height: tinggi);
                } else if (event.isKeyPressed(LogicalKeyboardKey.arrowUp)) {
                  provider.onTopPress(controller: kendali, height: tinggi);
                }
              },
              child: Stack(
                children: [
                  Positioned(
                      top: 0,
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 12.5,
                        color: const Color(0xff222222).withOpacity(0.1),
                      )),
                  NotificationListener(
                    onNotification: (t) {
                      if (t is ScrollEndNotification) {
                        provider.changePixels(kendali.position.pixels, tinggi);
                      }
                      return false;
                    },
                    child: RawScrollbar(
                      controller: kendali,
                      thickness: 12.5,
                      thumbColor: const Color(0xffD52438),
                      isAlwaysShown: true,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          controller: kendali,
                          physics: const BouncingScrollPhysics(),
                          child: Consumer<IndexProvider>(
                              builder: (context, value, child) =>
                                  Column(children: [
                                    for (int index = 0; index < 3; index++)
                                      Container(
                                          width: lebar,
                                          height: tinggi,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: lebar * 0.2),
                                          alignment: Alignment.center,
                                          child: [
                                            value.built[0] == true
                                                ? SubPage1(
                                                    bottomClick: (child) =>
                                                        GestureDetector(
                                                          onTap: () => provider
                                                              .onBottomTap(
                                                                  index: index,
                                                                  controller:
                                                                      kendali,
                                                                  height:
                                                                      tinggi),
                                                          child: child,
                                                        ))
                                                : const SizedBox(),
                                            value.built[1] == true
                                                ? SubPage2(
                                                    bottomClick: (child) =>
                                                        GestureDetector(
                                                          onTap: () => provider
                                                              .onBottomTap(
                                                                  index: index,
                                                                  controller:
                                                                      kendali,
                                                                  height:
                                                                      tinggi),
                                                          child: child,
                                                        ),
                                                    topClick: (child) =>
                                                        GestureDetector(
                                                          onTap: () =>
                                                              provider.onTopTap(
                                                                  index: index,
                                                                  controller:
                                                                      kendali,
                                                                  height:
                                                                      tinggi),
                                                          child: child,
                                                        ))
                                                : const SizedBox(),
                                            value.built[2] == true
                                                ? SubPage3(
                                                    topClick: (child) =>
                                                        GestureDetector(
                                                          onTap: () =>
                                                              provider.onTopTap(
                                                                  index: index,
                                                                  controller:
                                                                      kendali,
                                                                  height:
                                                                      tinggi),
                                                          child: child,
                                                        ))
                                                : const SizedBox(),
                                          ][index])
                                  ]))),
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}

class IndexProvider with ChangeNotifier {
  List<bool> built = [true, false, false];
  double pixels = 0;
  void changePixels(double newPixels, double tinggi) {
    pixels = newPixels;
    if (pixels >= tinggi * 0.5 && built[1] == false) {
      built[1] = true;
      notifyListeners();
    } else if (pixels >= tinggi * 1.5 && built[2] == false) {
      built[2] = true;
      notifyListeners();
    }
  }

  void onBottomPress(
      {required ScrollController controller, required double height}) {
    if (pixels < height * 2) {
      controller.jumpTo(pixels + 100);
    }
  }

  void onTopPress(
      {required ScrollController controller, required double height}) {
    if (pixels > 0) {
      controller.jumpTo(pixels - 100);
    }
  }

  void onBottomTap(
      {required int index,
      required ScrollController controller,
      required double height}) {
    controller.animateTo(height * (1 + index),
        duration: const Duration(milliseconds: 750), curve: Curves.easeIn);
  }

  void onTopTap(
      {required int index,
      required ScrollController controller,
      required double height}) {
    controller.animateTo(height * (index - 1),
        duration: const Duration(milliseconds: 750), curve: Curves.easeIn);
  }
}
