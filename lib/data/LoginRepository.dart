import 'dart:convert';

import 'package:app/domain/boundary/LoginBoundary.dart';
import 'package:app/domain/exceptions/RequestException.dart';
import 'package:http/http.dart' as http;

class LoginRepository implements ILoginRepository {
  final String _apiKey;
  final String _url;

  LoginRepository(this._url, this._apiKey);

  final String authHeader = "authorization";

  @override
  Future<String> auth(String accessCode, String method) async {
    var response = await http.post(_url,
        headers: {"API_KEY": _apiKey, "Content-Type": "application/json"},
        body: json.encode({
          "accessToken": accessCode,
          "method": method,
        }));

    if (response.statusCode == 200 &&
        response.headers.containsKey(authHeader)) {
      var userToken = response.headers[authHeader];
      return userToken;
    }
    throw new RequestException();
  }
}
