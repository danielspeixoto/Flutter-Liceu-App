import 'dart:convert';

import 'package:app/data/Converter.dart';
import 'package:app/data/util/ExceptionHandler.dart';
import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/boundary/PostBoundary.dart';
import 'package:http/http.dart';

import 'constants.dart';

class PostRepository implements IPostRepository {
  final String _apiKey;
  final String _url;

  PostRepository(this._url, this._apiKey, this._client);

  final Client _client;

  Future<Post> id(String accessToken, String postId) async {
    final response = await this._client.get("$_url/$postId", headers: {
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
    final response = await this._client.post(
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
  Future<void> createImagePost(
    String accessToken,
    String imageData,
    String imageTitle,
    String text,
  ) async {
    final response = await this._client.post(
          _url + "/",
          headers: {
            apiKeyHeader: _apiKey,
            contentTypeHeader: contentTypeValueForJson,
            authHeader: accessToken
          },
          body: json.encode(
            {
              "type": "multipleImages",
              "description": text,
              "imagesData": [imageData].map((image) {
                return {"imageTitle": imageTitle, "imageData": image};
              }).toList()
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
    final response = await this._client.delete(
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

  Future<void> updateRating(String accessToken, String postId) async {
    final response = await this._client.put(
      _url + "/" + postId + "/rating",
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

  Future<void> updatePostComment(
      String accessToken, String postId, String comment) async {
    final response = await this._client.put(
          _url + "/" + postId + "/comment",
          headers: {
            apiKeyHeader: _apiKey,
            contentTypeHeader: contentTypeValueForJson,
            authHeader: accessToken
          },
          body: json.encode(
            {"comment": comment},
          ),
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
