import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationAPI {
  final String baseUrl = "https://api.mymemory.translated.net/get";

  Future<String> translateText({
    required String text,
    required String fromLang,
    required String toLang,
  }) async {
    final encodedText = Uri.encodeComponent(text);
    final url = "$baseUrl?q=$encodedText&langpair=$fromLang|$toLang";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['responseData']['translatedText'] ?? "Translation failed";
      } else {
        throw Exception("Failed to fetch translation");
      }
    } catch (e) {
      throw Exception("Error: $e");
    }
  }
}
