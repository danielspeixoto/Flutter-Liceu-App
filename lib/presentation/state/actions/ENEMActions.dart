import 'package:app/domain/aggregates/ENEMQuestion.dart';
import 'package:app/presentation/state/aggregates/ENEMQuestionData.dart';
import 'package:app/presentation/state/aggregates/RankingData.dart';
import '../../constants.dart';

//Navigates
class NavigateTrainingQuestionsAction {}

class NavigateTournamentAction {}

class NavigateTrainingQuestionsFilterAction {
  final QuestionDomain domain;

  NavigateTrainingQuestionsFilterAction(this.domain);
}

class NavigateTournamentReviewAction {
  final int score;
  final int timeSpent;

  NavigateTournamentReviewAction(this.score, this.timeSpent);
}

//Fetches
class FetchRankingAction {
  FetchRankingAction();
}

class FetchRankingErrorAction {
  final String error;

  FetchRankingErrorAction({this.error = DEFAULT_ERROR_MESSAGE});
}

class FetchRankingSuccessAction {
  final RankingData ranking;

  FetchRankingSuccessAction(this.ranking);
}

class FetchTrainingQuestionsSuccessAction {
  final List<ENEMQuestionData> questions;

  FetchTrainingQuestionsSuccessAction(this.questions);
}

class FetchTournamentQuestionsSuccessAction {
  final List<ENEMQuestionData> questions;

  FetchTournamentQuestionsSuccessAction(this.questions);
}

//Setters


//Submits
class SubmitTournamentGameAction {}

//Interactions
class AnswerTrainingQuestionAction {
  final String questionId;
  final int answer;

  AnswerTrainingQuestionAction(this.questionId, this.answer);
}

class AnswerTournamentQuestionAction {
  final String questionId;
  final int answer;

  AnswerTournamentQuestionAction(this.questionId, this.answer);
}