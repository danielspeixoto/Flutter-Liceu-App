import 'package:app/domain/aggregates/Trivia.dart';

//Navigates
class NavigateCreateTriviaAction{}

//Fetches

//Setters
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

//Submits
class SubmitTriviaAction {
  final String question;
  final String correctAnswer;
  final String wrongAnswer;
  final TriviaDomain domain;

  SubmitTriviaAction(this.question, this.correctAnswer, this.wrongAnswer, this.domain);
}

class SubmitTriviaSuccessAction {}

class SubmitTriviaErrorAction {}