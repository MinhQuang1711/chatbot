import 'package:flutter_application_3/define.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart'as tts;
class SpeechService{
  
static speak(List<String> listtext,tts.FlutterTts textToSpeech )async{
  await textToSpeech.setLanguage("vi-VN");
  var question=listtext.join("");
  await textToSpeech.speak(titleManual+question);
}

static stopSpeak(tts.FlutterTts textToSpeech)async=>textToSpeech.stop();
  
}