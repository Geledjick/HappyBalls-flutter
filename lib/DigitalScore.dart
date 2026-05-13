import 'package:flutter/material.dart';
import 'dart:math';

class DigitalScore extends StatelessWidget {
  final int value;
  final int digits;
  final double digitWidth;
  final double digitHeight;
  final Color onColor;
  final Color offColor;
  final double segmentGap; // gap between segments
  final Duration animateDuration;

  const DigitalScore({
    Key? key,
    required this.value,
    this.digits = 4,
    this.digitWidth = 40,
    this.digitHeight = 70,
    this.onColor = Colors.red,
    this.offColor = const Color(0x22000000),
    this.segmentGap = 4,
    this.animateDuration = const Duration(milliseconds: 220),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final s = value.clamp(0, pow(10, digits).toInt() - 1).toString().padLeft(digits, '0');
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(s.length, (i) {
        final digit = int.parse(s[i]);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: segmentGap / 2),
          child: AnimatedDigit(
            key: ValueKey('$value-$i'),
            digit: digit,
            width: digitWidth,
            height: digitHeight,
            onColor: onColor,
            offColor: offColor,
            gap: segmentGap,
            duration: animateDuration,
          ),
        );
      }),
    );
  }
}

class AnimatedDigit extends ImplicitlyAnimatedWidget {
  final int digit;
  final double width;
  final double height;
  final Color onColor;
  final Color offColor;
  final double gap;

  AnimatedDigit({
    Key? key,
    required this.digit,
    required this.width,
    required this.height,
    required this.onColor,
    required this.offColor,
    required this.gap,
    required Duration duration,
  }) : super(key: key, duration: duration);

  @override
  _AnimatedDigitState createState() => _AnimatedDigitState();
}

class _AnimatedDigitState extends AnimatedWidgetBaseState<AnimatedDigit> {
  Tween<double>? _tween;
  int? _oldDigit;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    final begin = (_oldDigit ?? widget.digit).toDouble();
    final end = widget.digit.toDouble();
    _tween = visitor(_tween, end, (dynamic v) => Tween<double>(begin: v as double, end: end)) as Tween<double>?;
    _oldDigit = widget.digit;
  }

  @override
  Widget build(BuildContext context) {
    final animVal = _tween?.evaluate(animation) ?? widget.digit.toDouble();
    final displayed = animVal.round().clamp(0,9);
    return CustomPaint(
      size: Size(widget.width, widget.height),
      painter: _SevenSegmentPainter(
        digit: displayed,
        onColor: widget.onColor,
        offColor: widget.offColor,
        gap: widget.gap,
      ),
    );
  }
}

class _SevenSegmentPainter extends CustomPainter {
  final int digit;
  final Color onColor;
  final Color offColor;
  final double gap;
  _SevenSegmentPainter({
    required this.digit,
    required this.onColor,
    required this.offColor,
    required this.gap,
  });

  static const List<List<int>> _segments = [
    // a, b, c, d, e, f, g
    [1,1,1,1,1,1,0], //0
    [0,1,1,0,0,0,0], //1
    [1,1,0,1,1,0,1], //2
    [1,1,1,1,0,0,1], //3
    [0,1,1,0,0,1,1], //4
    [1,0,1,1,0,1,1], //5
    [1,0,1,1,1,1,1], //6
    [1,1,1,0,0,0,0], //7
    [1,1,1,1,1,1,1], //8
    [1,1,1,1,0,1,1], //9
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final segOn = _segments[digit.clamp(0,9)];
    final paintOn = Paint()..color = onColor..style = PaintingStyle.fill;
    final paintOff = Paint()..color = offColor..style = PaintingStyle.fill;

    final w = size.width;
    final h = size.height;
    final thickness = min(w, h) * 0.13;
    final offset = thickness / 2;

    // Helper to draw a rounded rectangle segment between two points with rotation
    void drawSegment(Offset center, Size segSize, double angle, bool active) {
      canvas.save();
      canvas.translate(center.dx, center.dy);
      canvas.rotate(angle);
      final rect = Rect.fromCenter(center: Offset(0,0), width: segSize.width, height: segSize.height);
      final rrect = RRect.fromRectAndRadius(rect, Radius.circular(thickness/2));
      canvas.drawRRect(rrect, active ? paintOn : paintOff);
      canvas.restore();
    }

    // Coordinates for 7 segments (a,b,c,d,e,f,g)
    // a: top horizontal
    // b: top-right vertical
    // c: bottom-right vertical
    // d: bottom horizontal
    // e: bottom-left vertical
    // f: top-left vertical
    // g: middle horizontal
    final horizW = w - 2 * offset - thickness;
    final vertH = (h - 3 * offset - 2 * thickness) / 2;

    // a
    drawSegment(
      Offset(w/2, offset + thickness/2),
      Size(horizW, thickness),
      0,
      segOn[0]==1,
    );

    // d
    drawSegment(
      Offset(w/2, h - offset - thickness/2),
      Size(horizW, thickness),
      0,
      segOn[3]==1,
    );

    // g (middle)
    drawSegment(
      Offset(w/2, h/2),
      Size(horizW, thickness),
      0,
      segOn[6]==1,
    );

    // b (top-right)
    drawSegment(
      Offset(w - offset - thickness/2, offset + thickness + vertH/2),
      Size(thickness, vertH),
      0,
      segOn[1]==1,
    );

    // c (bottom-right)
    drawSegment(
      Offset(w - offset - thickness/2, h/2 + thickness/2 + vertH/2),
      Size(thickness, vertH),
      0,
      segOn[2]==1,
    );

    // f (top-left)
    drawSegment(
      Offset(offset + thickness/2, offset + thickness + vertH/2),
      Size(thickness, vertH),
      0,
      segOn[5]==1,
    );

    // e (bottom-left)
    drawSegment(
      Offset(offset + thickness/2, h/2 + thickness/2 + vertH/2),
      Size(thickness, vertH),
      0,
      segOn[4]==1,
    );
  }

  @override
  bool shouldRepaint(covariant _SevenSegmentPainter old) =>
      old.digit != digit || old.onColor != onColor || old.offColor != offColor;
}
