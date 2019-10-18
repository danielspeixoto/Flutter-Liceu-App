import 'package:app/domain/aggregates/Trivia.dart';
import 'package:app/presentation/state/actions/ItemActions.dart';

//Navigates
class NavigateCreateTriviaAction {}

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
class SubmitTriviaAction extends ItemAction{
  final String question;
  final String correctAnswer;
  final String wrongAnswer;
  final TriviaDomain domain;

  SubmitTriviaAction(
      this.question, this.correctAnswer, this.wrongAnswer, this.domain);

          @override
  Map<String, dynamic> itemToJson() {
    return <String, dynamic>{
      'question': question,
      'correctAnswer': correctAnswer,
      'wrongAnswer': wrongAnswer,
      'domain': domain
    };
  }
}

class SubmitTriviaSuccessAction {}

class SubmitTriviaErrorTagNullAction {
  final String question;
  final String correctAnswer;
  final String wrongAnswer;

  SubmitTriviaErrorTagNullAction(
      this.question, this.correctAnswer, this.wrongAnswer);
}

class SubmitTriviaErrorQuestionSizeMismatchAction {
  final String question;
  final String correctAnswer;
  final String wrongAnswer;

  SubmitTriviaErrorQuestionSizeMismatchAction(
      this.question, this.correctAnswer, this.wrongAnswer);
}

class SubmitTriviaErrorCorrectAnswerSizeMismatchAction {
  final String question;
  final String correctAnswer;
  final String wrongAnswer;

  SubmitTriviaErrorCorrectAnswerSizeMismatchAction(
      this.question, this.correctAnswer, this.wrongAnswer);
}

class SubmitTriviaErrorWrongAnswerSizeMismatchAction {
  final String question;
  final String correctAnswer;
  final String wrongAnswer;

  SubmitTriviaErrorWrongAnswerSizeMismatchAction(
      this.question, this.correctAnswer, this.wrongAnswer);
}

class SubmitTriviaErrorAction {}
