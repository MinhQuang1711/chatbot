import 'dart:ffi';

import 'package:flutter_application_2/services/network.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../model/chat_message_model.dart';
import '../const/define.dart';

 class SpeechService{
  String startListen(String text, SpeechToText speech){
    speech.listen(
      onResult: (result) => text=result.recognizedWords,
    );
    return text; 
  }

  Future<void> StopListen(String text,SpeechToText speech) async{
    speech.stop();
    listMessage
          .add(ChatMessage(message: text, type: ChatMesageType.user));
  }

}