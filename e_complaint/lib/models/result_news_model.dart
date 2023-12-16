class ResultNewsComplaint {
  final String id;
  final String userId;
  final String name;
  final String photoImage;
  final String category;
  final String title;
  final String content;
  final String address;
  final String status;
  final String imageUrl;
  final String createdAt;
  final String updateAt;
  final List<Map<String, dynamic>>? comment;

  ResultNewsComplaint({
    required this.id,
    required this.userId,
    required this.name,
    required this.photoImage,
    required this.category,
    required this.title,
    required this.content,
    required this.address,
    required this.status,
    required this.imageUrl,
    required this.createdAt,
    required this.updateAt,
    this.comment,
  });

  factory ResultNewsComplaint.fromJson(Map<String, dynamic> json) {
    return ResultNewsComplaint(
      id: json['id'],
      userId: json['userId'],
      name: json['name'],
      photoImage: json['photoImage'],
      category: json['category'],
      title: json['title'],
      content: json['content'],
      address: json['address'],
      status: json['status'],
      imageUrl: json['imageUrl'],
      createdAt: json['createdAt'],
      updateAt: json['updateAt'],
      comment: List<Map<String, dynamic>>.from(json['comment'] ?? []),
    );
  }
}
