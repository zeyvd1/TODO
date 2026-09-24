class UserModel {
  const UserModel({required this.id, required this.username, this.image});

  final int id;
  final String username;
  final String? image;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? json['user_id'] ?? 0,
      username: json['username'] ?? '',
      image: json['image'] ?? json['image_url'],
    );
  }
}
