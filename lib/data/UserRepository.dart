import 'package:app/data/util/ExceptionHandler.dart';
import 'package:app/domain/aggregates/Challenge.dart';
import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/User.dart';
import 'package:app/domain/boundary/UserBoundary.dart';
import 'package:http/http.dart' as http;
import 'Converter.dart';
import 'constants.dart';

class UserRepository implements IUserRepository {
  final String _apiKey;
  final String _url;

  UserRepository(this._url, this._apiKey);

  @override
  Future<User> id(String accessToken, String id) async {
    final response = await http.get(_url + "/" + id, headers: {
      apiKeyHeader: _apiKey,
      contentTypeHeader: contentTypeValueForJson,
      authHeader: accessToken
    });
    if (response.statusCode == 200) {
      return fromJsonToUser(response.body);
    }
    throw handleNetworkException(response.statusCode);
  }

  @override
  Future<List<Challenge>> challenges(String accessToken, String userId) async {
    final response =
        await http.get(_url + "/" + userId + "/challenge", headers: {
      apiKeyHeader: _apiKey,
      contentTypeHeader: contentTypeValueForJson,
      authHeader: accessToken
    });
    if (response.statusCode == 200) {
      return fromJsonToListOfChallenges(response.body);
    }
    throw handleNetworkException(response.statusCode);
  }

  @override
  Future<List<Post>> posts(String accessToken, String userId) async {
    final response =
        await http.get(_url + "/" + userId + "/posts", headers: {
      apiKeyHeader: _apiKey,
      contentTypeHeader: contentTypeValueForJson,
      authHeader: accessToken
    });
    if (response.statusCode == 200) {
      return fromJsonToListOfPosts(response.body);
    }
    throw handleNetworkException(response.statusCode);
  }

  @override
  Future<void> unfollow(String accessToken, String producerId) async {
    final response =
    await http.delete(_url + "/" + producerId + "/followers", headers: {
      apiKeyHeader: _apiKey,
      contentTypeHeader: contentTypeValueForJson,
      authHeader: accessToken
    });
    if (response.statusCode == 200) {
      return;
    }
    throw handleNetworkException(response.statusCode);
  }

  @override
  Future<void> follow(String accessToken, String producerId) async {
    final response =
    await http.put(_url + "/" + producerId + "/followers", headers: {
      apiKeyHeader: _apiKey,
      contentTypeHeader: contentTypeValueForJson,
      authHeader: accessToken
    });
    if (response.statusCode == 200) {
      return;
    }
    throw handleNetworkException(response.statusCode);
  }

  @override
  Future<List<User>> search(
      String accessToken, String query, int amount) async {
    final response = await http.get(
        _url + "?name=" + query + "&amount=" + amount.toString(),
        headers: {
          apiKeyHeader: _apiKey,
           authHeader: accessToken
        });
    if (response.statusCode == 200) {
      return fromJsonToListOfUsers(response.body);
    }
    throw handleNetworkException(response.statusCode);
  }

  @override
  Future<void> setDescription(
      String accessToken, String id, String description) async {
    final response =
    await http.put(_url + "/" + id + "/description", headers: {
      apiKeyHeader: _apiKey,
      contentTypeHeader: contentTypeValueForJson,
      authHeader: accessToken
    }, body: {
      "description": description
    });
    if (response.statusCode == 200) {
      return;
    }
    throw handleNetworkException(response.statusCode);
  }
}
