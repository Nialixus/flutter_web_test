import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../homepageone.dart';
import '../homepagetwo.dart';
import '../homepagethree.dart';
import '../homepagefour.dart';
import '../homepagewrapper.dart';

export 'go.dart' show Go;

/// State manager of [HomePageWrapper].
class Go with ChangeNotifier {
  List<Widget> pageList = const [
    HomePageOne(),
    HomePageTwo(),
    HomePageThree(),
    HomePageFour()
  ];

  ScrollController controller = ScrollController(initialScrollOffset: 0.0);

  /// boolean of drawer isOpen?.
  bool drawer = false;

  /// Initial pixel position of [ScrollController].
  double pixels = 0;

  late List<bool> state = [
    for (int x = 0; x < pageList.length; x++) false,
  ];

  late List<bool> stateEnd = [for (int x = 0; x < pageList.length; x++) true];

  void tapDrawer() {
    drawer = !drawer;
    notifyListeners();
  }

  /// Detect wether page has been built or not.
  void showButton(double newPixels, double tinggi) {
    pixels = newPixels;

    if (pixels >= tinggi && topButton == false) {
      topButton = true;
      notifyListeners();
    } else if (pixels < tinggi && topButton == true) {
      topButton = false;
      notifyListeners();
    }
  }

  void showPage(int index) {
    if (state[index] == false) {
      state[index] = true;
      notifyListeners();
    }
  }

  void stopPlay(int index) {
    if (stateEnd[index] == true) {
      stateEnd[index] = false;
      notifyListeners();
    }
  }

  void toTop() {
    controller.animateTo(0.0,
        duration: const Duration(milliseconds: 750), curve: Curves.easeIn);
  }

  /// Navigate directly onpress.
  void onPress(LogicalKeyboardKey key, double height) {
    if (key == LogicalKeyboardKey.arrowUp) {
      if (pixels > controller.position.minScrollExtent) {
        controller.jumpTo(pixels - 100);
      }
    } else if (key == LogicalKeyboardKey.arrowDown) {
      if (pixels < controller.position.maxScrollExtent) {
        controller.jumpTo(pixels + 100);
      }
    }
  }

  bool topButton = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
