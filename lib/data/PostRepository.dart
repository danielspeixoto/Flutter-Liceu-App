import 'dart:convert';

import 'package:app/data/Converter.dart';
import 'package:app/data/util/ExceptionHandler.dart';
import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/boundary/PostBoundary.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

class PostRepository implements IPostRepository {
  final String _apiKey;
  final String _url;

  PostRepository(this._url, this._apiKey);

  Future<Post> id(String accessToken, String postId) async {

    final response = await http.get("$_url/$postId", headers: {
      apiKeyHeader: _apiKey,
      contentTypeHeader: contentTypeValueForJson,
      authHeader: accessToken
    });
    if (response.statusCode == 200) {
      return fromJsonToPost(response.body);
    }
    throw handleNetworkException(response.statusCode, runtimeType.toString());
  }

  @override
  Future<void> createTextPost(String accessToken, String text) async {
    final response = await http.post(
      _url + "/",
      headers: {
        apiKeyHeader: _apiKey,
        contentTypeHeader: contentTypeValueForJson,
        authHeader: accessToken
      },
      body: json.encode(
        {"type": "text", "description": text},
      ),
    );
    if (response.statusCode == 200) {
      return;
    }
    throw handleNetworkException(response.statusCode, runtimeType.toString());
  }

  @override
  Future<void> createImagePost(String accessToken, String imageData,
      String imageTitle, String text) async {
    final response = await http.post(
      _url + "/",
      headers: {
        apiKeyHeader: _apiKey,
        contentTypeHeader: contentTypeValueForJson,
        authHeader: accessToken
      },
      body: json.encode(
        {
          "type": "image",
          "description": text,
          "imageTitle": imageTitle,
          "imageData": imageData,
        },
      ),
    );
    if (response.statusCode == 200) {
      return;
    }
    throw handleNetworkException(response.statusCode, runtimeType.toString());
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
    throw handleNetworkException(response.statusCode, runtimeType.toString());
  }

  String _postTypeToString(PostType postType) {
    switch (postType) {
      case PostType.TEXT:
        return "text";
      case PostType.IMAGE:
        return "image";
      default:
        return "";
    }
  }
}
