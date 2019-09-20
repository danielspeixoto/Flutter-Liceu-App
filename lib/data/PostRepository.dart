import 'dart:convert';

import 'package:app/data/util/ExceptionHandler.dart';
import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/boundary/PostBoundary.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

class PostRepository implements IPostRepository {
  final String _apiKey;
  final String _url;

  PostRepository(this._url, this._apiKey);

  @override
  Future<void> create(String accessToken, PostType type, String text) async {
    final response = await http.post(
      _url + "/",
      headers: {
        apiKeyHeader: _apiKey,
        contentTypeHeader: contentTypeValueForJson,
        authHeader: accessToken
      },
      body: json.encode(
        {"type": _postTypeToString(type), "description": text},
      ),
    );
    if (response.statusCode == 200) {
      return;
    }
    throw handleNetworkException(response.statusCode);
  }

  @override
  Future<void> delete(String accessToken, String postId) async {
    final response = await http.delete(
      _url + "/" + postId,
      headers: {
        apiKeyHeader: _apiKey,
        contentTypeHeader: contentTypeValueForJson,
        authHeader: accessToken
      },
    );
    if (response.statusCode == 200) {
      return;
    }
    throw handleNetworkException(response.statusCode);
  }

  String _postTypeToString(PostType postType) {
    switch (postType) {
      case PostType.TEXT:
        return "text";
      default:
        return "";
    }
  }

}
