import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../homepage/homepagewrapper.dart';
import 'homepage/state/go.dart';

/// Run [HomePageWrapper].
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ellcase',
      home: ChangeNotifierProvider(
          create: (c) => Go(), child: const HomePageWrapper())));
}
