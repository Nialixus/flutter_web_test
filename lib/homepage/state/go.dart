import 'package:ellcase/addons/boxgetter.dart';
import 'package:ellcase/homepage/data/animationstate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../homepagewrapper.dart';

export 'go.dart' show Go;

/// State manager of [HomePageWrapper].
class Go with ChangeNotifier {
  Go({required this.pageList});
  final List<Widget> pageList;

  ScrollController controller = ScrollController(initialScrollOffset: 0.0);

  /// boolean of drawer isOpen?.
  bool drawer = false;

  /// Initial pixel position of [ScrollController].
  double pixels = 0;

  List<AnimationState> get state => List.generate(
      pageList.length, (x) => AnimationState(onStart: x == 0, onEnd: false));

  List<Size> sizes = [];

  void addSizes(Size size) {
    sizes.add(size);
    notifyListeners();
  }

  void tapDrawer() {
    drawer = !drawer;
    notifyListeners();
  }

  /// Detect wether page has been built or not.
  void getStart(double newPixels, double tinggi) {
    pixels = newPixels;

    if (pixels >= tinggi && topButton == false) {
      topButton = true;
      notifyListeners();
    } else if (pixels < tinggi && topButton == true) {
      topButton = false;
      notifyListeners();
    }

    for (int x = 1; x < state.length; x++) {
      if (pixels >= tinggi * (x - 0.25) && state[x].onStart == false) {
        state[x].onStart = true;
        notifyListeners();
      }
    }
  }

  void toTop() {
    controller.animateTo(0.0,
        duration: const Duration(milliseconds: 750), curve: Curves.easeIn);
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
