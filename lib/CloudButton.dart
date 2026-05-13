import 'package:flutter/material.dart';

class CloudButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? child;
  final double width;
  final double height;
  final Color color;
  final EdgeInsets padding;

  const CloudButton({
    Key? key,
    required this.onPressed,
    this.child,
    this.width = 160,
    this.height = 100,
    this.color = Colors.white,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(height), // for splash clipping
          onTap: onPressed,
          child: CustomPaint(
            painter: _CloudPainter(color),
            child: Padding(
              padding: padding,
              child: Center(child: child),
            ),
          ),
        ),
      ),
    );
  }
}

class _CloudPainter extends CustomPainter {
  final Color color;
  _CloudPainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..style = PaintingStyle.fill..isAntiAlias = true;

    // Basic cloud made from overlapping circles and a rounded rect
    final double w = size.width;
    final double h = size.height;

    final Path path = Path();

    // Left circle
    path.addOval(Rect.fromCircle(center: Offset(w * 0.25, h * 0.55), radius: h * 0.28));
    // Middle-left circle
    path.addOval(Rect.fromCircle(center: Offset(w * 0.43, h * 0.40), radius: h * 0.32));
    // Middle-right circle
    path.addOval(Rect.fromCircle(center: Offset(w * 0.65, h * 0.45), radius: h * 0.30));
    // Right circle
    path.addOval(Rect.fromCircle(center: Offset(w * 0.82, h * 0.60), radius: h * 0.22));
    // Bottom rounded rectangle to smooth underside
    final RRect base = RRect.fromLTRBR(
      w * 0.12,
      h * 0.55,
      w * 0.88,
      h * 0.90,
      Radius.circular(h * 0.22),
    );
    path.addRRect(base);

    // Combine using union via canvas drawPath with even-odd fill to ensure smooth merging
    canvas.drawPath(Path.combine(PathOperation.union, path, Path()), paint);

    // Optional subtle border
    final border = Paint()
      ..color = Colors.black.withOpacity(0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawPath(Path.combine(PathOperation.union, path, Path()), border);
  }

  @override
  bool shouldRepaint(covariant _CloudPainter oldDelegate) => oldDelegate.color != color;
}
