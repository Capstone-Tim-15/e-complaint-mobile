class News {
  final String id;
  final String adminId;
  final String category;
  final String name;
  final String photoImage;
  final String title;
  final String content;
  final String date;
  final String imageUrl;
  final List<Feedback>? feedback;
  final String like;
  int commentCount;

  News(
      {required this.id,
      required this.adminId,
      required this.category,
      required this.name,
      required this.photoImage,
      required this.title,
      required this.content,
      required this.date,
      required this.imageUrl,
      required this.feedback,
      required this.like,
      this.commentCount = 0});
}

class Feedback {
  final String id;
  final String fullname;
  final String role;
  final String photoImage;
  final String newsId;
  final String content;

  Feedback({
    required this.id,
    required this.fullname,
    required this.role,
    required this.photoImage,
    required this.newsId,
    required this.content,
  });

  static fromJson(i) {}
}
