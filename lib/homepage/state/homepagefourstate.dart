import 'package:flutter/material.dart';

class GoFourOne with ChangeNotifier {
  bool open = false;

  void onTap() {
    open = !open;
    notifyListeners();
  }
}

class GoFourTwo with ChangeNotifier {
  bool open = false;

  void onTap() {
    open = !open;
    notifyListeners();
  }
}

class GoFourThree with ChangeNotifier {
  bool open = false;

  void onTap() {
    open = !open;
    notifyListeners();
  }
}

class GoFourFour with ChangeNotifier {
  bool open = false;

  void onTap() {
    open = !open;
    notifyListeners();
  }
}

class GoFourFive with ChangeNotifier {
  bool open = false;

  void onVisible() {
    open = true;
    notifyListeners();
  }
}
