import 'dart:convert';

import 'package:chatgpt/controller/define.dart';
import 'package:http/http.dart' as http;

class NetwrokChatGPt {
  static Map<String, String> header = {
    'Content-type': 'application/json',
    'Authorization': 'Bearer $apiKey'
  };
  static sendMessage(String? message) async {
    var response = await http.post(Uri.parse(baseUrl),
        headers: header,
        body: jsonEncode({
          "model": "text-davinci-003",
          "prompt": '$message',
          "temperature": 100,
          "top_p": 1,
          "frequency_penalty": 0.0,
          "presence_penalty": 0.0,
          "stop": ["Human", "AI: "]
        }));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      var msg = data['choices'][0]['text'];
      return msg;
    } else {
      print(response.statusCode);
    }
  }
}
