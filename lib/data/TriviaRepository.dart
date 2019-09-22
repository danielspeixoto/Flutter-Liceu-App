import 'dart:convert';

import 'package:app/data/util/ExceptionHandler.dart';
import 'package:app/domain/boundary/TriviaBoundary.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

class TriviaRepository implements ITriviaRepository {
  final String _apiKey;
  final String _url;

  TriviaRepository(this._url, this._apiKey);

  @override
  Future<void> create(String accessToken, String question, String correctAnswer,
      String wrongAnswer, List<String> tags) async {
    final response = await http.post(_url + "/",
        headers: {
          apiKeyHeader: _apiKey,
          contentTypeHeader: contentTypeValueForJson,
          authHeader: accessToken
        },
        body: json.encode({
          "question": question,
          "correctAnswer": correctAnswer,
          "wrongAnswer": wrongAnswer,
          "tags": tags,
        }));
    if (response.statusCode == 200) {
      return;
    }
    throw handleNetworkException(response.statusCode);
  }
}
