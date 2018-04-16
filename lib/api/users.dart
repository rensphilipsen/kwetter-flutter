import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:kwetter_app/api/base.dart';
import 'package:kwetter_app/models/user.dart';

class UserService extends BaseApiService {
  String endpointPrefix = 'users';

  Future<List<User>> getFollowers() async {
    List<User> followers = new List<User>();

    Response response = await super.get(uri: '1/followers/');
    if (response.statusCode == HttpStatus.OK) {
      List<Object> userData = json.decode(response.body);
      for (Object user in userData) {
        followers.add(new User.fromJson(user));
      }
    }

    return followers;
  }

  Future<List<User>> getFollowing() async {
    List<User> following = new List<User>();

    Response response = await super.get(uri: '1/following/');
    if (response.statusCode == HttpStatus.OK) {
      List<Object> userData = json.decode(response.body);
      for (Object user in userData) {
        following.add(new User.fromJson(user));
      }
    }

    return following;
  }
}
