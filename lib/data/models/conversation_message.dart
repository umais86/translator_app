class ConversationMessage {
  final String text;
  final String translatedText;
  final String fromLang;
  final String toLang;
  final DateTime timestamp;

  ConversationMessage({
    required this.text,
    required this.translatedText,
    required this.fromLang,
    required this.toLang,
    required this.timestamp,
  });
}
