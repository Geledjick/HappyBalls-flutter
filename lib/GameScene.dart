import 'package:flutter/material.dart';
import 'package:flame/game.dart';

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

    _cellWidth = game.size.x / cols;
    _cellHeight = game.size.y / rows;
  }

  @override
  void update(double dt) {}

  @override
  void render(Canvas canvas) {
    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        final double left = col * _cellWidth.toDouble();
        final double top = row * _cellHeight.toDouble();

        final Rect rect = Rect.fromLTWH(left, top, _cellWidth, _cellHeight);

        canvas.drawRect(rect, _cellPaint);
        canvas.drawRect(rect, _borderPaint);
      }
    }
  }

  @override
  void resize() {
    _cellWidth = game.size.x / cols;
    _cellHeight = game.size.y / rows;
  }

  // ---

  final int rows, cols;

  late Paint _cellPaint, _borderPaint;
  late double _cellWidth, _cellHeight;
}
