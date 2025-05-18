import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class TranslationRepository {
  Future<String> translate(
    String text, {
    required String from,
    required String to,
  }) async {
    final encodedText = Uri.encodeComponent(text);
    final url = Uri.parse(
      'https://api.mymemory.translated.net/get?q=$encodedText&langpair=$from|$to',
    );
    log(url.toString());
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['responseData']['translatedText'] ?? 'Translation failed';
    } else {
      throw Exception('Translation API error: ${response.statusCode}');
    }
  }
}
