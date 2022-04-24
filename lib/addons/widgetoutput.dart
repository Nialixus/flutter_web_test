import 'package:flutter/material.dart';

class WidgetOutput extends StatefulWidget {
  const WidgetOutput({Key? key, required this.builder}) : super(key: key);
  final Widget Function(GlobalKey key, Size? size) builder;

  @override
  State<WidgetOutput> createState() => _WidgetOutputState();
}

class _WidgetOutputState extends State<WidgetOutput> {
  GlobalKey key = GlobalKey();

  Size? size;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((d) => setState(() =>
        size = (key.currentContext?.findRenderObject() as RenderBox).size));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.builder(key, size);
  }
}
