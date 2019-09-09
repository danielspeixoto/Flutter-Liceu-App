import 'dart:io';
import 'dart:convert';
import 'package:app/domain/exceptions/RequestException.dart';
import 'package:app/domain/aggregates/User.dart';
import 'package:app/domain/boundary/UserBoundary.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

class UserRepository implements IUserRepository {
  final String _apiKey;
  final String _url;
  final http.Client _client;

  UserRepository(this._url, this._apiKey, this._client);

  @override
  Future<User> id(String accessToken, String id) async {
    final response = await _client.get(_url + "/" + id, headers: {
      apiKeyHeader: _apiKey,
      contentTypeHeader: contentTypeValueForJson,
      authHeader: accessToken
    });
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return User(
          data["id"],
          data["name"],
          data["picture"]["url"],
          data["description"]);
    }
    throw new RequestException();
  }
}
