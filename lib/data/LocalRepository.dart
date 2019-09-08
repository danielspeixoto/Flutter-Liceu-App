import 'package:app/domain/aggregates/ItemNotFoundException.dart';
import 'package:app/domain/aggregates/NotLoggedInException.dart';
import 'package:app/domain/boundary/LocalBoundary.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:corsac_jwt/corsac_jwt.dart';

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
    id = new JWT.parse(credentials).toString();
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
}