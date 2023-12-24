import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_flame/components/cosmic_game.dart';

/// Стена для отлова снарядов
class BulletWall extends RectangleComponent with HasGameReference<CosmicGame> {
  /// Размер стены
  final Vector2 wallSize;

  BulletWall({
    required super.position,
    required this.wallSize,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox(size: wallSize));
  }
}
