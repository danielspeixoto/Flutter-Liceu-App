import 'package:app/data/util/ExceptionHandler.dart';
import 'package:app/domain/aggregates/ENEMQuestion.dart';
import 'package:app/domain/aggregates/ENEMVideo.dart';
import 'package:app/domain/boundary/ENEMBoundary.dart';
import 'package:http/http.dart' as http;

import 'Converter.dart';
import 'constants.dart';

class ENEMQuestionRepository implements IENEMQuestionRepository {

  final String _url;
  final String _apiKey;

  ENEMQuestionRepository(this._url, this._apiKey);

  @override
  Future<List<ENEMQuestion>> random(String accessToken, int amount, List<QuestionDomain> domains) async {
    var tagsQuery = "";
    domains.forEach((domain) {
      tagsQuery += "&tags=${fromDomainToString(domain)}";
    });
    final response = await http.get("$_url?amount=$amount$tagsQuery", headers: {
      apiKeyHeader: _apiKey,
      contentTypeHeader: contentTypeValueForJson,
      authHeader: accessToken
    });
    if (response.statusCode == 200) {
      return fromJsonToListOfQuestions(response.body);
    }
    throw handleNetworkException(response.statusCode);
  }

  @override
  Future<List<ENEMVideo>> videos(String accessToken, String id) async {
    final response = await http.get("$_url/$id/videos?start=0&amount=5", headers: {
      apiKeyHeader: _apiKey,
      contentTypeHeader: contentTypeValueForJson,
      authHeader: accessToken
    });
    if (response.statusCode == 200) {
      return fromJsonToListOfENEMVideos(response.body);
    }
    throw handleNetworkException(response.statusCode);
  }

}

String fromDomainToString(QuestionDomain domain) {
  switch(domain) {
    case QuestionDomain.LANGUAGES:
      return "linguagens";
    case QuestionDomain.MATHEMATICS:
      return "matemática";
    case QuestionDomain.HUMAN_SCIENCES:
      return "humanas";
    default:
      return "naturais";
  }
}