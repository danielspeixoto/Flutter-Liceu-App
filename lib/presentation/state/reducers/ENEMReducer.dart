import 'package:app/presentation/state/actions/ENEMActions.dart';
import 'package:app/presentation/state/aggregates/ENEMQuestionData.dart';
import 'package:app/presentation/state/aggregates/RankingData.dart';
import 'package:redux/redux.dart';

import '../../constants.dart';
import 'Data.dart';

class ENEMState {
  final Data<RankingData> ranking;
  final Data<List<ENEMQuestionData>> trainingQuestions;

  ENEMState(this.ranking, this.trainingQuestions);

  factory ENEMState.initial() =>
      ENEMState(
        Data(),
        Data(),
      );

  ENEMState copyWith({
    Data<RankingData> ranking,
    Data<List<ENEMQuestionData>> trainingQuestions,
  }) {
    final state = ENEMState(
      ranking ?? this.ranking,
      trainingQuestions ?? this.trainingQuestions,
    );
    return state;
  }
}

final Reducer<ENEMState> enemReducer = combineReducers<ENEMState>([
  TypedReducer<ENEMState, FetchRankingAction>(fetchingRanking),
  TypedReducer<ENEMState, RankingRetrievedAction>(setProfileData),
  TypedReducer<ENEMState, FetchingRankingErrorAction>(fetchingRankingError),
  TypedReducer<ENEMState, AnswerTrainingQuestionAction>(answerTrainingQuestion),
  TypedReducer<ENEMState, TrainingQuestionsRetrievedAction>(
      trainingQuestionsRetrieved),
]);

ENEMState fetchingRanking(ENEMState state, FetchRankingAction action) {
  return state.copyWith(
      ranking: state.ranking.copyWith(isLoading: true, errorMessage: ""));
}

ENEMState fetchingRankingError(ENEMState state,
    FetchingRankingErrorAction action) {
  return state.copyWith(
      ranking: state.ranking
          .copyWith(isLoading: false, errorMessage: DEFAULT_ERROR_MESSAGE));
}

ENEMState setProfileData(ENEMState state, RankingRetrievedAction action) {
  return state.copyWith(
      ranking: Data(content: action.ranking, isLoading: false));
}

ENEMState trainingQuestionsRetrieved(ENEMState state,
    TrainingQuestionsRetrievedAction action) {
  return state.copyWith(
      trainingQuestions: state.trainingQuestions.copyWith(
        content: state.trainingQuestions.content == null
            ? action.questions
//        : [...state.trainingQuestions.content, ...action.questions],
            : [...action.questions],
        isLoading: false,
      ));
}

ENEMState answerTrainingQuestion(ENEMState state,
    AnswerTrainingQuestionAction action) {
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
                action.answer,);
            }
            return question;
          }).toList()
      )
  );
}
