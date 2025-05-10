import 'package:flutter/material.dart';
import 'package:translator_app/data/models/translation_repository.dart';
import 'package:translator_app/viewmodel/lang_model.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class TranslationViewModel extends ChangeNotifier {
  final TranslationRepository _repository;
  TranslationViewModel(this._repository) {
    _initializeTts();
    _initializeSpeech();
  }

  String _translatedText = '';
  String _sourceText = '';
  bool _isLoading = false;
  bool _isListening = false;

  final FlutterTts _flutterTts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();

  LanguageModel? _sourceLanguage;
  LanguageModel? _targetLanguage;

  String get translatedText => _translatedText;
  String get sourceText => _sourceText;
  bool get isLoading => _isLoading;
  bool get isListening => _isListening;

  LanguageModel? get sourceLanguage => _sourceLanguage;
  LanguageModel? get targetLanguage => _targetLanguage;

  void setLanguages(LanguageModel source, LanguageModel target) {
    _sourceLanguage = source;
    _targetLanguage = target;
    _flutterTts.setLanguage(target.code);
  }

  void swapLanguages() {
    final temp = _sourceLanguage;
    _sourceLanguage = _targetLanguage;
    _targetLanguage = temp;

    if (_translatedText.isNotEmpty) {
      _sourceText = _translatedText;
      _translatedText = '';
    }

    _flutterTts.setLanguage(_targetLanguage!.code);
    notifyListeners();
  }

  void setSourceText(String text) {
    _sourceText = text;
    notifyListeners();
  }

  Future<void> translateText() async {
    if (_sourceText.isEmpty || _sourceLanguage == null || _targetLanguage == null) return;

    _isLoading = true;
    notifyListeners();

    try {
      _translatedText = await _repository.translate(
        _sourceText,
        from: _sourceLanguage!.code,
        to: _targetLanguage!.code,
      );
    } catch (e) {
      _translatedText = 'Error: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  void clearText() {
    _sourceText = '';
    _translatedText = '';
    notifyListeners();
  }

  Future<void> pasteText() async {
    ClipboardData? data = await Clipboard.getData(Clipboard.kTextPlain);
    if (data != null && data.text != null) {
      _sourceText = data.text!;
      notifyListeners();
    }
  }

  Future<void> speakTranslatedText() async {
    if (_translatedText.isNotEmpty) {
      await _flutterTts.speak(_translatedText);
    }
  }

  Future<void> _initializeTts() async {
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.setVolume(1.0);
    await _flutterTts.setPitch(1.0);
  }

  Future<void> _initializeSpeech() async {
    await _speech.initialize();
  }

  Future<void> startListening() async {
    if (!_isListening && _sourceLanguage != null) {
      bool available = await _speech.initialize();
      if (available) {
        _isListening = true;
        notifyListeners();

        _speech.listen(
          onResult: (result) {
            if (result.finalResult) {
              _sourceText = result.recognizedWords;
              _isListening = false;
              notifyListeners();
              translateText();
            }
          },
          localeId: _sourceLanguage!.code,
        );
      }
    }
  }

  void stopListening() {
    _speech.stop();
    _isListening = false;
    notifyListeners();
  }

  @override
  void dispose() {
    _flutterTts.stop();
    _speech.stop();
    super.dispose();
  }
}
