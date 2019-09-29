import 'package:app/domain/aggregates/ENEMQuestion.dart';
import 'package:app/presentation/state/aggregates/ENEMQuestionData.dart';
import 'package:app/presentation/state/aggregates/RankingData.dart';
import '../../constants.dart';

//Navigates
class NavigateTrainingAction {}

class NavigateTournamentAction {}

class NavigateFilterTrainingQuestions {
  final QuestionDomain domain;

  NavigateFilterTrainingQuestions(this.domain);
}

class NavigateReviewTournamentAction {
  final int score;
  final int timeSpent;

  NavigateReviewTournamentAction(this.score, this.timeSpent);
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
class SetAnswerTrainingQuestionAction {
  final String questionId;
  final int answer;

  SetAnswerTrainingQuestionAction(this.questionId, this.answer);
}

class SetAnswerTournamentQuestionAction {
  final String questionId;
  final int answer;

  SetAnswerTournamentQuestionAction(this.questionId, this.answer);
}

//Submits
class SubmitTournamentGameAction {}


