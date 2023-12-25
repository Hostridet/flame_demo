import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter_flame/components/cosmic_ship.dart';
import 'package:flutter_flame/components/enemy_ship.dart';
import 'package:flutter_flame/components/play_area.dart';
import 'package:flutter_flame/components/ship_bullet.dart';
import 'package:flutter_flame/config.dart';
import 'package:flutter_flame/utils/directions.dart';

class CosmicGame extends FlameGame with KeyboardEvents, HasCollisionDetection {
  PlayArea playArea = PlayArea();
  CosmicShip cosmicShip = CosmicShip(
    position: Vector2(
      Config.areaWidth / 2 - Config.shipWidth / 2,
      Config.areaHeight - Config.shipHeight,
    ),
  );
  List<EnemyShip> enemyShips = List<EnemyShip>.generate(10, (index) {
    return EnemyShip(
      enemySize: Vector2(50, 50),
      position: Vector2(0 + index * 30, 0 + index * 30),
      velocity: Vector2(0, 1),
    );
  });

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await add(playArea);
    await add(cosmicShip);
    await addAll(enemyShips);

    debugMode = true;
  }

  onArrowKeyChanged(Direction direction) {
    cosmicShip.direction = direction;
  }

  onFireTap() async {
    await add(ShipBullet(
      position: Vector2(
        cosmicShip.position.x + Config.shipWidth / 2 - Config.shipWidth / 8,
        cosmicShip.position.y - Config.shipHeight / 8,
      ),
      velocity: Vector2(0, -3),
      bulletHeight: Config.shipHeight / 5,
      bulletWidth: Config.shipWidth / 5,
    ));
  }
}