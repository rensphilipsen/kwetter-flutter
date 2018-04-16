class User {
  final int id;
  final String username;
  final String email;
  final String profilePicture;
  final String location;
  final String website;
  final String bio;
  var followers = [];
  var following = [];
  var kweets = [];

  User({
    this.id,
    this.username,
    this.email,
    this.profilePicture,
    this.location,
    this.website,
    this.bio,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return new User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      profilePicture: json['profilePicture'],
      location: json['location'],
      website: json['website'],
      bio: json['bio'],
    );
  }
}
