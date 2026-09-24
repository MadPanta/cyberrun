import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'operations_centre_screen.dart';
import '../controllers/mission_controller.dart';
import '../widgets/bomb_timer.dart';
import '../widgets/password_requirement.dart';

class MissionScreen extends StatelessWidget {
  const MissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MissionController>();

    return Scaffold(
      body: SafeArea(
        child: Obx(() {
          switch (controller.status.value) {
            case MissionStatus.briefing:
              return _BriefingView(controller: controller);

            case MissionStatus.active:
              return _TerminalView(controller: controller);

            case MissionStatus.success:
              return _SuccessView(controller: controller);

            case MissionStatus.failed:
              return _FailedView(controller: controller);
          }
        }),
      ),
    );
  }
}

class _BriefingView extends StatelessWidget {
  final MissionController controller;

  const _BriefingView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Spacer(),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.red.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.redAccent),
            ),
            child: const Column(
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.redAccent,
                  size: 60,
                ),
                SizedBox(height: 20),
                Text(
                  'SECURITY ALERT',
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Unauthorized activity detected on the RADA Network.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 17, height: 1.5),
                ),
                SizedBox(height: 14),
                Text(
                  'Your first mission is to secure the Cyber Defence Terminal using your email and a strong password.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          BombTimer(controller: controller),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: controller.beginMission,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 18),
                backgroundColor: Colors.redAccent,
                foregroundColor: Colors.white,
              ),
              child: const Text(
                'BEGIN MISSION',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TerminalView extends StatelessWidget {
  final MissionController controller;

  const _TerminalView({required this.controller});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController(text: controller.email.value);
    final passwordController = TextEditingController(
      text: controller.password.value,
    );
    final confirmPasswordController = TextEditingController(
      text: controller.confirmPassword.value,
    );
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          BombTimer(controller: controller),
          const SizedBox(height: 28),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: Colors.cyanAccent.withValues(alpha: 0.7),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'CYBER DEFENCE TERMINAL',
                  style: TextStyle(
                    color: Colors.cyanAccent,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 24),
                TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => controller.email.value = value,
                  decoration: const InputDecoration(
                    labelText: 'Officer Email',
                    prefixIcon: Icon(Icons.email_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 18),
                Obx(
                  () => TextField(
                    controller: passwordController,
                    obscureText: !controller.showPassword.value,
                    onChanged: (value) => controller.password.value = value,
                    decoration: InputDecoration(
                      labelText: 'Create Secure Password',
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.showPassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: controller.togglePassword,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                Obx(
                  () => TextField(
                    controller: confirmPasswordController,
                    obscureText: !controller.showConfirmPassword.value,
                    onChanged: (value) =>
                        controller.confirmPassword.value = value,
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      prefixIcon: const Icon(Icons.lock_reset),
                      border: const OutlineInputBorder(),
                      suffixIcon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            controller.passwordsMatch
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: controller.passwordsMatch
                                ? Colors.greenAccent
                                : Colors.redAccent,
                          ),

                          IconButton(
                            icon: Icon(
                              controller.showConfirmPassword.value
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: controller.toggleConfirmPassword,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),
                Obx(() {
                  final strength = controller.passwordStrength;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Password Strength: ${controller.strengthLabel}',
                        style: TextStyle(
                          color: controller.isStrongPassword
                              ? Colors.greenAccent
                              : Colors.orangeAccent,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: LinearProgressIndicator(
                          value: strength,
                          minHeight: 14,
                          backgroundColor: Colors.white12,
                          color: controller.isStrongPassword
                              ? Colors.greenAccent
                              : Colors.orangeAccent,
                        ),
                      ),
                      const SizedBox(height: 18),
                      PasswordRequirement(
                        text: 'At least 8 characters',
                        passed: controller.hasEightCharacters,
                      ),
                      PasswordRequirement(
                        text: 'Uppercase letter',
                        passed: controller.hasUppercase,
                      ),
                      PasswordRequirement(
                        text: 'Lowercase letter',
                        passed: controller.hasLowercase,
                      ),
                      PasswordRequirement(
                        text: 'Number',
                        passed: controller.hasNumber,
                      ),
                      PasswordRequirement(
                        text: 'Symbol',
                        passed: controller.hasSymbol,
                      ),
                      PasswordRequirement(
                        text: 'Passwords Match',
                        passed: controller.passwordsMatch,
                      ),
                    ],
                  );
                }),
                const SizedBox(height: 26),
                SizedBox(
                  width: double.infinity,
                  child: Obx(
                    () => ElevatedButton.icon(
                      onPressed: controller.canSecureTerminal
                          ? controller.submitTerminalAccess
                          : null,
                      icon: Icon(
                        controller.canSecureTerminal
                            ? Icons.verified_user
                            : Icons.lock,
                      ),
                      label: Text(
                        controller.canSecureTerminal
                            ? 'SECURE TERMINAL'
                            : 'TERMINAL LOCKED',
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: controller.canSecureTerminal
                            ? Colors.cyanAccent
                            : Colors.grey.shade700,
                        foregroundColor: controller.canSecureTerminal
                            ? Colors.black
                            : Colors.white70,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SuccessView extends StatelessWidget {
  final MissionController controller;

  const _SuccessView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Center(
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 800),
          tween: Tween(begin: 0, end: 1),
          builder: (context, value, child) {
            return Opacity(
              opacity: value,
              child: Transform.scale(scale: 0.8 + (value * 0.2), child: child),
            );
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock, color: Colors.greenAccent, size: 110),
              const SizedBox(height: 30),
              const Text(
                'ACCESS GRANTED',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 18),
              const Text('Network Secured', style: TextStyle(fontSize: 22)),
              const SizedBox(height: 14),
              const Text(
                '+100 XP',
                style: TextStyle(
                  color: Colors.cyanAccent,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.off(() => const OperationsCentreScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor: Colors.greenAccent,
                    foregroundColor: Colors.black,
                  ),
                  child: const Text(
                    'ENTER OPERATIONS CENTRE',
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
    );
  }
}

class _FailedView extends StatelessWidget {
  final MissionController controller;

  const _FailedView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      color: Colors.red.withValues(alpha: 0.12),
      padding: const EdgeInsets.all(24),
      child: Center(
        child: TweenAnimationBuilder<double>(
          duration: const Duration(milliseconds: 700),
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
              const Text('💥', style: TextStyle(fontSize: 95)),
              const SizedBox(height: 24),
              const Text(
                'SYSTEM BREACH',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.redAccent,
                  fontSize: 34,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'The attackers reached the RADA network before the terminal was secured.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  height: 1.5,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                'Email Server: Compromised\nFarmer Database: At Risk\nCloud Storage: Exposed\nWebsite: Hacked\nSensitive Data: Leaked',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.redAccent, height: 1.8),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: controller.restartMission,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'START OVER',
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
    );
  }
}
