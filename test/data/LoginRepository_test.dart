import 'package:app/data/LoginRepository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  var login = LoginRepository(
      "https://liceu-staging.herokuapp.com/v2/login",
      "2VsYHwfQKtjiAdLs8Z2fTLwuLpofSXWy"
  );
  test('Login Repository is able to perform a login request', () async {
    var accessCode = await login.auth("EAAf4pgUyFpsBAAkI9y32sCgJsbeAOLCQSqDxloHI7O6NIv8fl7QXe80B0ESWlsz0Jty7XBwcHHcdTURc7lOPujjpXUVSpxh4ZAv4wiE7JVZB42PsFC7aTbbVuWCkaLNaiFKvWU98k4WeqP3rZBZB4EBYDJfZCgsgDW0hADNDXL3ZBL6WTxduGMJyisATRAetoQMakMgHHFWAZDZD", "facebook");
    print(accessCode);
  });
}
