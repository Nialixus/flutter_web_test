import 'package:flutter/material.dart';

class BoxGetter extends StatelessWidget {
  const BoxGetter({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
  }
}
