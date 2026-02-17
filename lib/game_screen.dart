import 'dart:math';
import 'package:flutter/material.dart';

class Ball {
  Color color = Colors.transparent;
}

class Vector2i {
  int x = 0, y = 0;
  Vector2i(int nx, int ny) {
    x = nx;
    y = ny;
  }
  Vector2i.zero();
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static const List<Color> BallColors = [
    Colors.transparent,
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.yellow,
  ];

  final Random _random = Random();

  static const int rows = 12;
  static const int cols = 12;

  int score = 0;
  int maxGenerateIteration = cols + rows;

  Ball grabedBall = Ball();
  Vector2i positionFromGrabed = Vector2i.zero();
  bool gameOver = false;

  List<List<Ball>> field = List.generate(cols, (c) {
    return List.generate(rows, (r) {
      return Ball();
    });
  });

  bool _checkVertical() {
    for (int c = 0; c < cols; c++) {
      for (int r = 0; r < rows; r++) {
        if (field[c][r].color != Colors.transparent &&
            r + 1 < rows &&
            r + 2 < rows) {
          Color targetColor = field[c][r].color;
          if (targetColor == field[c][r + 1].color &&
              targetColor == field[c][r + 2].color) {
            int len = 3;
            field[c][r].color = Colors.transparent;
            field[c][r + 1].color = Colors.transparent;
            field[c][r + 2].color = Colors.transparent;
            while (r + len < rows && targetColor == field[c][r + len].color) {
              field[c][r + len].color = Colors.transparent;
              len++;
            }
            score += len;
            return true;
          }
        }
      }
    }
    return false;
  }

  bool _checkHorizont() {
    for (int c = 0; c < cols; c++) {
      for (int r = 0; r < rows; r++) {
        if (field[c][r].color != Colors.transparent &&
            c + 1 < cols &&
            c + 2 < cols) {
          Color targetColor = field[c][r].color;
          if (targetColor == field[c + 1][r].color &&
              targetColor == field[c + 2][r].color) {
            int len = 3;
            field[c][r].color = Colors.transparent;
            field[c + 1][r].color = Colors.transparent;
            field[c + 2][r].color = Colors.transparent;
            while (c + len < cols && targetColor == field[c + len][r].color) {
              field[c + len][r].color = Colors.transparent;
              len++;
            }
            score += len;
            return true;
          }
        }
      }
    }
    return false;
  }

  void _update() {
    setState(() {
      _checkHorizont();
      _checkVertical();
    });
  }

  void _generateBalls() {
    Vector2i pos = Vector2i.zero();
    for (int i = 0; i < maxGenerateIteration; i++) {
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

      field[pos.x][pos.y].color =
          BallColors[_random.nextInt(BallColors.length)];
    }
    _update();
  }

  void _tap(Vector2i pos) {
    if (field[pos.x][pos.y].color != Colors.transparent &&
        grabedBall.color == Colors.transparent) {
      grabedBall.color = field[pos.x][pos.y].color;
      field[pos.x][pos.y].color = Colors.transparent;
      positionFromGrabed = pos;
    } else if (field[pos.x][pos.y].color == Colors.transparent &&
        grabedBall.color != Colors.transparent) {
      field[pos.x][pos.y].color = grabedBall.color;
      grabedBall.color = Colors.transparent;
    }
    _update();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        backgroundColor: Colors.grey,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: List.generate(cols, (c) {
                  return Expanded(
                    child: Row(
                      children: List.generate(rows, (r) {
                        return Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              border: Border.all(color: Colors.black),
                            ),
                            child: Center(
                              child: InkWell(
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: field[c][r].color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                                onTap: () {
                                  _tap(Vector2i(c, r));
                                },
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  );
                }),
              ),
            ),
          ),
          Container(
            height: 100,
            color: Colors.grey,
            child: Row(
              children: [
                Spacer(),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: grabedBall.color,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Text("Score: " + score.toString()),
                Spacer(),
                ElevatedButton(
                  onPressed: _generateBalls,
                  child: Text("Generate more balls!"),
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
