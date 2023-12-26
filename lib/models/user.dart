class User {
  final int id;
  final String login;
  final String avatarUrl;

  User({required this.id, required this.login, required this.avatarUrl});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      login: json['login'],
      avatarUrl: json['avatar_url'],
    );
  }
}
