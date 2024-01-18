import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flame/components/bullet_wall.dart';
import 'package:flutter_flame/components/cosmic_ship.dart';
import 'package:flutter_flame/components/end_wall.dart';
import 'package:flutter_flame/components/enemy_ship.dart';
import 'package:flutter_flame/components/play_area.dart';
import 'package:flutter_flame/components/score_card.dart';
import 'package:flutter_flame/components/ship_bullet.dart';
import 'package:flutter_flame/config.dart';
import 'package:flutter_flame/utils/directions.dart';
import 'package:flutter_flame/utils/play_state.dart';

class CosmicGame extends FlameGame with KeyboardEvents, HasCollisionDetection, TapDetector {
  /// Состояние игры
  late PlayState playState;

  /// Количество очков
  final ValueNotifier<int> score = ValueNotifier(0);

  /// Сложность игры
  late double gameDifficulty;

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

  ScoreCard scoreCard = ScoreCard();

  void startGame() {
    if (playState == PlayState.playing) return;

    overlays.clear();
    gameDifficulty = 0.5;

    addAll(generateEnemyList());
    add(cosmicShip);
    playState = PlayState.playing;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    add(playArea);
    add(endWall);
    add(bulletWall);
    add(scoreCard);

    playState = PlayState.welcome;
    overlays.add(playState.name);
  }

  @override
  Future<void> update(double dt) async {
    super.update(dt);

    if (children.query<EnemyShip>().isEmpty && playState == PlayState.playing) {
      gameDifficulty += 0.1;
      addAll(generateEnemyList());
    }

    if (playState == PlayState.end) {
      removeAll(children.query<CosmicShip>());
      removeAll(children.query<EnemyShip>());
      removeAll(children.query<ShipBullet>());
      overlays.add(playState.name);
    }
  }

  List<EnemyShip> generateEnemyList() {
    return List<EnemyShip>.generate(10, (index) {
      return EnemyShip(
        enemySize: Vector2(40, 40),
        position: Vector2(0 + index * Config.areaWidth / 10, 0),
        velocity: Vector2(0, gameDifficulty),
        onRemoveShip: () {
          score.value++;
        },
      );
    });
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

  @override
  void onTap() {
    super.onTap();
    startGame();
  }
}
