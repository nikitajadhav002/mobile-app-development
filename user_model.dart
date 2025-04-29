class User {
  final String id;
  final String username;
  final String email;

  User({
    required this.id,
    required this.username,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'email': email,
      };

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        username: json['username'],
        email: json['email'],
      );
}
