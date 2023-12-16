// Define the model class
class ComplaintModel {
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
  final List<Map<String, dynamic>> comment;

  ComplaintModel({
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
    required this.comment,
  });
}
