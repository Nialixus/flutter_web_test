import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Arrow extends StatelessWidget {
  const Arrow({Key? key, required this.duration, this.curve, this.color})
      : super(key: key);
  final Duration duration;
  final Curve? curve;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ArrowState(),
      builder: (providerContext, providerChild) {
        Provider.of<ArrowState>(providerContext, listen: false)
            .isPlay(duration);

        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int x = 0; x < 2; x++)
              Consumer<ArrowState>(
                builder: (context, value, child) => AnimatedOpacity(
                    duration: duration,
                    curve: curve ?? Curves.linear,
                    opacity: value.play[x] == true ? 1 : 0,
                    child: child),
                child: SizedBox(
                  width: 40,
                  height: 10,
                  child: CustomPaint(painter: ArrowHead(color: color)),
                ),
              ),
          ],
        );
      },
    );
  }
}

class ArrowHead extends CustomPainter {
  ArrowHead({this.color});
  final Color? color;

  @override
  void paint(Canvas canvas, Size size) => canvas.drawPath(
      Path()
        ..moveTo(0, 0)
        ..lineTo(size.width / 2, size.height)
        ..lineTo(size.width, 0),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..color = color ?? Colors.black);

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class ArrowState with ChangeNotifier {
  List<bool> play = [false, false];
  void isPlay(Duration duration) {
    Timer.periodic(duration, (timer) {
      if (timer.tick.isEven) {
        play[0] = true;
        play[1] = false;
      } else {
        play[0] = false;
        play[1] = true;
      }
      notifyListeners();
    });
  }
}
