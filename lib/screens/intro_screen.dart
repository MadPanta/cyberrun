import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';
import '../controllers/mission_controller.dart';
import 'mission_screen.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  String missionText = '';
  String instructionText = '';

  final String fullMission =
      "You are on a mission to save RADA from cyber attacks.";

  final String fullInstruction =
      "Secure the Cyber Defence Terminal before the countdown reaches zero.";
  @override
  void initState() {
    super.initState();

    _typeMission();
  }

  Future<void> _typeMission() async {
    for (int i = 0; i < fullMission.length; i++) {
      await Future.delayed(const Duration(milliseconds: 40));

      if (!mounted) return;

      setState(() {
        missionText += fullMission[i];
      });
    }

    await Future.delayed(const Duration(milliseconds: 500));

    for (int i = 0; i < fullInstruction.length; i++) {
      await Future.delayed(const Duration(milliseconds: 30));

      if (!mounted) return;

      setState(() {
        instructionText += fullInstruction[i];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(MissionController());

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: TweenAnimationBuilder<double>(
              duration: const Duration(milliseconds: 900),
              tween: Tween(begin: 0, end: 1),
              builder: (context, value, child) {
                return Opacity(
                  opacity: value,
                  child: Transform.translate(
                    offset: Offset(0, 40 * (1 - value)),
                    child: child,
                  ),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo/logo.png', height: 180),
                  const SizedBox(height: 30),
                  const Text(
                    'RADA',
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 6,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'CYBER DEFENCE COMMAND',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.cyanAccent,
                      fontSize: 18,
                      letterSpacing: 2,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    missionText + (missionText != fullMission ? "|" : ""),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22, height: 1.5),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    instructionText +
                        (instructionText != fullInstruction ? "|" : ""),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 50),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 700),
                    opacity: instructionText == fullInstruction ? 1.0 : 0.0,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: instructionText == fullInstruction
                            ? () => Get.to(() => const MissionScreen())
                            : null,
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          backgroundColor: Colors.cyanAccent,
                          foregroundColor: Colors.black,
                          disabledBackgroundColor: Colors.grey.shade700,
                          disabledForegroundColor: Colors.white54,
                        ),
                        child: const Text(
                          "ACCEPT MISSION",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
