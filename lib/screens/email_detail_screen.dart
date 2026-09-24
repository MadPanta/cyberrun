import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/phishing_controller.dart';
import '../models/email_message.dart';

class EmailDetailScreen extends StatelessWidget {
  final EmailMessage email;
  final String controllerTag;

  const EmailDetailScreen({
    super.key,
    required this.email,
    required this.controllerTag,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PhishingController>(tag: controllerTag);

    return Scaffold(
      backgroundColor: const Color(0xFF05070D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF05070D),
        title: const Text('Email Inspection'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Obx(() {
            final handled = controller.isHandled(email.id);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _emailHeader(),
                const SizedBox(height: 24),
                _emailBody(),
                const SizedBox(height: 24),
                if (email.link.isNotEmpty) _linkWarningBox(),
                const SizedBox(height: 28),
                if (!handled) _decisionButtons(controller) else _handledBox(),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _emailHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'MESSAGE DETAILS',
            style: TextStyle(
              color: Colors.cyanAccent,
              fontSize: 13,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            email.subject,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'From: ${email.sender}',
            style: const TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 6),
          Text(
            email.senderEmail,
            style: TextStyle(
              color: email.senderEmail.endsWith('@rada.gov.jm')
                  ? Colors.greenAccent
                  : Colors.orangeAccent,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }

  Widget _emailBody() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white12),
      ),
      child: Text(
        email.body,
        style: const TextStyle(
          color: Colors.white70,
          height: 1.55,
          fontSize: 15,
        ),
      ),
    );
  }

  Widget _linkWarningBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.orangeAccent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.orangeAccent.withValues(alpha: 0.55)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'LINK FOUND',
            style: TextStyle(
              color: Colors.orangeAccent,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            email.link,
            style: const TextStyle(color: Colors.orangeAccent, fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _decisionButtons(PhishingController controller) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              controller.reportEmail(email);

              Get.snackbar(
                email.isPhishing ? 'Correct' : 'Incorrect',
                email.isPhishing
                    ? 'This email was reported as phishing.'
                    : 'This email was legitimate.',
                snackPosition: SnackPosition.BOTTOM,
              );

              Get.back();
            },
            icon: const Icon(Icons.report),
            label: const Text('REPORT PHISHING'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              controller.trustEmail(email);

              Get.snackbar(
                email.isPhishing ? 'Mistake' : 'Correct',
                email.isPhishing
                    ? 'You trusted a phishing email.'
                    : 'This email was safe.',
                snackPosition: SnackPosition.BOTTOM,
              );

              Get.back();
            },
            icon: const Icon(Icons.check_circle),
            label: const Text('MARK AS SAFE'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyanAccent,
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
      ],
    );
  }

  Widget _handledBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.greenAccent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.greenAccent.withValues(alpha: 0.5)),
      ),
      child: const Text(
        'This email has already been inspected.',
        style: TextStyle(
          color: Colors.greenAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
