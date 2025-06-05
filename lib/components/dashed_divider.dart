import 'package:flutter/material.dart';

class DashedDivider extends StatelessWidget {
  final double height;
  final double dashWidth;
  final double dashSpace;
  final Color color;

  const DashedDivider({
    super.key,
    this.height = 1,
    this.dashWidth = 12,
    this.dashSpace = 12,
    this.color = const Color(0xFF828282),
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, height),
      painter: _DashedLinePainter(
        dashWidth: dashWidth,
        dashSpace: dashSpace,
        color: color,
        height: height,
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final double dashWidth;
  final double dashSpace;
  final double height;
  final Color color;

  _DashedLinePainter({
    required this.dashWidth,
    required this.dashSpace,
    required this.color,
    required this.height,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = height;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(_DashedLinePainter oldDelegate) => false;
}
