import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_2/services/speech_service.dart';
import 'package:flutter_application_2/services/network.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../model/chat_message_model.dart';
import '../../const/define.dart';
import '../widget/chat_widget.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool ?available;
  String lastText = "Thẻ bị kẹt";
  String msg=" ";
  bool isListening = false;
  SpeechToText _speech=  SpeechToText();
  SpeechService speechService=  SpeechService();


  void onListen()async{ 
    if (!isListening) {
        startListen();
    }
     else {
      finishListen();
    }
  }
  
  void finishListen() async{
    setState(()  {
        isListening = false;
      });
      speechService.StopListen(lastText,_speech);
      sendMessage();
     }
  
  void sendMessage()async{
      String? msg = await NetworkRquest.sendMessage(lastText);
      setState(() {
        listMessage.add(ChatMessage(message: msg, type: ChatMesageType.bot));
      });
  }
  void startListen(){
    if(available== true)
    {
      setState(() {
        isListening=true;
      });
      lastText= speechService.startListen(lastText, _speech);
    }
  }

  void initSpeech() async{
    available= await _speech.initialize();
  }

  @override
  void initState() {
    super.initState();
    initSpeech();

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey.shade900,
        centerTitle: true,
        title: Text("Chat bot Sao Khue!",style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * .7,
              color: Colors.blueGrey,
              child: Center(
                  child: ListView.builder(
                itemCount: listMessage.length,
                itemBuilder: (context, index) {
                  return ChatWidget(
                      type: listMessage[index].type,
                      textColor: Colors.blueGrey,
                      backgroundColor: Colors.white60,
                      textMessage: listMessage[index].message);
                },
              )),
            ),
            AvatarGlow(
              
              child: FloatingActionButton(
                backgroundColor: Colors.blueGrey.shade800,
                child: Icon(
                  isListening ? Icons.mic : Icons.mic_none,
                ),
                onPressed: () {
                  onListen();
                },
              ),
              endRadius: 50,
              glowColor: Colors.blueGrey,
              showTwoGlows: true,
              animate: isListening,
              duration: Duration(milliseconds: 2000),
              repeat: true,
              repeatPauseDuration: Duration(microseconds: 100),
            )
          ],
        ),
      ),
    );
  }
}
