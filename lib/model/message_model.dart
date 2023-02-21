enum chatMessageType{user,bot}
class MessageModel{
  String? messages;
  chatMessageType ? type; 
  MessageModel({required this.messages, required this.type});
}