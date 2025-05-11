import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:translator_app/data/models/translation_provider.dart';

class FileTranslationProvider extends ChangeNotifier {
  String? selectedFileName;
  String? fileContent;
  String? translatedContent;
  String? errorMessage;
  bool isLoading = false;

  String fromLanguage = '';
  String toLanguage = '';
  late final TranslationProvider translationProvider;

  Future<void> selectFile() async {
    _setLoading(true);

    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt', 'json', 'csv'],
      );

      if (result != null) {
        final file = result.files.first;
        selectedFileName = file.name;

        if (file.path != null) {
          fileContent = await File(file.path!).readAsString();
        } else if (file.bytes != null) {
          fileContent = utf8.decode(file.bytes!);
        } else {
          throw Exception('Could not read file content.');
        }
      }
    } catch (e) {
      errorMessage = 'Error selecting file: ${e.toString()}';
    }

    _setLoading(false);
  }

  Future<void> translateFile() async {
    if (fileContent == null || fileContent!.isEmpty) {
      errorMessage = 'No file content to translate.';
      notifyListeners();
      return;
    }

    _setLoading(true);

    try {
      final translated = await translateText(
        fileContent!,
        fromLanguage,
        toLanguage,
      );
      translatedContent = translated;
    } catch (e) {
      errorMessage = 'Translation error: ${e.toString()}';
    }

    _setLoading(false);
  }

  Future<String> translateText(String text, String from, String to) async {
    final uri = Uri.parse('https://api.mymemory.translated.net/get');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {'q': text, 'langpair': '$from|$to'},
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['responseData']['translatedText'] ?? 'Translation failed.';
    } else {
      throw Exception('Failed to fetch translation.');
    }
  }

  void changeFromLanguage(String lang) {
    fromLanguage = lang;
    notifyListeners();
  }

  void changeToLanguage(String lang) {
    toLanguage = lang;
    notifyListeners();
  }

  void _setLoading(bool loading) {
    isLoading = loading;
    errorMessage = null;
    notifyListeners();
  }
}
