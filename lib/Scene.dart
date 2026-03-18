import 'dart:ui';
import 'package:flame/game.dart';

abstract class Scene {
  Scene(this.game);

  void onLoad() {}
  void update(double dt) {}
  void render(Canvas canvas) {}
  void resize(Vector2 size) {}
  void onEnter() {}
  void onExit() {}

  // ---

  final FlameGame game;
}
