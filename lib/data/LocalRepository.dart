import 'package:app/domain/exceptions/ItemNotFoundException.dart';
import 'package:app/domain/exceptions/NotLoggedInException.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:corsac_jwt/corsac_jwt.dart';
import 'dart:convert';

class LocalRepository implements ILocalRepository {

  final FlutterSecureStorage _storage = new FlutterSecureStorage();
  static const String TOKEN_KEY = "token";
  String credentials = "";
  String id = "";

  LocalRepository();

  @override
  Future<void> saveCredentials(String credentials) {
    _storage.write(key: TOKEN_KEY, value: credentials);
  }

  @override
  Future<bool> isLoggedIn() async {
    if(credentials == "") {
      try {
        await getCredentials();
      } catch(e) {
        print(e);
        return false;
      }
    }
    return true;
  }

  @override
  Future<String> getId() async {
    if(id != "") {
      return id;
    }
    if(credentials == "") {
      throw NotLoggedInException();
    }
    final payload = parseJwt(credentials);
    id = payload["sub"];
    return id;
  }

  @override
  Future<String> getCredentials() async {
    if(credentials != "") {
      return credentials;
    }
    var cred = await _storage.read(key: TOKEN_KEY);
    if(cred == null) {
      throw ItemNotFoundException();
    }
    credentials = cred;
    return credentials;
  }

  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}