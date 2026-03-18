import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import 'Ball.dart';
import 'Scene.dart';

class GameScene extends Scene {
  GameScene(FlameGame game, this.rows, this.cols) : super(game);

  @override
  void onEnter() {
    _cellPaint = Paint();
    _cellPaint.color = Colors.grey;
    _cellPaint.style = PaintingStyle.fill;

    _borderPaint = Paint();
    _borderPaint.color = Colors.black;
    _borderPaint.style = PaintingStyle.stroke;
    _borderPaint.strokeWidth = 2.0;

    _ballPaint = Paint();
    _ballPaint.style = PaintingStyle.fill;

    resize(game.size);
  }

  @override
  void update(double dt) {}

  @override
  void resize(Vector2 size) {
    final double cellWidth = size.x / cols;
    final double cellHeight = size.y / rows;

    if (cellWidth > cellHeight) {
      _cellSize = cellHeight;
      _offsetCenter.x = (size.x / 2) - ((rows * _cellSize) / 2);
      _offsetCenter.y = 0;
    } else {
      _cellSize = cellWidth;
      _offsetCenter.x = 0;
      _offsetCenter.y = (size.y / 2) - ((cols * _cellSize) / 2);
    }
  }

  @override
  void render(Canvas canvas) {
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        final double left = _offsetCenter.x + (col * _cellSize.toDouble());
        final double top = _offsetCenter.y + (row * _cellSize.toDouble());

        final Rect rect = Rect.fromLTWH(left, top, _cellSize, _cellSize);

        canvas.drawRect(rect, _cellPaint);
        canvas.drawRect(rect, _borderPaint);
      }
    }
  }

  // ---

  final int rows, cols;
  List<List<Ball?>> data = [];

  late Paint _cellPaint, _borderPaint, _ballPaint;
  double _cellSize = 0;
  Vector2 _offsetCenter = Vector2(0, 0);
}
