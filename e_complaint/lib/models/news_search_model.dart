class NewsSearchModel {
  final String id;
  final String adminId;
  final String category;
  final String name;
  final String photoImage;
  final String title;
  final String content;
  final String date;
  final String imageUrl;
  final String? feedback;
  final String? likes;

  NewsSearchModel({
    required this.id,
    required this.adminId,
    required this.category,
    required this.name,
    required this.photoImage,
    required this.title,
    required this.content,
    required this.date,
    required this.imageUrl,
    this.feedback,
    this.likes,
  });

  factory NewsSearchModel.fromJson(Map<String, dynamic> json) {
    return NewsSearchModel(
      id: json['id'],
      adminId: json['adminId'],
      category: json['category'],
      name: json['name'],
      photoImage: json['photoImage'],
      title: json['title'],
      content: json['content'],
      date: json['date'],
      imageUrl: json['imageUrl'],
      feedback: json['feedback'],
      likes: json['likes'],
    );
  }
}
