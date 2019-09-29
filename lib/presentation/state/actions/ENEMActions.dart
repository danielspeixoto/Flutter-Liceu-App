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

class FetchRankingAction {
  FetchRankingAction();
}

class FetchingRankingErrorAction {
  final String error;

  FetchingRankingErrorAction({this.error = DEFAULT_ERROR_MESSAGE});
}

class RankingRetrievedAction {
  final RankingData ranking;

  RankingRetrievedAction(this.ranking);
}

class TrainingQuestionsRetrievedAction {
  final List<ENEMQuestionData> questions;

  TrainingQuestionsRetrievedAction(this.questions);
}
class TournamentQuestionsRetrievedAction {
  final List<ENEMQuestionData> questions;

  TournamentQuestionsRetrievedAction(this.questions);
}

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

class SubmitTournamentGameAction {}

class ReviewTournamentGameAction {
  final int score;
  final int timeSpent;

  ReviewTournamentGameAction(this.score, this.timeSpent);
}

