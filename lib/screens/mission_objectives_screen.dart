import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'operation_hook_screen.dart';

class MissionObjectivesScreen extends StatefulWidget {
  const MissionObjectivesScreen({super.key});

  @override
  State<MissionObjectivesScreen> createState() =>
      _MissionObjectivesScreenState();
}

class _MissionObjectivesScreenState extends State<MissionObjectivesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget objective(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle, color: Colors.greenAccent),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget infoCard(IconData icon, String title, String value, Color color) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .05),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withValues(alpha: .5)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color),
          const SizedBox(width: 15),
          Expanded(child: Text(title)),
          Text(
            value,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff05070D),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "MISSION OBJECTIVES",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Operation Hook",
                style: TextStyle(color: Colors.cyanAccent, fontSize: 18),
              ),

              const SizedBox(height: 30),

              objective("Inspect every email carefully."),

              objective("Report suspicious emails."),

              objective("Never click malicious links."),

              objective("Complete the mission within 3 minutes."),

              const SizedBox(height: 25),

              infoCard(Icons.star, "Difficulty", "★★☆☆☆", Colors.orangeAccent),

              infoCard(
                Icons.workspace_premium,
                "Reward",
                "+150 XP",
                Colors.greenAccent,
              ),

              infoCard(
                Icons.emoji_events,
                "Badge",
                "Phishing Hunter",
                Colors.amberAccent,
              ),

              const Spacer(),

              FadeTransition(
                opacity: controller,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.off(() => const OperationHookScreen());
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.cyanAccent,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                    ),
                    child: const Text(
                      "BEGIN OPERATION",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        letterSpacing: 3,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
