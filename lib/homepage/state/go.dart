import 'package:ellcase/homepage/data/animationstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../homepagewrapper.dart';

export 'go.dart' show Go;

/// State manager of [HomePageWrapper].
class Go with ChangeNotifier {
  ScrollController controller = ScrollController(initialScrollOffset: 0.0);

  /// boolean of drawer isOpen?.
  bool drawer = false;

  /// Initial pixel position of [ScrollController].
  double pixels = 0;

  List<AnimationState> state =
      List.generate(3, (x) => AnimationState(onStart: x == 0));

  void tapDrawer() {
    drawer = !drawer;
    notifyListeners();
  }

  /// Detect wether page has been built or not.
  void getStart(double newPixels, double tinggi) {
    pixels = newPixels;

    if (pixels >= tinggi && topButton == false) {
      topButton = true;
      // notifyListeners();
    } else if (pixels < tinggi && topButton == true) {
      topButton = false;
      // notifyListeners();
    }

    if (pixels >= tinggi * 0.5 && state[1].onStart == false) {
      state[1].onStart = true;
      // notifyListeners();
    } else if (pixels >= tinggi * 1.5 && state[2].onStart == false) {
      state[2].onStart = true;
      // notifyListeners();
    }
  }

  void getEnd(int index, bool result) {
    if (result == true) {
      state[index].onEnd = result;
      notifyListeners();
    }
  }

  /// Navigate directly onpress.
  void onPress(LogicalKeyboardKey key, double height) {
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

  bool topButton = false;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
