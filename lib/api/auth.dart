import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:http/http.dart';
import 'package:kwetter_app/api/base.dart';
import 'package:kwetter_app/api/kweets.dart';
import 'package:kwetter_app/api/users.dart';
import 'package:kwetter_app/models/user.dart';

class AuthService extends BaseApiService {
  String endpointPrefix = 'authentication';

  /// Get the current authenticated user
  ///
  /// Returns async User
  Future<User> getAuthenticatedUser() async {
    Response response = await super.get(uri: 'me/' + await super.getToken());
    if (response.statusCode == HttpStatus.OK) {
      var user = json.decode(response.body);
      user = new User.fromJson(user);
      var userService = new UserService();
      var kweetService = new KweetService();
      user.followers = await userService.getFollowers();
      user.following = await userService.getFollowing();
      user.kweets = await kweetService.getKweets();
      return user;
    }
    return null;
  }

  /// Hashes password to SHA256
  ///
  /// Return the hashed password String
  String hashPassword(String password) {
    List<int> bytes = (new Utf8Codec()).encode(password);
    var digest = sha256.convert(bytes);
    var base64 = (new Base64Codec()).encode(digest.bytes);
    return base64;
  }

  /// Method to try a login to the API
  ///
  /// Returns async User
  Future<User> login(String username, String password) async {
    Response response = await super.post(body: {
      "username": username.toLowerCase(),
      "password": hashPassword(password)
    });

    if (response.statusCode == HttpStatus.OK) {
      var token = json.decode(response.body)['token'];
      await setToken(token);
      return getAuthenticatedUser();
    }
    return null;
  }

  /// Method to logout
  ///
  /// Returns boolean based on status
  bool logout() {
    return super.setToken(null) == null;
  }
}
