import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/events.dart';

class Ball extends PositionComponent with TapCallbacks {
  Ball(double radius, Color color, Vector2 position)
    : _radius = radius,
      _color = color,
      super(
        position: position,
        size: Vector2.all(radius * 2),
        anchor: Anchor.center,
      );

  @override
  void onTapUp(TapUpEvent event) {
    super.onTapUp(event);

    print("Ale");
  }

  void setPaint(Paint paint) {
    _paint = paint;
    paint.color = _color;
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
    if (_paint != null) {
      canvas.drawCircle(Offset(_radius, _radius), _radius, _paint!);
    }
  }

  Paint? _paint;

  double _radius;
  Color _color;
}
