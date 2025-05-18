import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:translator_app/core/api.dart';
import 'package:translator_app/data/models/translation_provider.dart';

class SpeechProvider extends ChangeNotifier {
  final TranslationAPI translationAPI = TranslationAPI();
  final TranslationProvider translationProvider;
  SpeechProvider({required this.translationProvider});
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _spokenText = '';
  bool get isAvailable => _speech.isAvailable;
  bool get isListening => _isListening;
  String get spokenText => _spokenText;

  Future<void> initSpeech() async {
    await _speech.initialize(
      onStatus: (status) => debugPrint('Speech status: $status'),
      onError: (error) => debugPrint('Speech error: $error'),
    );
  }

  void startListening() async {
    await initSpeech();
    _speech.listen(
      onResult: (result) {
        _spokenText = result.recognizedWords;
        notifyListeners();
      },
    );
    _isListening = true;
    notifyListeners();
  }

  void stopListening() {
    _speech.stop();
    _isListening = false;

    notifyListeners();
  }

  Future<void> translate() async {
    if (_spokenText.isNotEmpty) {
      await translationAPI
          .translateText(
            text: _spokenText,
            fromLang: translationProvider.sourceLanguage.code,
            toLang: translationProvider.targetLanguage.code,
          )
          .then((translatedText) {
            debugPrint('Translated Text: $translatedText');
          })
          .catchError((error) {
            debugPrint('Translation Error: $error');
          });
    } else {
      debugPrint('No text to translate');
    }
  }
}
