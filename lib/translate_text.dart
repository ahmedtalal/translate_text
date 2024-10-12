library text_translation;

import 'dart:convert';
import 'package:http/http.dart' as http;

class TranslationService {
  final String baseUrl = 'https://api.mymemory.translated.net/get';

  /// Translates the given [text] from [sourceLang] to [targetLang].
  /// Returns the translated text or throws an exception if the translation fails.
  Future<String> translateText(String text, String sourceLang, String targetLang) async {
    final url = Uri.parse(
        '$baseUrl?q=${Uri.encodeComponent(text)}&langpair=$sourceLang|$targetLang');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Validate response structure
        if (data is Map<String, dynamic> &&
            data.containsKey('responseData') &&
            data['responseData'] is Map<String, dynamic>) {
          final translatedText = data['responseData']['translatedText'];
          return translatedText ?? 'Translation not found';
        } else {
          throw Exception('Invalid response format');
        }
      } else {
        throw Exception('Error in translation: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Translation failed: $e');
    }
  }
}
