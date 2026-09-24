import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/game_controller.dart';
import '../widgets/officer_card.dart';
import '../widgets/threat_panel.dart';
import '../widgets/mission_list.dart';

class OperationsCentreScreen extends StatelessWidget {
  const OperationsCentreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = Get.find<GameController>();

    return Scaffold(
      backgroundColor: const Color(0xFF05070D),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),

              const SizedBox(height: 24),

              OfficerCard(game: game),

              const SizedBox(height: 24),

              const ThreatPanel(),

              const SizedBox(height: 24),

              MissionList(game: game),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 700),
      tween: Tween(begin: 0, end: 1),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - value)),
            child: child,
          ),
        );
      },
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'RADA',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              letterSpacing: 5,
            ),
          ),
          SizedBox(height: 6),
          Text(
            'CYBER OPERATIONS CENTRE',
            style: TextStyle(
              color: Colors.cyanAccent,
              fontSize: 15,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}
