import 'package:flutter/material.dart';

import 'Ball.dart';
import 'Vector2.dart';
import 'AiGameLogic.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late AiGameLogic game;

  @override
  void initState() {
    super.initState();
    game = AiGameLogic();
    game.generateBalls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: ListenableBuilder(
        listenable: game,
        builder: (context, child) {
          return Expanded(
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: List.generate(game.cols, (c) {
                  return Expanded(
                    child: Row(
                      children: List.generate(game.rows, (r) {
                        return Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              border: Border.all(color: Colors.black),
                            ),
                            child: Center(
                              child: InkWell(
                                child: BallWidget(
                                  ball: game.field[c][r]
                                ),
                                onTap: () {
                                  game.tap(Vector2i(c, r));
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
          );
        }
      ),
    );
  }
}