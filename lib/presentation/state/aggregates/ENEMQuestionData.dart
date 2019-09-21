import 'package:app/domain/aggregates/ENEMVideo.dart';

class ENEMQuestionData {
  final String id;
  final String imageURL;
  final int answer;
  final List<ENEMVideo> videos;
  final int width;
  final int height;

  ENEMQuestionData(this.id, this.imageURL, this.answer, this.videos, this.width, this.height);
}