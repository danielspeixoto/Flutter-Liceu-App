import 'package:app/domain/aggregates/User.dart';

class TriviaData {
  final User author;
  final String question;
  final String correctAnswer;
  final String wrongAnswer;

  TriviaData(
    this.author,
    this.question,
    this.correctAnswer,
    this.wrongAnswer,
  );
}
