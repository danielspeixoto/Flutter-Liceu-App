import 'package:app/domain/aggregates/Trivia.dart';

class CreateTriviaAction {
  final String question;
  final String correctAnswer;
  final String wrongAnswer;
  final TriviaDomain domain;

  CreateTriviaAction(this.question, this.correctAnswer, this.wrongAnswer, this.domain);
}

class SetCreateTriviaQuestionFieldAction {
  final String question;

  SetCreateTriviaQuestionFieldAction(this.question);
}

class SetCreateTriviaCorrectAnswerFieldAction {
  final String correctAnswer;

  SetCreateTriviaCorrectAnswerFieldAction(this.correctAnswer);
}

class SetCreateTriviaWrongAnswerFieldAction {
  final String wrongAnswer;

  SetCreateTriviaWrongAnswerFieldAction(this.wrongAnswer);
}

class SetCreateTriviaDomainFieldAction {
  final TriviaDomain domain;

  SetCreateTriviaDomainFieldAction(this.domain);
}

class TriviaCreatedAction {}