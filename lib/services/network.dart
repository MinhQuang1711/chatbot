import 'dart:convert';

import 'package:http/http.dart' as http;

import '../const/define.dart';

class NetworkRquest{
    static sendMessage( String ?text)async{
      var response = await http.put(Uri.parse(apiUrl+ text!)); 
      if(response.statusCode==200)
      {
        print(jsonDecode(utf8.decode(response.bodyBytes))["text"].runtimeType);
        return jsonDecode(utf8.decode(response.bodyBytes))["text"];
      }
      else{
        print("Error:"+response.statusCode.toString());
        return "";
      }
    }
}