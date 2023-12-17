class ChatBotMessage {
  final String text;
  final bool isSender;

  ChatBotMessage({
    this.text = '',
    required this.isSender,
  });
}

List<ChatBotMessage> chatbotMessage = [
  ChatBotMessage(
    text:
        "Hai! Selamat datang di Gov-Complaint Batam. Saya adalah asisten virtual pertama anda. Silahkan pilih topik yang ingin anda tanyakan1",
    isSender: false,
  ),
];
