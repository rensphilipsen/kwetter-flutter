import 'package:kwetter_app/models/user.dart';

class Kweet {
  final int id;
  final User user;
  final String text;
  final String date;

  Kweet({this.id, this.user, this.text, this.date});

  factory Kweet.fromJson(Map<String, dynamic> json) {
    return new Kweet(
      id: json['id'],
      user: new User.fromJson(json['user']),
      text: json['text'],
      date: json['date'].toString(),
    );
  }
}
