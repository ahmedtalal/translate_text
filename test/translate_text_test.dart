import 'package:test/test.dart';
import 'package:translate_text/translate_text.dart';

void main() {
  final translationService = TranslateTextBase();

  test('Translation of Hello world from English to Spanish', () async {
    final result = await translationService.translateText('Hello world!', 'en', 'es');
    expect(result, isNotNull);
    expect(result, isNot('Error in translation'));
  });
}
