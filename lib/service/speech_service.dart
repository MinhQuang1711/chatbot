import 'package:flutter_application_3/define.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart'as tts;
class SpeechService{

// static Future<String> listening()async{
//   String lastText="";
//   SpeechToText speech= SpeechToText();
//   var locales = await speech.locales();
//   speech.listen(
//     onResult: (result) => lastText=result.recognizedWords,
//     localeId: locales[121].localeId
//   );
//   return lastText;
// }

static speak(List<String> listtext,tts.FlutterTts textToSpeech )async{
  await textToSpeech.setLanguage("vi-VN");
  var question=listtext.join("");
  await textToSpeech.speak(titleManual+question);
}

static stopSpeak(tts.FlutterTts textToSpeech)async=>textToSpeech.stop();
  
}