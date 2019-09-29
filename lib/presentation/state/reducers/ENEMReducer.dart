import 'package:app/domain/aggregates/ENEMQuestion.dart';
import 'package:app/presentation/state/actions/ENEMActions.dart';
import 'package:app/presentation/state/aggregates/ENEMQuestionData.dart';
import 'package:app/presentation/state/aggregates/RankingData.dart';
import 'package:redux/redux.dart';

import '../../constants.dart';
import 'Data.dart';

class ENEMState {
  final Data<RankingData> ranking;
  final Data<List<ENEMQuestionData>> trainingQuestions;
  final Data<List<ENEMQuestionData>> tournamentQuestions;
  final DateTime tournamentStartTime;
  final QuestionDomain domain;
  final int score;
  final int timeSpent;

  ENEMState(
      this.ranking,
      this.trainingQuestions,
      this.domain,
      this.tournamentQuestions,
      this.tournamentStartTime,
      this.score,
      this.timeSpent);

  factory ENEMState.initial() => ENEMState(
        Data(),
        Data(),
        null,
        Data(),
        null,
        null,
        null,
      );

  ENEMState copyWith({
    Data<RankingData> ranking,
    Data<List<ENEMQuestionData>> trainingQuestions,
    QuestionDomain domain,
    Data<List<ENEMQuestionData>> tournamentQuestions,
    DateTime tournamentStartTime,
    int score,
    int timeSpent,
  }) {
    final state = ENEMState(
      ranking ?? this.ranking,
      trainingQuestions ?? this.trainingQuestions,
      domain ?? this.domain,
      tournamentQuestions ?? this.tournamentQuestions,
      tournamentStartTime ?? this.tournamentStartTime,
      score ?? this.score,
      timeSpent ?? this.timeSpent,
    );
    return state;
  }
}

final Reducer<ENEMState> enemReducer = combineReducers<ENEMState>([
  TypedReducer<ENEMState, FetchRankingAction>(
    fetchingRanking,
  ),
  TypedReducer<ENEMState, FetchRankingSuccessAction>(
    setProfileData,
  ),
  TypedReducer<ENEMState, FetchRankingErrorAction>(
    fetchingRankingError,
  ),
  TypedReducer<ENEMState, SetAnswerTrainingQuestionAction>(
    answerTrainingQuestion,
  ),
  TypedReducer<ENEMState, NavigateTrainingQuestionsFilterAction>(
    filterTrainingQuestions,
  ),
  TypedReducer<ENEMState, FetchTrainingQuestionsSuccessAction>(
    trainingQuestionsRetrieved,
  ),
  TypedReducer<ENEMState, SetAnswerTournamentQuestionAction>(
      answerTournamentQuestion),
  TypedReducer<ENEMState, FetchTournamentQuestionsSuccessAction>(
    tournamentQuestionsRetrieved,
  ),
  TypedReducer<ENEMState, SubmitTournamentGameAction>(
    submitTournament,
  ),
  TypedReducer<ENEMState, NavigateTournamentReviewAction>(
    reviewTournament,
  ),
  TypedReducer<ENEMState, NavigateTournamentAction>(
    tournament,
  ),
]);

ENEMState fetchingRanking(ENEMState state, FetchRankingAction action) {
  return state.copyWith(
      ranking: state.ranking.copyWith(isLoading: true, errorMessage: ""));
}

ENEMState fetchingRankingError(
    ENEMState state, FetchRankingErrorAction action) {
  return state.copyWith(
      ranking: state.ranking
          .copyWith(isLoading: false, errorMessage: DEFAULT_ERROR_MESSAGE));
}

ENEMState setProfileData(ENEMState state, FetchRankingSuccessAction action) {
  return state.copyWith(
      ranking: Data(content: action.ranking, isLoading: false));
}

ENEMState trainingQuestionsRetrieved(
    ENEMState state, FetchTrainingQuestionsSuccessAction action) {
  return state.copyWith(
      trainingQuestions: state.trainingQuestions.copyWith(
    content: state.trainingQuestions.content == null
        ? action.questions
        : [...state.trainingQuestions.content, ...action.questions],
    isLoading: false,
  ));
}

ENEMState answerTrainingQuestion(
    ENEMState state, SetAnswerTrainingQuestionAction action) {
  return state.copyWith(
      trainingQuestions: state.trainingQuestions.copyWith(
          content: state.trainingQuestions.content.map((question) {
    if (question.id == action.questionId) {
      return ENEMQuestionData(
        question.id,
        question.imageURL,
        question.answer,
        question.videos,
        question.width,
        question.height,
        action.answer,
      );
    }
    return question;
  }).toList()));
}

ENEMState filterTrainingQuestions(
    ENEMState state, NavigateTrainingQuestionsFilterAction action) {
  return state.copyWith(trainingQuestions: Data(), domain: action.domain);
}

ENEMState answerTournamentQuestion(
    ENEMState state, SetAnswerTournamentQuestionAction action) {
  return state.copyWith(
      tournamentQuestions: state.tournamentQuestions.copyWith(
          content: state.tournamentQuestions.content.map((question) {
    if (question.id == action.questionId) {
      return ENEMQuestionData(
        question.id,
        question.imageURL,
        question.answer,
        question.videos,
        question.width,
        question.height,
        action.answer,
      );
    }
    return question;
  }).toList()));
}

ENEMState tournamentQuestionsRetrieved(
    ENEMState state, FetchTournamentQuestionsSuccessAction action) {
  return state.copyWith(
    tournamentQuestions: Data(
      content: action.questions,
      isLoading: false,
    ),
    tournamentStartTime: DateTime.now(),
  );
}

ENEMState submitTournament(ENEMState state, SubmitTournamentGameAction action) {
  return state.copyWith(
    tournamentStartTime: null,
  );
}

ENEMState tournament(ENEMState state, NavigateTournamentAction action) {
  return state.copyWith(tournamentQuestions: Data());
}

ENEMState reviewTournament(ENEMState state, NavigateTournamentReviewAction action) {
  return state.copyWith(score: action.score, timeSpent: action.timeSpent);
}
