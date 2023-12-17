class News {
  final String id;
  final String adminId;
  final String category;
  final String fullname;
  final String photoImage;
  final String title;
  final String content;
  final String date;
  final String imageUrl;
  final List<Feedback>? feedback;
  final List<Likes>? likes;
  int feedbackCount;
  int likesCount;

  News(
      {required this.id,
      required this.adminId,
      required this.category,
      required this.fullname,
      required this.photoImage,
      required this.title,
      required this.content,
      required this.date,
      required this.imageUrl,
      required this.feedback,
      required this.likes,
      this.feedbackCount = 0,
      this.likesCount = 0});
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

class Likes {
  final String id;
  final String userId;
  final String newsId;
  final String status;

  Likes({
    required this.id,
    required this.userId,
    required this.newsId,
    required this.status,
  });
}
