import 'dart:convert';

import 'package:app/data/util/ExceptionHandler.dart';
import 'package:app/domain/aggregates/Challenge.dart';
import 'package:app/domain/boundary/ChallengeBoundary.dart';
import 'package:http/http.dart' as http;

import 'Converter.dart';
import 'constants.dart';

class ChallengeRepository implements IChallengeRepository {
  final String _apiKey;
  final String _url;

  ChallengeRepository(this._url, this._apiKey);

  @override
  Future<Challenge> get(String accessToken) async {
    final response = await http.get(_url, headers: {
      apiKeyHeader: _apiKey,
      contentTypeHeader: contentTypeValueForJson,
      authHeader: accessToken
    });
    if (response.statusCode == 200) {
      return fromJsonToChallenge(response.body);
    }
    throw handleNetworkException(response.statusCode);
  }

  @override
  Future<Challenge> id(String accessToken, String challengeId) async {
    final response = await http.get("$_url/$challengeId", headers: {
      apiKeyHeader: _apiKey,
      contentTypeHeader: contentTypeValueForJson,
      authHeader: accessToken
    });
    if (response.statusCode == 200) {
      return fromJsonToChallenge(response.body);
    }
    throw handleNetworkException(response.statusCode);
  }

  @override
  Future<void> submitResult(
      String accessToken, String challengeId, List<String> answers) async {
    final response = await http.put(_url + "/" + challengeId,
        headers: {
          apiKeyHeader: _apiKey,
          contentTypeHeader: contentTypeValueForJson,
          authHeader: accessToken
        },
        body: json.encode({"answers": answers}));
    if (response.statusCode != 200) {
      throw handleNetworkException(response.statusCode);
    }
  }

  @override
  Future<Challenge> challengeSomeone(
      String accessToken, String challengedId) async {
    final response = await http.post(
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
    throw handleNetworkException(response.statusCode);
  }
}
