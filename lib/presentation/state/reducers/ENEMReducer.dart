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

  ENEMState(this.ranking, this.trainingQuestions, this.domain,
      this.tournamentQuestions, this.tournamentStartTime);

  factory ENEMState.initial() => ENEMState(
        Data(),
        Data(),
        null,
        Data(),
        null,
      );

  ENEMState copyWith({
    Data<RankingData> ranking,
    Data<List<ENEMQuestionData>> trainingQuestions,
    QuestionDomain domain,
    Data<List<ENEMQuestionData>> tournamentQuestions,
    DateTime tournamentStartTime,
  }) {
    final state = ENEMState(
      ranking ?? this.ranking,
      trainingQuestions ?? this.trainingQuestions,
      domain ?? this.domain,
      tournamentQuestions ?? this.tournamentQuestions,
      tournamentStartTime ?? this.tournamentStartTime,
    );
    return state;
  }
}

final Reducer<ENEMState> enemReducer = combineReducers<ENEMState>([
  TypedReducer<ENEMState, FetchRankingAction>(
    fetchingRanking,
  ),
  TypedReducer<ENEMState, RankingRetrievedAction>(
    setProfileData,
  ),
  TypedReducer<ENEMState, FetchingRankingErrorAction>(
    fetchingRankingError,
  ),
  TypedReducer<ENEMState, AnswerTrainingQuestionAction>(
    answerTrainingQuestion,
  ),
  TypedReducer<ENEMState, FilterTrainingQuestions>(
    filterTrainingQuestions,
  ),
  TypedReducer<ENEMState, TrainingQuestionsRetrievedAction>(
    trainingQuestionsRetrieved,
  ),
  TypedReducer<ENEMState, AnswerTournamentQuestionAction>(
      answerTournamentQuestion),
  TypedReducer<ENEMState, TournamentQuestionsRetrievedAction>(
    tournamentQuestionsRetrieved,
  ),
  TypedReducer<ENEMState, SubmitTournamentGameAction>(
    submitTournament,
  ),
  TypedReducer<ENEMState, TournamentAction>(
    tournament,
  ),
]);

ENEMState fetchingRanking(ENEMState state, FetchRankingAction action) {
  return state.copyWith(
      ranking: state.ranking.copyWith(isLoading: true, errorMessage: ""));
}

ENEMState fetchingRankingError(
    ENEMState state, FetchingRankingErrorAction action) {
  return state.copyWith(
      ranking: state.ranking
          .copyWith(isLoading: false, errorMessage: DEFAULT_ERROR_MESSAGE));
}

ENEMState setProfileData(ENEMState state, RankingRetrievedAction action) {
  return state.copyWith(
      ranking: Data(content: action.ranking, isLoading: false));
}

ENEMState trainingQuestionsRetrieved(
    ENEMState state, TrainingQuestionsRetrievedAction action) {
  return state.copyWith(
      trainingQuestions: state.trainingQuestions.copyWith(
    content: state.trainingQuestions.content == null
        ? action.questions
        : [...state.trainingQuestions.content, ...action.questions],
    isLoading: false,
  ));
}

ENEMState answerTrainingQuestion(
    ENEMState state, AnswerTrainingQuestionAction action) {
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
    ENEMState state, FilterTrainingQuestions action) {
  return state.copyWith(trainingQuestions: Data(), domain: action.domain);
}

ENEMState answerTournamentQuestion(
    ENEMState state, AnswerTournamentQuestionAction action) {
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
    ENEMState state, TournamentQuestionsRetrievedAction action) {
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

ENEMState tournament(ENEMState state, TournamentAction action) {
  return state.copyWith(tournamentQuestions: Data());
}
