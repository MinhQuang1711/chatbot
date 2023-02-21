import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/constant.dart';
import 'package:flutter_application_3/define.dart';
import 'package:flutter_application_3/model/message_model.dart';
import 'package:flutter_application_3/service/network.dart';
import 'package:flutter_application_3/service/speech_service.dart';
import 'package:flutter_application_3/view/screens/main_page/loading.dart';
import 'package:flutter_application_3/view/widget/chat_widget.dart';

import 'package:flutter_tts/flutter_tts.dart'as tts;
import 'package:speech_to_text/speech_to_text.dart';
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool userManual=false;
  var msg;
  var available;
  bool isListening= false;
  String lastText="";
  SpeechToText speech= SpeechToText(); 
  List<MessageModel> listMessage=[];
  late Timer  _timer;
  tts.FlutterTts textToSpeech= tts.FlutterTts();

  speak(List<String> listtext)async{
    await textToSpeech.setLanguage("vi-VN");
    for(int i=0 ; i < listtext.length;i++)
    {
      await textToSpeech.speak(listtext[i]);
    }
  }

  stopSpeak()async{
    await textToSpeech.stop();
  }

  void startUserManual(){
    if(!userManual)
    {
      setState(() {
        userManual=true;
      });
      speak(listQuestions);
    }
    else{
      setState(() {
        userManual=false;
      });
      stopSpeak();
    }
  }

  void CountTime() {
  int _start = 7;
  const oneSec = const Duration(seconds: 1);
  _timer = new Timer.periodic(
    oneSec,
    (Timer timer) {
      if (_start == 0) {
        setState(() {
          isListening=false;
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    },
  );
}

  void onListen() async{
    if(!isListening){
      startListening();
      CountTime();
    }
    else{
      stopListening();
    }
  }

  void startListening(){
    if(available==true)
      {
        setState(() {
        isListening=true;
      });
      SpeechService.listening(speech, lastText);
      }
  }

  void stopListening()async{
  var support = await  speech.locales();
    setState(() {
        isListening=false;
      });
      speech.stop();
      listMessage.add(MessageModel(messages: lastText, type: chatMessageType.user));
      msg= await Network.sendMessage(lastText);
      setState(() {
        listMessage.add(MessageModel(messages: msg, type: chatMessageType.bot));
      });
  }

  void initiSpeech() async{
    available= await speech.initialize(
      onStatus: (status) => print("onStatus: $status"),
      onError: (error) =>print("onError: $error") ,
    );
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initiSpeech();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
          onPressed: ()=> startUserManual(),
          icon: iconQuestion)
        ],
        backgroundColor: Colors.white,
        centerTitle: true,
        title:title
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.7,
            width: MediaQuery.of(context).size.width,
            child:isListening==true?Loading(isListening: isListening): ListView.builder(
              itemCount:userManual==true?listQuestions.length:listMessage.length,
              itemBuilder: (context,index){
                return userManual==true? manualWidget(index: index): chatWidget(index: index, listMessage: listMessage);
              }
            ),
          ),
          Center(
            child: FloatingActionButton(
              backgroundColor: Colors.red.shade700,
              child: Icon(!isListening?Icons.mic:Icons.stop),
              onPressed: ()=> onListen()
            ),
          )
        ],
      ),
    );
  }
}

class chatWidget extends StatelessWidget {
   chatWidget({
    required this.index,
    super.key,
    required this.listMessage,
  });
  int index;
  final List<MessageModel> listMessage;
  @override
  Widget build(BuildContext context) {
    return ChatWidget(
      type: listMessage[index].type,
      textColor: Colors.blueGrey.shade900,
      backgroundColor: Colors.white, 
      textMessage: listMessage[index].messages);
  }
}

class manualWidget extends StatelessWidget {
   manualWidget({
    required this.index,
    super.key,
  });
  int index;
  @override
  Widget build(BuildContext context) {
    return Container(margin: EdgeInsets.only(left:120),child: Text(listQuestions[index]));
  }
}