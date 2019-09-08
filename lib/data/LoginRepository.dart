import 'dart:io';
import 'dart:convert';
import 'package:app/domain/aggregates/RequestException.dart';
import 'package:app/domain/boundary/LoginBoundary.dart';
import 'package:http/http.dart' as http;

class LoginRepository implements ILoginRepository {
  final String _apiKey;
  final String _url;
  final http.Client _client;

  LoginRepository(this._url, this._apiKey, this._client);

  final String authHeader = "authorization";

  @override
  Future<String> auth(String accessCode, String method) async {
    var response = await _client.post(_url,
        headers: {"API_KEY": _apiKey, "Content-Type": "application/json"},
        body: json.encode({"accessToken": accessCode}));

    if (response.statusCode == 200 &&
        response.headers.containsKey(authHeader)) {
      var userToken = response.headers[authHeader];
      return userToken;
    }
    throw new RequestException();
  }
}
