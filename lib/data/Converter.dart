import 'dart:convert';

import 'package:app/domain/aggregates/Challenge.dart';
import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/User.dart';

User fromJsonToUser(String content) {
  final data = json.decode(content);
  return fromMapToUser(data);
}

List<User> fromJsonToListOfUsers(String content) {
  final data = (json.decode(content) as List).cast<Map<String, dynamic>>();
  final result = data.map((d) => fromMapToUser(d)).toList();
  return result;
}

User fromMapToUser(data) {
  return User(
    data["id"],
    data["name"],
    data["picture"]["url"],
    data["description"],
    data["instagramProfile"],
  );
}

Challenge fromJsonToChallenge(String content) {
  final data = json.decode(content);
  return fromMapToChallenge(data);
}

List<Challenge> fromJsonToListOfChallenges(String content) {
  final data = (json.decode(content) as List).cast<Map<String, dynamic>>();
  final result = data.map((d) => fromMapToChallenge(d)).toList();
  return result;
}

Challenge fromMapToChallenge(data) {
  return Challenge(
    data["id"],
    data["challenger"],
    data["challenged"],
    data["scoreChallenged"],
    data["scoreChallenger"],
    fromJsonToListOfTrivias(data["triviaQuestionsUsed"])
  );
}

List<Trivia> fromJsonToListOfTrivias(content) {
  final l = new List<Trivia>.generate(content.length, (i) => fromMapToTrivia(content[i]));
  return l;

}

Trivia fromMapToTrivia(data) {
  return Trivia(
    data["userId"],
    data["question"],
    data["correctAnswer"],
    data["wrongAnswer"],
  );
}

Post fromJsonToPost(String content) {
  final data = json.decode(content);
  return fromMapToPost(data);
}

List<Post> fromJsonToListOfPosts(String content) {
  final data = (json.decode(content) as List).cast<Map<String, dynamic>>();
  final result = data.map((d) => fromMapToPost(d)).toList();
  return result;
}

Post fromMapToPost(data) {
  return Post(
    data["id"],
    data["userId"],
    data["type"],
    data["description"],
//    TODO: Convert string representation do DateTime
//    data["submissionDate"]
  );
}
