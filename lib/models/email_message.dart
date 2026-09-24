class EmailMessage {
  final int id;
  final String sender;
  final String senderEmail;
  final String subject;
  final String preview;
  final String body;
  final String link;
  final bool isPhishing;
  final bool unread;

  const EmailMessage({
    required this.id,
    required this.sender,
    required this.senderEmail,
    required this.subject,
    required this.preview,
    required this.body,
    required this.link,
    required this.isPhishing,
    this.unread = true,
  });
}
