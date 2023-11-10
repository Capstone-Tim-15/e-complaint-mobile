class ChatMessage {
  final String text;
  final bool isSender;

  ChatMessage({
    this.text = '',
    required this.isSender,
  });
}

List<ChatMessage> chatMessage = [
  ChatMessage(
    text:
        "Hai! Selamat datang di Gov-Complaint Batam. Saya adalah asisten virtual pertama anda. Silahkan pilih topik yang ingin anda tanyakan1",
    isSender: false,
  ),
];
