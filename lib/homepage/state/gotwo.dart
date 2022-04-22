import 'package:flutter/material.dart';

import '../homepagetwo.dart';

export '../state/gotwo.dart' show GoTwo;

/// State manager of [HomePageTwo].
class GoTwo with ChangeNotifier {
  /// Boolean for stating widget has been shown or not.
  List<bool> visible = [false, false];

  /// For stating wether animation should play or not.
  bool play = true;

  /// Setting off animation.
  void setPlay() {
    play = false;
    notifyListeners();
  }

  /// Setting widgets visibility.
  void setVisible() async {
    visible[0] = true;

    await Future.delayed(
        Duration(milliseconds: '人をつなぐ。夢を実現する。'.characters.length * 150));
    visible[1] = true;
    notifyListeners();
  }
}
