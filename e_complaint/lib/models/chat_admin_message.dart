class ChatAdminMessage {
  final String text;
  final bool isUser;

  ChatAdminMessage({
    this.text = '',
    required this.isUser,
  });
}

List<ChatAdminMessage> chatAdminMessage = [
  ChatAdminMessage(
    text:
        "Hai! Selamat datang di Gov-Complaint Batam. Saya adalah asisten virtual pertama anda. Silahkan pilih topik yang ingin anda tanyakan1",
    isUser: false,
  ),
];
