import 'dart:async';
import 'package:flutter/material.dart';

import '../homepageone.dart';

export '../state/goone.dart' show GoOne;

/// State manager of [HomePageOne].
class GoOne with ChangeNotifier {
  /// Boolean for stating widget has been visible or not.
  List<bool> visible = [false, false, false, false, false, false];

  /// Set visibility.
  void setVisibile() async {
    visible[0] = true;

    Timer.periodic(const Duration(milliseconds: 750), (timer) {
      if (timer.tick >= visible.length) {
        timer.cancel();
      } else {
        visible[timer.tick] = true;
        notifyListeners();
      }
    });
  }
}
