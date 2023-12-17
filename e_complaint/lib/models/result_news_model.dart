class ResultNewsModel {
  final String id;
  final String adminId;
  final String category;
  final String fullname;
  final String photoImage;
  final String title;
  final String content;
  final String date;
  final String imageUrl;
  final List<Map<String, dynamic>>? feedback;
  final List<Map<String, dynamic>>? likes;

  ResultNewsModel({
    required this.id,
    required this.adminId,
    required this.category,
    required this.fullname,
    required this.photoImage,
    required this.title,
    required this.content,
    required this.date,
    required this.imageUrl,
    this.feedback,
    this.likes,
  });

  factory ResultNewsModel.fromJson(Map<String, dynamic> json) {
    return ResultNewsModel(
      id: json['id'],
      adminId: json['adminId'],
      category: json['category'],
      fullname: json['fullname'],
      photoImage: json['photoImage'],
      title: json['title'],
      content: json['content'],
      date: json['date'],
      imageUrl: json['imageUrl'],
      feedback: List<Map<String, dynamic>>.from(json['feedback'] ?? []),
      likes: List<Map<String, dynamic>>.from(json['likes'] ?? []),
    );
  }
}
