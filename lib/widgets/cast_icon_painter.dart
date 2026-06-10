import 'package:flutter/material.dart';

class CastIconPainter extends CustomPainter {
  const CastIconPainter({this.color = Colors.white, this.strokeWidth = 2.0});

  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;

    // TV body
    final tvLeft = w * 0.08;
    final tvTop = h * 0.06;
    final tvWidth = w * 0.72;
    final tvHeight = h * 0.52;
    final tvRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(tvLeft, tvTop, tvWidth, tvHeight),
      Radius.circular(w * 0.04),
    );
    canvas.drawRRect(tvRect, paint);

    // TV stand
    canvas.drawLine(
      Offset(w * 0.44, tvTop + tvHeight),
      Offset(w * 0.44, h * 0.68),
      paint,
    );
    canvas.drawLine(
      Offset(w * 0.32, h * 0.68),
      Offset(w * 0.56, h * 0.68),
      paint,
    );

    // Wi-Fi arcs on TV screen
    final wifiCenter = Offset(tvLeft + tvWidth * 0.5, tvTop + tvHeight * 0.42);
    _drawWifi(canvas, paint, wifiCenter, w * 0.06);

    // Phone outline
    final phoneLeft = w * 0.52;
    final phoneTop = h * 0.38;
    final phoneWidth = w * 0.38;
    final phoneHeight = h * 0.52;
    final phoneRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(phoneLeft, phoneTop, phoneWidth, phoneHeight),
      Radius.circular(w * 0.05),
    );
    canvas.drawRRect(phoneRect, paint);

    // Play triangle on phone
    final playCenter = Offset(
      phoneLeft + phoneWidth * 0.52,
      phoneTop + phoneHeight * 0.48,
    );
    final playPath = Path()
      ..moveTo(playCenter.dx - w * 0.04, playCenter.dy - w * 0.05)
      ..lineTo(playCenter.dx + w * 0.06, playCenter.dy)
      ..lineTo(playCenter.dx - w * 0.04, playCenter.dy + w * 0.05)
      ..close();
    canvas.drawPath(playPath, fillPaint);
  }

  void _drawWifi(Canvas canvas, Paint paint, Offset center, double unit) {
    for (var i = 1; i <= 3; i++) {
      final radius = unit * i * 1.1;
      final rect = Rect.fromCircle(center: center, radius: radius);
      canvas.drawArc(rect, -2.4, 1.8, false, paint);
    }
    canvas.drawCircle(
      Offset(center.dx, center.dy + unit * 0.8),
      unit * 0.25,
      paint..style = PaintingStyle.fill,
    );
    paint.style = PaintingStyle.stroke;
  }

  @override
  bool shouldRepaint(covariant CastIconPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
  }
}

class CastIcon extends StatelessWidget {
  const CastIcon({
    super.key,
    this.size = 80,
    this.color = Colors.white,
    this.strokeWidth = 2.0,
  });

  final double size;
  final Color color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(size, size),
      painter: CastIconPainter(color: color, strokeWidth: strokeWidth),
    );
  }
}
