import 'package:avatar_glow/avatar_glow.dart';
import 'package:chatgpt/controller/network_chat_gpt.dart';
import 'package:chatgpt/model/chat_message_model.dart';
import 'package:chatgpt/view/widget/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String lastText = "";
  bool isListening = false;
  SpeechToText _speech = new SpeechToText();
  List<ChatMessage> listMessage = [
    ChatMessage(message: 'this iss first message', type: ChatMesageType.user)
  ];
  NetwrokChatGPt netwrokChatGPt = new NetwrokChatGPt();
  void onListen() async {
    if (!isListening) {
      bool available = await _speech.initialize(
          onStatus: (val) => print('onStatus: $val'),
          onError: (val) => print('onError: $val'));
      if (available) {
        setState(() {
          isListening = true;
        });
        _speech.listen(
          onResult: (result) {
            lastText = result.recognizedWords;
          },
        );
      }
    } else {
      setState(() async {
        isListening = false;
      });
      _speech.stop();
      listMessage
          .add(ChatMessage(message: lastText, type: ChatMesageType.user));
      String? msg = await NetwrokChatGPt.sendMessage(lastText);
      setState(() {
        listMessage.add(ChatMessage(message: msg, type: ChatMesageType.bot));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
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
                      size: size,
                      textMessage: listMessage[index].message);
                },
              )),
            ),
            Spacer(),
            AvatarGlow(
              child: FloatingActionButton(
                child: Icon(
                  isListening ? Icons.mic : Icons.mic_none,
                ),
                onPressed: () {
                  onListen();
                },
              ),
              endRadius: 80,
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
