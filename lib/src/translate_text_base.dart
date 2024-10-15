import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class TranslateTextBase {
  final String _baseUrl = 'https://api.mymemory.translated.net/get';

  /// Translates the given [text] from [sourceLang] to [targetLang].
  /// Returns the translated text or throws an exception if the translation fails.
  Future<String> translateText(
      String text, String sourceLang, String targetLang) async {
    final url = Uri.parse(
        '$_baseUrl?q=${Uri.encodeComponent(text)}&langpair=$sourceLang|$targetLang');

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

  /// Translate a list of texts and return a single string with translations.
  Future<String> translateListOfTexts(
      List<String> texts, String sourceLang, String targetLang) async {
    StringBuffer translatedTexts = StringBuffer();

    for (String text in texts) {
      try {
        String translatedText =
            await translateText(text, sourceLang, targetLang);
        translatedTexts
            .write(translatedText); // Append the translation without a new line
        translatedTexts.write(', '); // Append a comma after each translation
      } catch (e) {
        translatedTexts
            .write('Error: $e, '); // Append error message if it occurs
      }
    }

    // Return the translated texts as a single string and remove the trailing comma
    String result = translatedTexts.toString();
    if (result.endsWith(', ')) {
      result =
          result.substring(0, result.length - 2); // Remove the trailing comma
    }

    return result;
  }

  /// Translate texts from a file and return a single string with translations.
  Future<String> translateTextsFromFile(
      String filePath, String sourceLang, String targetLang) async {
    final File file = File(filePath);

    // Read the file
    List<String> texts = await file.readAsLines();

    // Check if the total word count exceeds 2000
    int totalWords =
        texts.map((text) => text.split(' ').length).reduce((a, b) => a + b);
    if (totalWords > 2000) {
      throw Exception('The total word count exceeds the limit of 2000 words.');
    }
    // Translate the texts
    return await translateListOfTexts(texts, sourceLang, targetLang);
  }
}
