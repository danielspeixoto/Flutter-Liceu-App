import 'package:app/data/util/ExceptionHandler.dart';
import 'package:app/domain/aggregates/Ranking.dart';
import 'package:app/domain/boundary/RankingBoundary.dart';
import 'package:http/http.dart';

import 'Converter.dart';
import 'constants.dart';

class RankingRepository implements IRankingRepository {
  final String _apiKey;
  final String _url;

  RankingRepository(this._url, this._apiKey, this._client);
  final Client _client;

  @override
  Future<Ranking> get(
      String accessToken, int month, int year, int amount) async {
    try {
      final response = await this
          ._client
          .get("$_url?amount=$amount&year=$year&month=$month", headers: {
        apiKeyHeader: _apiKey,
        contentTypeHeader: contentTypeValueForJson,
        authHeader: accessToken
      });
      if (response.statusCode == 200) {
        return fromJsonToRanking(response.body);
      }
      throw handleNetworkException(response.statusCode, runtimeType.toString());
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
