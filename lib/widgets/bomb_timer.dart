import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/mission_controller.dart';

class BombTimer extends StatelessWidget {
  final MissionController controller;

  const BombTimer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final seconds = controller.secondsLeft.value;

      final warning = seconds <= 10 && seconds > 5;
      final critical = seconds <= 5;

      final timerColor = critical
          ? Colors.redAccent
          : warning
          ? Colors.orangeAccent
          : Colors.cyanAccent;

      return TweenAnimationBuilder<double>(
        key: ValueKey(seconds),
        tween: Tween(begin: 0, end: 1),
        duration: const Duration(milliseconds: 300),
        builder: (context, value, child) {
          final shakeOffset = critical
              ? math.sin(value * math.pi * 8) * 4
              : 0.0;

          return Transform.translate(
            offset: Offset(shakeOffset, 0),
            child: AnimatedScale(
              duration: const Duration(milliseconds: 250),
              scale: critical ? 1.07 : 1.0,
              child: SizedBox(
                width: 340,
                height: 170,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      'assets/images/bomber.png',
                      width: 340,
                      fit: BoxFit.contain,
                    ),
                    if (critical)
                      ...List.generate(10, (index) {
                        final random = math.Random(index);

                        return Positioned(
                          left: 160 + random.nextDouble() * 40,

                          top: 18 + random.nextDouble() * 30,

                          child: TweenAnimationBuilder<double>(
                            duration: const Duration(milliseconds: 350),
                            tween: Tween(begin: 0, end: 1),
                            builder: (context, value, child) {
                              return Transform.translate(
                                offset: Offset(
                                  random.nextDouble() * 20,
                                  -value * 25,
                                ),

                                child: Opacity(
                                  opacity: 1 - value,

                                  child: Container(
                                    width: 3,

                                    height: 3,

                                    decoration: BoxDecoration(
                                      color: index.isEven
                                          ? Colors.orangeAccent
                                          : Colors.cyanAccent,

                                      shape: BoxShape.circle,

                                      boxShadow: [
                                        BoxShadow(
                                          color: index.isEven
                                              ? Colors.orangeAccent
                                              : Colors.cyanAccent,

                                          blurRadius: 8,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      }),
                    Positioned(
                      top: 73,
                      child: AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 200),
                        style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: timerColor,
                          letterSpacing: 2,
                          fontFamily: 'Courier',
                          shadows: [
                            Shadow(
                              color: timerColor,
                              blurRadius: critical ? 28 : 18,
                            ),
                          ],
                        ),
                        child: Text('00:${seconds.toString().padLeft(2, '0')}'),
                      ),
                    ),

                    Positioned(
                      right: 16,
                      top: 68,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        opacity: critical ? 0.35 : 1,
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: critical
                                ? Colors.redAccent
                                : Colors.greenAccent,
                            boxShadow: [
                              BoxShadow(
                                color: critical
                                    ? Colors.redAccent
                                    : Colors.greenAccent,
                                blurRadius: 14,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
