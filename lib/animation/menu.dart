import 'package:flutter/material.dart';

class Menu extends CustomPainter {
  Menu({required this.value});
  double value;
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..strokeWidth = 3.5
      ..color = Color.lerp(Colors.black, Colors.white, value)!
      ..style = PaintingStyle.stroke;
    Path top = Path()
      ..moveTo(0, 0)
      ..lineTo(size.width, size.height * value);
    Path bottom = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width, size.height - size.height * value);

    canvas.drawPath(top, paint);
    canvas.drawPath(bottom, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class AnimatedMenu extends StatelessWidget {
  const AnimatedMenu({Key? key, required this.play}) : super(key: key);
  final bool play;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(end: play ? 1 : 0),
      duration: const Duration(milliseconds: 200),
      builder: (context, value, child) => Container(
        width: 40,
        height: 40,
        color: Colors.transparent,
        padding: EdgeInsets.symmetric(
            vertical: 12.5 - 7.5 * value, horizontal: value * 7.5),
        child: CustomPaint(
          painter: Menu(value: value),
        ),
      ),
    );
  }
}
