class Complaint {
  final String categoryId;
  final String title;
  final String status;
  final String content;
  final String attachment;

  Complaint({
    required this.categoryId,
    required this.title,
    required this.status,
    required this.content,
    required this.attachment,
  });

  // Metode untuk mengonversi objek ke map untuk dikirim sebagai formulir
  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'title': title,
      'status': status,
      'content': content,
      'attachment': attachment,
    };
  }
}
