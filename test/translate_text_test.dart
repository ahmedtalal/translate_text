import 'package:test/test.dart';
import 'package:translate_text/translate_text_service.dart';

void main() {
  final translationService = TranslateTextService();

  test('Translation of Hello world from English to Spanish', () async {
    final result = await translationService.translateText('Hello world!', 'en', 'es');
    expect(result, isNotNull);
    expect(result, isNot('Error in translation'));
  });
}
