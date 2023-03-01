import 'dart:convert';

import 'package:flutter_application_3/constants/list.dart';
import 'package:flutter_application_3/service/base_api.dart';
import 'package:http/http.dart' as http;
class Network{
  static sendMessage(String messages)async{
    var response= await http.put(Uri.parse(BaseApi.apiSaoKhue+ messages)); 
    if(response.statusCode==200){
       return jsonDecode(utf8.decode(response.bodyBytes))["text"];
    }
    else{
         print("Error:"+response.statusCode.toString());
        return "";
    }
  }
}