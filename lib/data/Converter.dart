import 'dart:convert';

import 'package:app/domain/aggregates/Challenge.dart';
import 'package:app/domain/aggregates/Comment.dart';
import 'package:app/domain/aggregates/ENEMGame.dart';
import 'package:app/domain/aggregates/ENEMQuestion.dart';
import 'package:app/domain/aggregates/ENEMVideo.dart';
import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/Ranking.dart';
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
    data["telephoneNumber"],
    data["desiredCourse"],
    data["founderFlag"] == null ? false : data["founderFlag"],
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
      fromJsonToListOfTrivias(data["triviaQuestionsUsed"]));
}

List<Trivia> fromJsonToListOfTrivias(content) {
  final l = new List<Trivia>.generate(
      content.length, (i) => fromMapToTrivia(content[i]));
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
      data["image"]["imageData"],
      data["statusCode"],
      data["likes"] == null ? 0 : data["likes"],
      fromMapToListOfImages(data["multipleImages"]),
      fromMapToListOfComments(data["comments"]));
}

List<String> fromMapToListOfImages(content) {
  if (content != null) {
    List<String> result = List<String>();

    for (var i = 0; i < content.length; i++) {
      result.add(content[i]["imageData"]);
    }

    return result;
  }

  return [];
}

List<Comment> fromMapToListOfComments(content) {
  if (content != null) {
    List<Comment> result = List<Comment>();

    for (var i = 0; i < content.length; i++) {
      result.add(new Comment(content[i]["id"], content[i]["userId"],
          content[i]["author"], content[i]["comment"]));
    }

    return result;
  }

  return [];
}

Ranking fromJsonToRanking(content) {
  final data = (json.decode(content) as List).cast<Map<String, dynamic>>();
  final result = data.map((d) => fromMapToGame(d)).toList();
  return Ranking(result);
}

ENEMGame fromMapToGame(data) {
  return ENEMGame(
    data["id"],
    data["userId"],
    List<ENEMAnswer>.generate(
        data["answers"].length, (i) => fromMapToAnswer(data["answers"][i])),
    data["timeSpent"],
  );
}

ENEMAnswer fromMapToAnswer(data) {
  return ENEMAnswer(
    data["questionId"],
    data["correctAnswer"],
    data["selectedAnswer"],
  );
}

List<ENEMQuestion> fromJsonToListOfQuestions(String content) {
  final data = (json.decode(content) as List).cast<Map<String, dynamic>>();
  final result = List<ENEMQuestion>.generate(
      data.length, (i) => fromMapToENEMQuestion(data[i]));
  return result;
}

fromMapToENEMQuestion(Map<String, dynamic> data) {
  return ENEMQuestion(
    data["id"],
    data["answer"],
    data["view"],
    data["width"],
    data["height"],
  );
}

List<ENEMVideo> fromJsonToListOfENEMVideos(String content) {
  final data = (json.decode(content) as List).cast<Map<String, dynamic>>();
  final result =
      List<ENEMVideo>.generate(data.length, (i) => fromMapToENEMVideo(data[i]));
  return result;
}

fromMapToENEMVideo(Map<String, dynamic> data) {
  return ENEMVideo(
    data["title"],
    data["channel"]["title"],
    data["thumbnails"]["default"],
    data["videoId"],
  );
}
