import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter_flame/components/bullet_wall.dart';
import 'package:flutter_flame/components/cosmic_ship.dart';
import 'package:flutter_flame/components/end_wall.dart';
import 'package:flutter_flame/components/enemy_ship.dart';
import 'package:flutter_flame/components/play_area.dart';
import 'package:flutter_flame/components/ship_bullet.dart';
import 'package:flutter_flame/config.dart';
import 'package:flutter_flame/utils/directions.dart';
import 'package:flutter_flame/utils/play_state.dart';

class CosmicGame extends FlameGame with KeyboardEvents, HasCollisionDetection, TapDetector {
  late PlayState playState;

  PlayArea playArea = PlayArea(
    size: Vector2(Config.areaWidth, Config.areaHeight),
  );

  CosmicShip cosmicShip = CosmicShip(
    size: Vector2(Config.shipWidth, Config.shipHeight),
    position: Vector2(
      Config.areaWidth / 2 - Config.shipWidth / 2,
      Config.areaHeight - Config.shipHeight,
    ),
  );

  EndWall endWall = EndWall(
    position: Vector2(0, Config.areaHeight),
    wallSize: Vector2(Config.areaWidth, 1),
  );

  BulletWall bulletWall = BulletWall(
    position: Vector2(0, 0),
    wallSize: Vector2(Config.areaWidth, 1),
  );

  void startGame() {
    if (playState == PlayState.playing) return;

    world.removeAll(world.children.query<CosmicShip>());
    world.removeAll(world.children.query<EnemyShip>());
    world.removeAll(world.children.query<ShipBullet>());

    playState = PlayState.playing;

    add(cosmicShip);
    List<EnemyShip> enemyShips = List<EnemyShip>.generate(10, (index) {
      return EnemyShip(
        enemySize: Vector2(50, 50),
        position: Vector2(0 + index * 30, 0 + index * 30),
        velocity: Vector2(0, 1),
      );
    });
    addAll(enemyShips);
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();
    add(playArea);
    add(endWall);
    add(bulletWall);

    playState = PlayState.welcome;
  }

  void onArrowKeyChanged(Direction direction) {
    cosmicShip.direction = direction;
  }

  void onFireTap() {
    if (playState == PlayState.playing) {
      add(ShipBullet(
        position: Vector2(
          cosmicShip.position.x + Config.shipWidth / 2 - Config.shipWidth / 8,
          cosmicShip.position.y - Config.shipHeight / 8,
        ),
        velocity: Vector2(0, -4),
        bulletHeight: Config.shipHeight / 5,
        bulletWidth: Config.shipWidth / 5,
      ));
    }
  }

  @override // Add from here...
  void onTap() {
    super.onTap();
    startGame();
  }
}
