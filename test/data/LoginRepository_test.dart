import 'package:app/data/LoginRepository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  var login = LoginRepository(
      "https://liceu-staging.herokuapp.com/v2/login",
      "2VsYHwfQKtjiAdLs8Z2fTLwuLpofSXWy",
      new http.Client()
  );
  test('Login Repository is able to perform a login request', () async {
    var accessCode = await login.auth("EAAf4pgUyFpsBAAUZAx48YoPZAiosI2mh5BPaZCwBJHSOj52WhgdIUZBZAPIqzeC4uksvWJlOGUOC31JggsmWblruH6T5tTHpRsjMkOYSMRuP5AX7nxtT0JIcVtF9gEFELOcp0LPvXsYN2sV0HETyZACZCXZCFDnwaYxbXTZAnRPoAuOmB2VLNOurn0d87UCLb2tmQTPXQAFC2fVZAo0a6VQ6PP", "facebook");
    print(accessCode);
  });
}
