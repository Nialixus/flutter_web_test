import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

export 'go.dart' hide Go;

class Go with ChangeNotifier {
  /// boolean for stating widget has been built or not.
  List<bool> built = [true, false, false];

  /// Initial pixel position of [ScrollController].
  double pixels = 0;

  /// Detect wether page has been built or not.
  void getPost(double newPixels, double tinggi) {
    pixels = newPixels;

    if (pixels >= tinggi * 0.5 && built[1] == false) {
      built[1] = true;
      notifyListeners();
    } else if (pixels >= tinggi * 1.5 && built[2] == false) {
      built[2] = true;
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
