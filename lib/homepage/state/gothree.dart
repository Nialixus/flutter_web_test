import 'package:flutter/material.dart';

import '../homepagethree.dart';

export '../state/goThree.dart' show GoThree;

/// State manager of [HomePageThree].
class GoThree with ChangeNotifier {
  List<bool> visible = [false, false];
  bool play = true;

  void setPlay() {
    play = false;
    notifyListeners();
  }

  void setVisible() async {
    visible[0] = true;

    await Future.delayed(Duration(
        milliseconds:
            'PT ELCASE SETIA HARAPANは外国人技能実習制度に基づくインドネシアの送り出し機関です。日本での技能修得を希望するインドネシア人の若者たちを募集し、日本語講習・事前講習の修了後、監理団体を通じて実習実施機関（採用企業）へ実習生を紹介します。採用企業への実績に基づいたアドバイス、実習期間中の日本語学習や技能習得も支援します。'
                    .characters
                    .length *
                50));
    visible[1] = true;
    notifyListeners();
  }
}
