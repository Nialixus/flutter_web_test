import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../homepage/homepagewrapper.dart';
import '../homepage/state/go.dart';

/// Run [HomePageWrapper].
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  compute<Widget, void>(
      runApp,
      ChangeNotifierProvider.value(
          value: Go(),
          child: const MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Ellcase',
              home: HomePageWrapper())));
}
