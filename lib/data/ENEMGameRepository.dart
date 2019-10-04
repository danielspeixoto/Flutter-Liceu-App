import 'dart:convert';

import 'package:app/data/util/ExceptionHandler.dart';
import 'package:app/domain/aggregates/ENEMGame.dart';
import 'package:app/domain/boundary/ENEMBoundary.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

class ENEMGameRepository implements IENEMGameRepository {
  final String _apiKey;
  final String _url;

  ENEMGameRepository(this._url, this._apiKey);

  @override
  Future<void> submitGame(
      String accessToken, List<ENEMAnswer> answers, int timeSpent) async {
    final response = await http.post(
      _url,
      headers: {
        apiKeyHeader: _apiKey,
        contentTypeHeader: contentTypeValueForJson,
        authHeader: accessToken
      },
      body: json.encode(
        {
          "answers": answers.map((answer) {
            return {
              "questionId": answer.questionId,
              "correctAnswer": answer.correctAnswer,
              "selectedAnswer": answer.selectedAnswer,
            };
          }).toList(),
          "timeSpent": timeSpent,
        },
      ),
    );
    if (response.statusCode == 200) {
      return;
    }
    throw handleNetworkException(response.statusCode, runtimeType.toString());
  }
}
