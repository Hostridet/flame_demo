import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_flame/components/cosmic_game.dart';
import 'package:flutter_flame/components/ship_bullet.dart';

class EnemyShip extends SpriteComponent with HasGameReference<CosmicGame>, CollisionCallbacks {
  /// Направление движения
  final Vector2 velocity;

  /// Размер корабля
  final Vector2 enemySize;

  final VoidCallback onRemoveShip;

  EnemyShip({
    required super.position,
    required this.velocity,
    required this.enemySize,
    required this.onRemoveShip,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox(size: enemySize));
    sprite = await Sprite.load('enemy.png');
    size = enemySize;
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity;
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is ShipBullet) {
      removeFromParent();
      onRemoveShip();
    }
  }
}
