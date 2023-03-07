import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_3/constants/list.dart';
import 'package:flutter_application_3/define.dart';
import 'package:flutter_application_3/model/message_model.dart';
import 'package:flutter_application_3/service/network.dart';
import 'package:flutter_application_3/service/speech_service.dart';
import 'package:flutter_application_3/view/screens/main_page/loading.dart';
import 'package:flutter_application_3/view/screens/main_page/manual_widget.dart';
import 'package:flutter_application_3/view/widget/chat_widget.dart';

import 'package:flutter_tts/flutter_tts.dart' as tts;
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_application_3/constants/color.dart';
import '../../../constants/icon.dart';
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var msg;
  var available;
  bool userManual = false;
  bool isListening = false;
  late Timer _timer;
  String lastText = "";
  SpeechService service= SpeechService();
  SpeechToText speech = SpeechToText();
  var textUserManual=titleManual+ listQuestions.join("");

  void stopSpeak()=> service.stopSpeak();
  void startSpeak(String text)=> service.speak(text);
  void CountTime() async {
    int _start = 5;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            stopListening();
            timer.cancel();
          });
        } else {
          if (isListening == false) {
            timer.cancel();
          } else {
            setState(() {
              _start--;
            });
          }
        }
      },
    );
  }

  void startUserManual() {
    if (!userManual) {
      setState(() {
        userManual = true;
      });
      startSpeak(textUserManual);
      
    } else {
      setState(() {
        userManual = false;
      });
      stopSpeak();
    }
  }

  void onListen(){
    print('touched');
    if (!isListening) {
      print('startListening');
      startListening();
    } else {
      stopListening();
    }
  }

  void initiSpeech() async {
    available = await speech.initialize();
  }
  void startListening()async{
    if(available==true)
    {
      setState(() {
        isListening=true;
      });
      await speech.listen(
        localeId: "vi_VN",
        onResult: (result) => setState(() {
          lastText=result.recognizedWords;
        })); 
       CountTime();
    }
  }
  Future<String> sendData(String text)async{
    listMessage.add(MessageModel(messages: text, type: chatMessageType.user));
    String response=await Network.sendMessage(text); 
    return response;
  }
  void stopListening()async{
    setState(() {
      isListening=false;
    });
    speech.stop();
    listMessage.clear(); 
    msg= await sendData(lastText);
    setState(() {
      listMessage.add(MessageModel(messages: msg, type: chatMessageType.bot));
      lastText="";
    });
    startSpeak(msg);
  }

  @override
  void initState() {
    super.initState();
    initiSpeech();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height * 0.7;
    var width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: stopSpeak,
      child: Scaffold(
        appBar: AppBar(actions: [
          IconButton(onPressed: () => startUserManual(), icon: iconQuestion)
        ], backgroundColor:color.white, centerTitle: true, title: title),
        body: userManual == true
            ? manualWidget(size: width,)
            : Column(
                children: [
                  Container(
                    height: height,
                    width: width,
                    child: isListening == true
                        ? Loading(isListening: isListening)
                        : ListView.builder(
                            itemCount: userManual == true
                                ? listQuestions.length
                                : listMessage.length,
                            itemBuilder: (context, index) => chatWidget(
                                index: index, listMessage: listMessage)),
                  ),
                  Center(
                    child: FloatingActionButton(
                        backgroundColor: color.red,
                        child: Icon(!isListening ? mic : stop),
                        onPressed: ()=>onListen()),
                  )
                ],
              ),
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
