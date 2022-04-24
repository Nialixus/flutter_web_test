import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../homepagewrapper.dart';

export 'go.dart' show Go;

/// State manager of [HomePageWrapper].
class Go with ChangeNotifier {
  /// boolean for initiate widgets to show up.

  /// boolean of drawer isOpen?.
  bool drawer = false;

  /// Initial pixel position of [ScrollController].
  double pixels = 0;

  Map<String, bool> state = {
    'wrapperStart': true,
    'wrapperEnd': false,
    'pageOneStart': true,
    'pageOneEnd': false,
    'pageTwoStart': false,
    'pageTwoEnd': false,
    'pageThreeStart': false,
    'pageThreeEnd': false
  };

  void tapDrawer() {
    drawer = !drawer;
    notifyListeners();
  }

  /// Detect wether page has been built or not.
  void getStart(double newPixels, double tinggi) {
    pixels = newPixels;

    if (pixels >= tinggi * 0.5 && state['pageTwoStart'] == false) {
      state['pageTwoStart'] = true;
      notifyListeners();
    } else if (pixels >= tinggi * 1.5 && state['pageThreeStart'] == false) {
      state['pageThreeStart'] = true;
      notifyListeners();
    }
  }

  /// Navigate directly onpress.
  void onPress(
      ScrollController controller, LogicalKeyboardKey key, double height) {
    if (key == LogicalKeyboardKey.arrowUp) {
      if (pixels > 0) {
        controller.jumpTo(pixels - 100);
      }
    } else if (key == LogicalKeyboardKey.arrowDown) {
      if (pixels < height * 2) {
        controller.jumpTo(pixels + 100);
      }
    }
  }

  /// Animate navigation onTap.
  void onTap(
      ScrollController controller, String key, int index, double height) {
    const Duration duration = Duration(milliseconds: 750);
    const Curve curve = Curves.easeIn;
    double offset = height * (index + (key == 'top' ? -1 : 1));

    controller.animateTo(offset, duration: duration, curve: curve);
  }
}
