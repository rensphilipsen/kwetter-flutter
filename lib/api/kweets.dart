import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:kwetter_app/api/base.dart';
import 'package:kwetter_app/models/kweet.dart';

class KweetService extends BaseApiService {
  String endpointPrefix = 'kweets';

  Future<List<Kweet>> getTimeline() async {
    List<Kweet> kweets = new List<Kweet>();

    Response response = await super.get(uri: '1/timeline/');
    if (response.statusCode == HttpStatus.OK) {
      List<Object> kweetData = json.decode(response.body);
      for (Object kweet in kweetData) {
        kweets.add(new Kweet.fromJson(kweet));
      }
    }

    return kweets;
  }

  Future<List<Kweet>> getKweets() async {
    List<Kweet> kweets = new List<Kweet>();

    Response response = await super.get(uri: '1/kweets/');
    if (response.statusCode == HttpStatus.OK) {
      List<Object> kweetData = json.decode(response.body);
      for (Object kweet in kweetData) {
        kweets.add(new Kweet.fromJson(kweet));
      }
    }

    return kweets;
  }
}
