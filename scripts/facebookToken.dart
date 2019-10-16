import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';

void main() async {
  final client = new Client();
  final response = await client.get(
      "https://graph.facebook.com/v4.0/2243716772402843/accounts/test-users?access_token=${Platform.environment["FACEBOOK_APP_TOKEN"]}");
  if (response.statusCode != 200) {
    print("facebook api request failed");
    exit(1);
  }
  final data = json.decode(response.body)["data"] as List;
  data.forEach((user) {
    if (user["id"] == "101485524610686") {
      print(user["access_token"]);
      exit(0);
    }
  });
}
