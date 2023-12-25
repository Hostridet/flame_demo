import 'package:flutter/material.dart';
import 'package:flutter_flame/widgets/arrow_key.dart';
import '../utils/directions.dart';

/// Меню для взаимодействия с кораблем
class NavigationKeys extends StatefulWidget {
  final ValueChanged<Direction>? onDirectionChanged;

  final Function() onFireTap;

  const NavigationKeys({
    Key? key,
    required this.onDirectionChanged,
    required this.onFireTap,
  }) : super(key: key);

  @override
  State<NavigationKeys> createState() => _NavigationKeysState();
}

class _NavigationKeysState extends State<NavigationKeys> {
  Direction direction = Direction.none;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ArrowKey(
                icons: Icons.keyboard_arrow_left,
                onTapDown: (det) {
                  updateDirection(Direction.left);
                },
                onTapUp: (dets) {
                  updateDirection(Direction.none);
                },
                onLongPressDown: () {
                  updateDirection(Direction.left);
                },
                onLongPressEnd: (dets) {
                  updateDirection(Direction.none);
                },
              ),
              ArrowKey(
                icons: Icons.ac_unit_outlined,
                onTapDown: (det) {
                  widget.onFireTap();
                },
                onTapUp: (dets) {},
                onLongPressDown: () {},
                onLongPressEnd: (dets) {},
              ),
              ArrowKey(
                icons: Icons.keyboard_arrow_right,
                onTapDown: (det) {
                  updateDirection(Direction.right);
                },
                onTapUp: (dets) {
                  updateDirection(Direction.none);
                },
                onLongPressDown: () {
                  updateDirection(Direction.right);
                },
                onLongPressEnd: (dets) {
                  updateDirection(Direction.none);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  void updateDirection(Direction newDirection) {
    direction = newDirection;
    widget.onDirectionChanged!(direction);
  }
}
