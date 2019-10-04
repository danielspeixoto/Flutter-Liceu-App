import 'package:app/domain/boundary/ReportBoundary.dart';
import 'dart:convert';
import 'package:app/data/util/ExceptionHandler.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';

class ReportRepository implements IReportRepository {
  final String _apiKey;
  final String _url;

  ReportRepository(this._apiKey, this._url);

  Future<void> submit(String accessToken, String message, List<String> tags,
      Map<String, dynamic> params) async {
    final response = await http.post(
      _url,
      headers: {
        apiKeyHeader: _apiKey,
        contentTypeHeader: contentTypeValueForJson,
        authHeader: accessToken
      },
      body: json.encode(
        {"message": message, "tags": tags, "params": params},
      ),
    );
    if (response.statusCode == 200) {
      return;
    }
    throw handleNetworkException(response.statusCode, runtimeType.toString());
  }
}
