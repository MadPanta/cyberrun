import 'package:cyberrun/controllers/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'mission_complete_screen.dart';
import '../controllers/phishing_controller.dart';
import '../widgets/email_tile.dart';
import 'email_detail_screen.dart';

class OperationHookScreen extends StatelessWidget {
  const OperationHookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PhishingController(), tag: 'operation_hook');

    return Scaffold(
      backgroundColor: const Color(0xFF05070D),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'RADA MAIL',
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 3,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Operation Hook: Phishing Email Detection',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 24),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.06),
                    borderRadius: BorderRadius.circular(22),
                    border: Border.all(
                      color: Colors.cyanAccent.withValues(alpha: 0.55),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.security, color: Colors.cyanAccent),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Threats Found: ${controller.correctReports.value}/2',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        'Mistakes: ${controller.mistakes.value}',
                        style: TextStyle(
                          color: controller.mistakes.value > 0
                              ? Colors.redAccent
                              : Colors.white54,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'Inbox',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 16),
                ...controller.emails.map((email) {
                  return EmailTile(
                    email: email,
                    handled: controller.isHandled(email.id),
                    onTap: () {
                      Get.to(
                        () => EmailDetailScreen(
                          email: email,
                          controllerTag: 'operation_hook',
                        ),
                      );
                    },
                  );
                }),
                const SizedBox(height: 20),
                if (controller.missionComplete)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final game = Get.find<GameController>();

                        await game.finishOperationHook();

                        Get.off(() => const MissionCompleteScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 18),
                      ),
                      child: const Text(
                        'MISSION COMPLETE',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
