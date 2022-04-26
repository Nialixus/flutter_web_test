import 'package:ellcase/homepage/homepagefloatingbutton.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../homepage/state/go.dart';

export '../homepage/homepagewrapper.dart' show HomePageWrapper;

/// Widget wrapper of entire homepages.
class HomePageWrapper extends StatelessWidget {
  const HomePageWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final columnKey = GlobalKey();

    _scrollToCurrentProgress(columnKey, scrollController);

    /// MediaQuery's width & height.
    Size size = MediaQuery.of(context).size;
    Go go = Provider.of<Go>(context, listen: false);

    return Scaffold(
        backgroundColor: Colors.white,
        body: RawKeyboardListener(
            focusNode: FocusNode(),
            autofocus: true,
            onKey: (key) => go.onPress(key.logicalKey, size.height),
            child: Stack(children: [
              NotificationListener<ScrollEndNotification>(
                  onNotification: (t) {
                    context
                        .read<Go>()
                        .getStart(t.metrics.extentBefore, size.height);
                    return false;
                  },
                  child: Scrollbar(
                      controller: go.controller,
                      thickness: size.width * 0.01,
                      isAlwaysShown: true,
                      hoverThickness: size.width * 0.01,
                      trackVisibility: true,
                      radius: Radius.zero,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          controller: go.controller,
                          physics: const BouncingScrollPhysics(),
                          child: Column(children: go.pageList)))),
              const HomePageFloatingButton()
            ])));
  }

  void _scrollToCurrentProgress(GlobalKey<State<StatefulWidget>> columnKey,
      ScrollController scrollController) {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      final RenderBox? renderBoxRed =
          columnKey.currentContext?.findRenderObject() as RenderBox?;
      double height = renderBoxRed?.size.height ?? 0;
      scrollController.animateTo(0 * height,
          duration: const Duration(seconds: 1), curve: Curves.decelerate);
    });
  }
}
