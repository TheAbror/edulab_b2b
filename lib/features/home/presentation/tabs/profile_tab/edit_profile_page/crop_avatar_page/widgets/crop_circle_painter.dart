import 'package:edulab_b2b/widget_imports.dart';

/// Washes out everything outside the crop circle and draws the ring around it.
class CropCirclePainter extends CustomPainter {
  final double diameter;
  final Color scrimColor;
  final Color ringColor;

  const CropCirclePainter({
    required this.diameter,
    required this.scrimColor,
    required this.ringColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = diameter / 2;

    // Even-odd on a path holding both the full rect and the circle leaves the
    // circle untouched and covers the rest.
    final scrim = Path()
      ..addRect(Offset.zero & size)
      ..addOval(Rect.fromCircle(center: center, radius: radius))
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(scrim, Paint()..color = scrimColor);

    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3
        ..color = ringColor,
    );
  }

  @override
  bool shouldRepaint(CropCirclePainter oldDelegate) =>
      oldDelegate.diameter != diameter ||
      oldDelegate.scrimColor != scrimColor ||
      oldDelegate.ringColor != ringColor;
}
