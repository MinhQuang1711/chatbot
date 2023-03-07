import 'package:flutter_application_3/define.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart'as tts;
 class SpeechService{
  SpeechToText speechToText= SpeechToText();
  tts.FlutterTts textToSpeech = tts.FlutterTts();
  String textResult="";

  void StopListen(){
    speechToText.stop();
  }
  
   void speak(String text)async{
    await textToSpeech.setLanguage("vi-VN");
    await textToSpeech.speak(text);
  }

   stopSpeak()async=>textToSpeech.stop();
    
}