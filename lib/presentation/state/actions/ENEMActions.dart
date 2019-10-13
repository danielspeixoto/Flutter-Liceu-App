import 'package:app/domain/aggregates/ENEMGame.dart';
import 'package:app/domain/aggregates/ENEMQuestion.dart';
import 'package:app/presentation/state/actions/ItemActions.dart';
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
class SetTrainingReportFieldAction {
  final String text;

  SetTrainingReportFieldAction(this.text);
}

class SetTournamentReportFieldAction {
  final String text;

  SetTournamentReportFieldAction(this.text);
}

//Submits
class SubmitTournamentGameAction  extends ItemAction {
  final List<ENEMAnswer> answers;
  final int timeSpent;

  SubmitTournamentGameAction(this.answers, this.timeSpent);

    @override
  Map<String, dynamic> itemToJson() {
    return <String, dynamic>{
      'answers': answers,
      'timeSpent': timeSpent
    };
  }
}

//Interactions
class EndTournamentGameAction {}

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

class StartTournamentAction {}

class StartTrainingAction {}
