import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter_flame/components/cosmic_game.dart';
import 'package:flutter_flame/components/enemy_ship.dart';
import 'package:flutter_flame/utils/play_state.dart';

/// Стена окончания игры
class EndWall extends RectangleComponent with HasGameReference<CosmicGame>, CollisionCallbacks {
  /// Размер стены
  final Vector2 wallSize;

  EndWall({
    required super.position,
    required this.wallSize,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(RectangleHitbox(size: wallSize));
  }

  @override
  void onCollisionStart(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is EnemyShip) {
      game.playState = PlayState.end;
    }
  }
}
