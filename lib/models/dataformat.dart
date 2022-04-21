import 'persistence.dart' as persistence;

class User {
  persistence.User user;
  int badges;

  User(this.user, this.badges);

  User.fromJson(Map<String, dynamic> map) :
        user = persistence.User.fromJson(map),
        badges = map["badges"] ?? 0;
}