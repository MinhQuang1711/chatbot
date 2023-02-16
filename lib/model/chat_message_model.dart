enum ChatMesageType { user, bot }

class ChatMessage {
  String ?message;
  ChatMesageType type;
  ChatMessage({required this.message, required this.type});
}
