import 'package:translate_text/translate_text.dart';

void main() async{
  final textService = TranslationService();
 final text= await textService.translateText("Hello World!", "en", "ar");
  print(text);
  //output: مرحبا بالعالم  

  // Path to the file containing texts to translate
  const filePath = 'texts.txt'; // Path to the file containing texts to translate
  const sourceLang = 'en';       // Source language code (e.g., 'en' for English)
  const targetLang = 'es';       // Target language code (e.g., 'es' for Spanish)

  // Get the translated texts as a single string
  String result = await textService.translateTextsFromFile(filePath, sourceLang, targetLang);
  
  // Print the result
  print(result); 

  //:input Hello world !How are you? This is a translation test.
  // output:¡Hola mundo!, ¿Cómo estás?, Esta es una prueba de traducción.

  // List of texts to translate
  List<String> textsToTranslate = [
    'Hello world!',
    'How are you?',
    'This is a translation test.'
  ];

  // Translate the list of texts
  String list = await textService.translateListOfTexts(textsToTranslate, sourceLang, targetLang);
  
  // Print the result
  print(list);
  //output:¡Hola mundo!, ¿Cómo estás?, Esta es una prueba de traducción.

}
