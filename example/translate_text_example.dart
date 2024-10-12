import 'package:translate_text/translate_text.dart';

void main() async{
  final textService = TranslationService();
 final text= await textService.translateText("Hello World!", "en", "ar");
  print(text);
  //output: مرحبا بالعالم   
}
