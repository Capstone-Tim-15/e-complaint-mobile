class UserProfile {
  final String id;
  final String username;

  final String name;
  final String profileImageUrl;
  final String coverImageUrl;
  final String email;
  final String phoneNumber;

  UserProfile({
    required this.id,
    required this.username,
    required this.name,
    required this.profileImageUrl,
    required this.coverImageUrl,
    required this.email,
    required this.phoneNumber,
  });
}
