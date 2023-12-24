import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_flame/components/bullet_wall.dart';
import 'package:flutter_flame/components/cosmic_game.dart';
import 'package:flutter_flame/components/enemy_ship.dart';

/// Снаряд корабля
class ShipBullet extends SpriteAnimationComponent with HasGameReference<CosmicGame>, CollisionCallbacks {
  /// Направление снаряда
  final Vector2 velocity;

  /// Высота снаряда
  final double bulletHeight;

  /// Ширина снаряда
  final double bulletWidth;

  ShipBullet({
    required super.position,
    required this.velocity,
    required this.bulletHeight,
    required this.bulletWidth,
  }) : super();

  late final SpriteAnimation _bulletAnimation;

  final double _animationSpeed = .15;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(RectangleHitbox(size: Vector2(bulletWidth, bulletHeight)));
    await _loadAnimations();
    animation = _bulletAnimation;
    size = Vector2(bulletWidth, bulletHeight);
  }

  @override
  void update(double dt) {
    super.update(dt);
    position += velocity;
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet.fromColumnsAndRows(image: await game.images.load('beams.png'), columns: 18, rows: 21);
    _bulletAnimation = spriteSheet.createAnimation(row: 1, stepTime: _animationSpeed, from: 0, to: 1);
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is BulletWall || other is EnemyShip) {
      removeFromParent();
    }
  }
}
