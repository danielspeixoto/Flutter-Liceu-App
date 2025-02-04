import 'dart:convert';

import 'package:app/data/util/ExceptionHandler.dart';
import 'package:app/domain/aggregates/Challenge.dart';
import 'package:app/domain/boundary/ChallengeBoundary.dart';
import 'package:http/http.dart';

import 'Converter.dart';
import 'constants.dart';

class ChallengeRepository implements IChallengeRepository {
  final String _apiKey;
  final String _url;
  final Client _client;

  ChallengeRepository(this._url, this._apiKey, this._client);
  @override
  Future<Challenge> get(String accessToken) async {
    final response = await this._client.get(_url, headers: {
      apiKeyHeader: _apiKey,
      contentTypeHeader: contentTypeValueForJson,
      authHeader: accessToken
    });
    if (response.statusCode == 200) {
      return fromJsonToChallenge(response.body);
    }
    throw handleNetworkException(response.statusCode, runtimeType.toString());
  }

  @override
  Future<Challenge> id(String accessToken, String challengeId) async {
    final response = await this._client.get("$_url/$challengeId", headers: {
      apiKeyHeader: _apiKey,
      contentTypeHeader: contentTypeValueForJson,
      authHeader: accessToken
    });
    if (response.statusCode == 200) {
      return fromJsonToChallenge(response.body);
    }
    throw handleNetworkException(response.statusCode, runtimeType.toString());
  }

  @override
  Future<void> submitResult(
      String accessToken, String challengeId, List<String> answers) async {
    final response = await this._client.put(_url + "/" + challengeId,
        headers: {
          apiKeyHeader: _apiKey,
          contentTypeHeader: contentTypeValueForJson,
          authHeader: accessToken
        },
        body: json.encode({"answers": answers}));
    if (response.statusCode != 200) {
      throw handleNetworkException(response.statusCode, runtimeType.toString());
    }
  }

  @override
  Future<Challenge> challengeSomeone(
      String accessToken, String challengedId) async {
    final response = await this._client.post(
          _url,
          headers: {
            apiKeyHeader: _apiKey,
            contentTypeHeader: contentTypeValueForJson,
            authHeader: accessToken
          },
          body: json.encode({"challengedId": challengedId}),
        );
    if (response.statusCode == 200) {
      return fromJsonToChallenge(response.body);
    }
    throw handleNetworkException(response.statusCode, runtimeType.toString());
  }
}
