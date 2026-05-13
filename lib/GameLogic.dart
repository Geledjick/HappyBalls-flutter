import 'dart:math';
import 'package:flutter/material.dart';
import 'Vector2.dart';
import 'Ball.dart';

class GameLogic extends ChangeNotifier {
  static const List<Color> BallColors = [
    Colors.transparent,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];

  final Random _random = Random();

  final int rows = 16;
  final int cols = 16;

  int score = 0;
  int combo = 1;

  late int maxGenerateIteration = cols + rows;
  late int maxGenerateBalls = (cols + rows);

  Ball grabedBall = Ball();
  bool gameOver = false;
  bool lastChecked = true;

  late Vector2i lastGrabedPosition;

  late List<List<Ball>> field = List.generate(cols, (c) {
    return List.generate(rows, (r) {
      return Ball();
    });
  });

  bool _checkBorders(Vector2i pos) {
    return (
      pos.x < cols &&
      pos.x >= 0 &&
      pos.y < rows &&
      pos.y >= 0
    );
  }

  bool _checkField() {
    bool checked = false;
    for (int r = 0; r < rows; r++) {
      for (int c = 0; c < cols; c++) {
        Ball targetBall = field[c][r];
        if (targetBall.color == Colors.transparent) {
          continue;
        }

        if (
          _checkBorders(Vector2(c + 1, r)) &&
          _checkBorders(Vector2(c + 2, r)) &&
          targetBall.color == field[c + 1][r].color &&
          targetBall.color == field[c + 2][r].color
        ) {
          checked = true;
          field[c + 1][r].color = Colors.transparent;
          field[c + 2][r].color = Colors.transparent;

          int len = 3;
          while (
            _checkBorders(Vector2(c + len, r)) &&
            targetBall.color == field[c + len][r].color
          ) {
            field[c + len][r].color = Colors.transparent;
            len++;
          }

          targetBall.color = Colors.transparent;
          score += len * combo;
          combo++; 
        }

        else if (
          _checkBorders(Vector2(c, r + 1)) &&
          _checkBorders(Vector2(c, r + 2)) &&
          targetBall.color == field[c][r + 1].color &&
          targetBall.color == field[c][r + 2].color
        ) {
          checked = true;
          field[c][r + 1].color = Colors.transparent;
          field[c][r + 2].color = Colors.transparent;

          int len = 3;
          while (
            _checkBorders(Vector2(c, r + len)) &&
            targetBall.color == field[c][r + len].color
          ) {
            field[c][r + len].color = Colors.transparent;
            len++;
          }

          targetBall.color = Colors.transparent;
          score += len * combo;
          combo++; 
        }

        else if (
          _checkBorders(Vector2(c + 1, r + 1)) &&
          _checkBorders(Vector2(c + 2, r + 2)) &&
          targetBall.color == field[c + 1][r + 1].color &&
          targetBall.color == field[c + 2][r + 2].color
        ) {
          checked = true;
          field[c + 1][r + 1].color = Colors.transparent;
          field[c + 2][r + 2].color = Colors.transparent;

          int len = 3;
          while (
            _checkBorders(Vector2(c + len, r + len)) &&
            targetBall.color == field[c + len][r + len].color
          ) {
            field[c + len][r + len].color = Colors.transparent;
            len++;
          }

          targetBall.color = Colors.transparent;
          score += len * combo;
          combo++; 
        }

        else if (
          _checkBorders(Vector2(c - 1, r + 1)) &&
          _checkBorders(Vector2(c - 2, r + 2)) &&
          targetBall.color == field[c - 1][r + 1].color &&
          targetBall.color == field[c - 2][r + 2].color
        ) {
          checked = true;
          field[c - 1][r + 1].color = Colors.transparent;
          field[c - 2][r + 2].color = Colors.transparent;

          int len = 3;
          while (
            _checkBorders(Vector2(c - len, r + len)) &&
            targetBall.color == field[c - len][r + len].color
          ) {
            field[c - len][r + len].color = Colors.transparent;
            len++;
          }

          targetBall.color = Colors.transparent;
          score += len * combo;
          combo++; 
        }
      }
    }

    return checked;
  }

  void _update() {
    notifyListeners();
  }

  void generateBalls() async {
    Vector2i pos = Vector2i.zero();
    for (int i = 0; i < maxGenerateBalls; i++) {
      int j = 0;
      do {
        pos.x = _random.nextInt(cols);
        pos.y = _random.nextInt(rows);
        j++;
        if (j > maxGenerateIteration) {
          gameOver = true;
          return;
        }
      } while (field[pos.x][pos.y].color != Colors.transparent);

      field[pos.x][pos.y].color = BallColors[_random.nextInt(BallColors.length)];

      combo = 1;
    }
  }

  void tap(Vector2i pos) async {
    if (
      field[pos.x][pos.y].color != Colors.transparent &&
      grabedBall.color == Colors.transparent
    ) {
      grabedBall.color = field[pos.x][pos.y].color;
      field[pos.x][pos.y].color = Colors.transparent;
      lastGrabedPosition = pos;

    } else if (
      field[pos.x][pos.y].color == Colors.transparent &&
      grabedBall.color != Colors.transparent
    ) {
      field[pos.x][pos.y].color = grabedBall.color;
      grabedBall.color = Colors.transparent;

      if (!(lastGrabedPosition.x == pos.x && lastGrabedPosition.y == pos.y)) {
        bool checked = _checkField();
        if (checked == false) {
          generateBalls();
        }
      }

    }

    _update();
  }
}