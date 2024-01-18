import 'package:flame/components.dart';
import 'package:flutter_flame/components/cosmic_game.dart';

/// Текст с количеством очков
class ScoreCard extends TextComponent with HasGameReference<CosmicGame> {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    text = 'Score: ${game.score.value}';
  }

  @override
  void update(double dt) {
    super.update(dt);
    text = 'Score: ${game.score.value}';
  }
}
