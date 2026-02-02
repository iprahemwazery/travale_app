class User {
  final int id;
  final String username;
  final String name;
  final String firstName;
  final String lastName;
  final String email;
  final String avatarUrl;

  User({
    required this.id,
    required this.username,
    required this.name,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.avatarUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] ?? 0,
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      firstName: json['first_name'] ?? '',
      lastName: json['last_name'] ?? '',
      email: json['email'] ?? '',
      avatarUrl:
          json['avatar_urls'] != null ? (json['avatar_urls']['96'] ?? '') : '',
    );
  }
}
