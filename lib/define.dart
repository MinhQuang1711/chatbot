
import 'package:flutter/material.dart';
import 'model/message_model.dart';
Text title= Text("Trợ lý ảo hỗ trợ sử dụng hệ thống \n        dịch vụ ngân hàng tự động",style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold,color: Colors.blueGrey.shade900));
Text titleWaiting=Text('Xin vui lòng nói câu hỏi và bấm nút dừng hoặc đợi sau 5s sau khi kết thúc câu hỏi để nhận câu trả lời.',style: TextStyle(fontSize: 18));
String titleManual="Đây là một số câu hỏi tôi có thể trả lời: ";
List<MessageModel> listMessage = [];