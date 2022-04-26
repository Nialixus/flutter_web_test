import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../homepage/homepageone.dart';
import '../homepage/homepagetwo.dart';
import '../homepage/homepagethree.dart';
import '../homepage/homepagefour.dart';
import '../homepage/homepagewrapper.dart';
import '../homepage/state/go.dart';
import '../addons/boxgetter.dart';

/// Run [HomePageWrapper].
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider.value(
      value: Go(pageList: [
        BoxGetter(
            child: HomePageOne(
          key: GlobalKey(),
        )),
        const HomePageTwo(),
        const HomePageThree(),
        const HomePageFour()
      ]),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ellcase',
        home: HomePageWrapper(),
      )));
}
