import 'package:flame/components.dart';
import 'package:flutter_flame/components/cosmic_game.dart';

/// Игровая арена
class PlayArea extends SpriteComponent with HasGameReference<CosmicGame> {
  PlayArea({required super.size});

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await game.loadSprite('background.jpg');
  }
}
