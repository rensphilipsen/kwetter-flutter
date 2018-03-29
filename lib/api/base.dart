import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

abstract class BaseApiService {
  /// Base URL to the API
  String baseUrl = 'http://localhost:8080/Kwetter-1.0-SNAPSHOT/api/';

  String endpointPrefix;

  /// Do a GET request
  ///
  /// Returns a response
  Future<http.Response> get({String uri = ''}) async {
    print(_getUrl(uri));
    final response = await http.get(_getUrl(uri), headers: await _getHeaders());
    return response;
  }

  /// Do a POST request
  ///
  /// Returns a response
  Future<http.Response> post({String uri = '', Map<String, dynamic> body}) async {
    final response = await http.post(_getUrl(uri), body: body);
    return response;
  }

  /// Do a UPDATE request
  ///
  /// Returns a response
  Future<http.Response> update({String uri = '', Map<String, dynamic> body}) async {
    final response =
        await http.put(_getUrl(uri), body: body, headers: await _getHeaders());
    return response;
  }

  /// Do a DELETE request
  ///
  /// Returns a response
  Future<http.Response> delete(String id) async {
    final response =
        await http.delete(_getUrl(id), headers: await _getHeaders());
    return response;
  }

  /// Gets the token from local storage
  ///
  /// Returns token string async
  Future<String> getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final token = preferences.getString('token');
    return token != null ? token : '';
  }

  /// Sets the token to local storage
  ///
  /// Returns token string async
  Future<String> setToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString('token', token);
  }

  /// Get the headers formatted to JWT
  ///
  /// Returns a headers object async
  Future<Object> _getHeaders() async {
    final token = await getToken();
    return {HttpHeaders.AUTHORIZATION: 'Bearer ' + token};
  }

  /// Return string with suffix
  String _getUrl(String uri) {
    return baseUrl + endpointPrefix + '/' + uri;
  }
}
