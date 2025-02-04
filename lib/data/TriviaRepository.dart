import 'dart:convert';

import 'package:app/data/util/ExceptionHandler.dart';
import 'package:app/domain/aggregates/Trivia.dart';
import 'package:app/domain/boundary/TriviaBoundary.dart';
import 'package:http/http.dart';

import 'constants.dart';

class TriviaRepository implements ITriviaRepository {
  final String _apiKey;
  final String _url;

  TriviaRepository(this._url, this._apiKey, this._client);
  final Client _client;

  @override
  Future<void> create(String accessToken, String question, String correctAnswer,
      String wrongAnswer, List<TriviaDomain> tags) async {
    final response = await this._client.post(_url + "/",
        headers: {
          apiKeyHeader: _apiKey,
          contentTypeHeader: contentTypeValueForJson,
          authHeader: accessToken
        },
        body: json.encode({
          "question": question,
          "correctAnswer": correctAnswer,
          "wrongAnswer": wrongAnswer,
          "tags": tags.map((tag) => domainToString(tag)).toList(),
        }));
    if (response.statusCode == 200) {
      return;
    }
    throw handleNetworkException(response.statusCode, runtimeType.toString());
  }

  String domainToString(TriviaDomain domain) {
    switch (domain) {
      case TriviaDomain.LANGUAGES:
        return "linguagens";
      case TriviaDomain.MATHEMATICS:
        return "matemática";
      case TriviaDomain.HUMAN_SCIENCES:
        return "humanas";
      case TriviaDomain.NATURAL_SCIENCES:
        return "naturais";
      default:
        throw Exception("trivia domain does not match options available");
    }
  }
}
