import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../homepage/homepagewrapper.dart';
import '../homepage/state/go.dart';

/// Run [HomePageWrapper].
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider.value(
      value: Go(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Ellcase',
        home: HomePageWrapper(),
      )));
}
