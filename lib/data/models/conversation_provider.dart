import 'dart:developer';

import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter/material.dart';
import 'package:translator_app/data/models/conversation_message.dart';
import 'package:translator_app/data/models/translation_repository.dart';

class ConversationProvider with ChangeNotifier {
  final List<ConversationMessage> _messages = [];
  final SpeechToText _speech = SpeechToText();
  final FlutterTts _tts = FlutterTts();

  String _currentText = '';
  bool _isListening = false;

  String fromLang = "en";
  String toLang = "ar";

  List<ConversationMessage> get messages => _messages;
  String get currentText => _currentText;
  bool get isListening => _isListening;

  Future<void> startListening() async {
    bool available = await _speech.initialize();
    if (available) {
      _isListening = true;
      notifyListeners();

      _speech.listen(
        onResult: (result) {
          _currentText = result.recognizedWords;
          notifyListeners();
        },
      );
    }
  }

  Future<void> stopListening() async {
    await _speech.stop();
    _isListening = false;
    notifyListeners();
  }

  Future<void> speak(String text, String langCode) async {
    await _tts.setLanguage(langCode);
    await _tts.speak(text);
  }

  Future<void> translateAndAdd() async {
    TranslationRepository repository = TranslationRepository();
    // Replace with actual translation API call
    String translated = await repository.translate(
      _currentText,
      from: fromLang,
      to: toLang,
    );
    log('Translated: $translated');
    _messages.add(
      ConversationMessage(
        text: _currentText,
        translatedText: translated,
        fromLang: fromLang,
        toLang: toLang,
        timestamp: DateTime.now(),
      ),
    );

    _currentText = '';
    notifyListeners();
  }

  void swapLanguages() {
    final temp = fromLang;
    fromLang = toLang;
    toLang = temp;
    notifyListeners();
  }

  Future<String> mockTranslate(String text, String from, String to) async {
    await Future.delayed(Duration(milliseconds: 500));
    return "Translated($text)";
  }
}
