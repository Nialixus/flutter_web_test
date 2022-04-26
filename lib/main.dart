import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../homepage/homepageone.dart';
import '../homepage/homepagetwo.dart';
import '../homepage/homepagethree.dart';
import '../homepage/homepagefour.dart';
import '../homepage/homepagewrapper.dart';
import '../homepage/state/go.dart';
import 'addons/boxgetter.dart';

/// Run [HomePageWrapper].
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SizeGetter());
}

class SizeGetter extends StatefulWidget {
  const SizeGetter({Key? key}) : super(key: key);

  @override
  _SizeGetterState createState() => _SizeGetterState();
}

class _SizeGetterState extends State<SizeGetter> {
  @override
  Widget build(BuildContext context) {
    List<Size> sizes = [];
    List<Widget> widgets = [
      for (int x = 0; x < 4; x++)
        WidgetSize(
            onChange: (size) {
              setState(() {
                sizes.add(size);
              });
            },
            child: const [
              HomePageOne(),
              HomePageTwo(),
              HomePageThree(),
              HomePageFour()
            ][x])
    ];

    return ChangeNotifierProvider.value(
        value: Go(pageList: widgets),
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Ellcase',
          home: HomePageWrapper(),
        ));
  }
}
