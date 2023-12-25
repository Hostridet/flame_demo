import 'package:flame/components.dart';
import 'package:flutter_flame/components/cosmic_game.dart';
import 'package:flutter_flame/config.dart';

/// Игровая арена
class PlayArea extends SpriteComponent with HasGameReference<CosmicGame> {
  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await game.loadSprite('background.jpg');
    size = Vector2(Config.areaWidth, Config.areaHeight);
  }
}
