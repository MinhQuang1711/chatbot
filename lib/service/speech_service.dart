import 'package:speech_to_text/speech_to_text.dart';

class SpeechService{
static void listening(SpeechToText speech,String lastText)async{
  var locales = await speech.locales();
   speech.listen(
        onResult: (result) => lastText=result.recognizedWords,
        localeId: locales[121].localeId
      );
}

}