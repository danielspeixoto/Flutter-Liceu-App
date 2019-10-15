import 'package:app/data/util/ExceptionHandler.dart';
import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/boundary/PostBoundary.dart';
import 'package:http/http.dart';

import 'Converter.dart';
import 'constants.dart';

class ExploreRepository implements IExploreRepository {
  final String _apiKey;
  final String _url;

  ExploreRepository(this._url, this._apiKey, this._client);
  final Client _client;

  @override
  Future<List<Post>> explore(String accessToken, int amount) async {
    final response = await this._client.get("$_url?amount=$amount", headers: {
      apiKeyHeader: _apiKey,
      contentTypeHeader: contentTypeValueForJson,
      authHeader: accessToken
    });
    if (response.statusCode == 200) {
      return fromJsonToListOfPosts(response.body);
    }
    throw handleNetworkException(response.statusCode, runtimeType.toString());
  }
}
