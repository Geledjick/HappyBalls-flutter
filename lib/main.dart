import 'package:flutter/material.dart';
import 'package:flame/game.dart';

import 'Scene.dart';
import 'GameScene.dart';

void main() {
  runApp(const MyApp());
}

class SceneManager extends FlameGame {
  void changeScene(Scene newScene) {
    _currentScene?.onExit();

    _currentScene = newScene;

    _currentScene!.onLoad();
    _currentScene!.onEnter();
  }

  @override
  Future<void> onLoad() async {
    changeScene(GameScene(this, 14, 14));
  }

  @override
  void update(double dt) {
    _currentScene?.update(dt);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _currentScene?.resize(size);
  }

  @override
  void render(Canvas canvas) {
    _currentScene?.render(canvas);
  }

  // ---

  Scene? _currentScene;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: GameWidget(
            game: SceneManager()
          ),
        ),
        bottomNavigationBar: Container(
          child: Text(
            "42",
            style: TextStyle(fontSize: 42),
          ),
        ),
      ),
    );
  }
}
