import 'package:app/data/RankingRepository.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var ranking = RankingRepository(
      "https://liceu-staging.herokuapp.com/v2/ranking",
      "2VsYHwfQKtjiAdLs8Z2fTLwuLpofSXWy");
  test('Ranking Repository is able to perform a ranking request', () async {
//    var accessCode = await ranking.get(
//      "EAAf4pgUyFpsBAAkI9y32sCgJsbeAOLCQSqDxloHI7O6NIv8fl7QXe80B0ESWlsz0Jty7XBwcHHcdTURc7lOPujjpXUVSpxh4ZAv4wiE7JVZB42PsFC7aTbbVuWCkaLNaiFKvWU98k4WeqP3rZBZB4EBYDJfZCgsgDW0hADNDXL3ZBL6WTxduGMJyisATRAetoQMakMgHHFWAZDZD",
//      "facebook",
//    );
//    print(accessCode);
  });
}
