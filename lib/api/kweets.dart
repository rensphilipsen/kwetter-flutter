import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:kwetter_app/api/base.dart';
import 'package:kwetter_app/models/kweet.dart';

class KweetService extends BaseApiService {
  String endpointPrefix = 'kweets';

  Future<List<Kweet>> getTimeline() async {
    List<Kweet> kweets;

    Response response = await super.get(uri: '1/timeline/');
    if (response.statusCode == HttpStatus.OK) {
      print(response.body);
      var kweets = json.decode(response.body);
      print(kweets);
      print(kweets);
    }

    return kweets;
  }
}
