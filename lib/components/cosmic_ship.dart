import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter_flame/components/cosmic_game.dart';
import 'package:flutter_flame/config.dart';
import 'package:flutter_flame/utils/directions.dart';

/// Корабль
class CosmicShip extends SpriteAnimationComponent with HasGameReference<CosmicGame> {
  CosmicShip({required super.position}) : super();
  late final SpriteAnimation _flyingLeft;
  late final SpriteAnimation _flyingRight;
  late final SpriteAnimation _defaultAnimation;

  final double _animationSpeed = .15;
  Direction direction = Direction.none;

  @override
  Future<void> onLoad() async {
    super.onLoad();
    await _loadAnimations().then((_) => {animation = _defaultAnimation});
    size = Vector2(Config.shipWidth, Config.shipHeight);
  }

  @override
  void update(double dt) {
    super.update(dt);
    updatePosition(dt);
  }

  updatePosition(double dt) {
    switch (direction) {
      case Direction.left:
        animation = _flyingLeft;
        if (position.x > 0) {
          position.x -= 2;
        }
        break;
      case Direction.right:
        animation = _flyingRight;
        if (position.x < Config.areaWidth - Config.shipWidth) {
          position.x += 2;
        }
        break;
      case Direction.none:
        animation = _defaultAnimation;
        break;
    }
  }

  Future<void> _loadAnimations() async {
    final spriteSheet = SpriteSheet.fromColumnsAndRows(image: await game.images.load('cosmicsprite.png'), columns: 6, rows: 12);

    _defaultAnimation = spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, from: 0, to: 1);
    _flyingRight = spriteSheet.createAnimation(row: 0, stepTime: _animationSpeed, from: 3, to: 5);
    _flyingLeft = spriteSheet.createAnimation(row: 11, stepTime: _animationSpeed, from: 3, to: 5);
  }
}
