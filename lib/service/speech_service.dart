import 'package:flutter_application_3/define.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart'as tts;
class SpeechService{

static String listening(SpeechToText speech,String lastText){
   speech.listen
    (onResult: (result) => lastText=result.recognizedWords);
    print("type lastText: ${lastText.runtimeType}");
    return lastText;
}

static speak(List<String> listtext,tts.FlutterTts textToSpeech )async{
    await textToSpeech.setLanguage("vi-VN");
    var listString=listtext.join("");
    await textToSpeech.speak(listString);
  }

static stopSpeak(tts.FlutterTts textToSpeech)async=>textToSpeech.stop();
  
}