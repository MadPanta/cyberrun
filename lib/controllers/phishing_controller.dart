import 'package:get/get.dart';

import '../models/email_message.dart';

class PhishingController extends GetxController {
  final RxInt correctReports = 0.obs;
  final RxInt mistakes = 0.obs;
  final RxInt inspectedEmails = 0.obs;

  final RxList<int> handledEmailIds = <int>[].obs;

  final List<EmailMessage> emails = const [
    EmailMessage(
      id: 1,
      sender: 'ICT Support',
      senderEmail: 'it-support@rada-security-update.xyz',
      subject: 'URGENT - Password Verification Required',
      preview: 'Your mailbox will be disabled today unless you verify...',
      body:
          'Dear Employee,\n\n'
          'Your RADA mailbox has exceeded its storage limit and will be disabled today.\n\n'
          'You must verify your password immediately to avoid losing access.\n\n'
          'This action is required within 15 minutes.\n\n'
          'Regards,\nICT Support Team',
      link: 'http://rada-login-verification.xyz',
      isPhishing: true,
    ),
    EmailMessage(
      id: 2,
      sender: 'CEO Office',
      senderEmail: 'ceo.office@rada.gov.jm',
      subject: 'Management Meeting Reminder',
      preview: 'Reminder: Senior management meeting is scheduled...',
      body:
          'Good morning,\n\n'
          'This is a reminder that the senior management meeting is scheduled for tomorrow at 9:00 AM.\n\n'
          'Please review the agenda before attending.\n\n'
          'Regards,\nCEO Office',
      link: '',
      isPhishing: false,
    ),
    EmailMessage(
      id: 3,
      sender: 'Human Resources',
      senderEmail: 'hr@rada.gov.jm',
      subject: 'Payslip Available',
      preview: 'Your monthly payslip is now available in the HR portal...',
      body:
          'Good day,\n\n'
          'Your monthly payslip is now available in the official HR portal.\n\n'
          'Please log in through the staff intranet to view it.\n\n'
          'Regards,\nHuman Resources',
      link: '',
      isPhishing: false,
    ),
    EmailMessage(
      id: 4,
      sender: 'Microsoft 365',
      senderEmail: 'support@office365-storage-alert.xyz',
      subject: 'Storage Almost Full',
      preview: 'Your OneDrive storage is almost full. Upgrade now...',
      body:
          'Your Microsoft 365 storage is almost full.\n\n'
          'To prevent file deletion, verify your account immediately.\n\n'
          'Failure to act may result in permanent file loss.',
      link: 'http://office365-login-security.xyz',
      isPhishing: true,
    ),
  ];

  bool isHandled(int emailId) {
    return handledEmailIds.contains(emailId);
  }

  void markHandled(int emailId) {
    if (!handledEmailIds.contains(emailId)) {
      handledEmailIds.add(emailId);
    }
  }

  void reportEmail(EmailMessage email) {
    if (isHandled(email.id)) return;

    inspectedEmails.value++;

    if (email.isPhishing) {
      correctReports.value++;
    } else {
      mistakes.value++;
    }

    markHandled(email.id);
  }

  void trustEmail(EmailMessage email) {
    if (isHandled(email.id)) return;

    inspectedEmails.value++;

    if (email.isPhishing) {
      mistakes.value++;
    }

    markHandled(email.id);
  }

  bool get missionComplete {
    return correctReports.value >= 2;
  }

  int get score {
    final rawScore = (correctReports.value * 75) - (mistakes.value * 25);
    return rawScore < 0 ? 0 : rawScore;
  }
}
