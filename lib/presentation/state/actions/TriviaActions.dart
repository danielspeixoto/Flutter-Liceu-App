import 'package:app/domain/aggregates/Trivia.dart';

class CreateTriviaAction {
  final String question;
  final String correctAnswer;
  final String wrongAnswer;
  final TriviaDomain domain;

  CreateTriviaAction(this.question, this.correctAnswer, this.wrongAnswer, this.domain);
}

class SetQuestionFieldAction {
  final String question;

  SetQuestionFieldAction(this.question);
}

class SetCorrectAnswerFieldAction {
  final String correctAnswer;

  SetCorrectAnswerFieldAction(this.correctAnswer);
}

class SetWrongAnswerFieldAction {
  final String wrongAnswer;

  SetWrongAnswerFieldAction(this.wrongAnswer);
}

class SetDomainFieldAction {
  final TriviaDomain domain;

  SetDomainFieldAction(this.domain);
}

class TriviaCreatedAction {
  
}