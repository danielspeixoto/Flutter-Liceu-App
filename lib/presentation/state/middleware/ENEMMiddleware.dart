import 'package:app/domain/aggregates/ENEMGame.dart';
import 'package:app/domain/boundary/ENEMBoundary.dart';
import 'package:app/domain/boundary/RankingBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';
import 'package:app/presentation/state/actions/ENEMActions.dart';
import 'package:app/presentation/state/aggregates/ENEMQuestionData.dart';
import 'package:app/presentation/state/aggregates/GameData.dart';
import 'package:app/presentation/state/aggregates/RankingData.dart';
import 'package:app/presentation/state/navigator/NavigatorActions.dart';
import 'package:redux/redux.dart';

import '../../app.dart';
import '../app_state.dart';

// ignore: non_constant_identifier_names
List<Middleware<AppState>> ENEMMiddleware(
  IGetCurrentRankingUseCase getRankingUseCase,
  IGetUserByIdUseCase getUserById,
  IGetENEMQuestionsUseCase getQuestionsUseCase,
  IGetENEMQuestionsVideosUseCase videosUseCase,
  ISubmitGameUseCase submitGameUseCase,
) {
  void fetchRanking(Store<AppState> store, FetchRankingAction action,
      NextDispatcher next) async {
    next(action);
    try {
      final ranking = await getRankingUseCase.run(30);
      final futures = ranking.games.map((game) async {
        final user = await getUserById.run(game.userId);
        return GameData(game.id, user, game.answers, game.timeSpent);
      });
      final rankingData = RankingData(await Future.wait(futures));
      store.dispatch(RankingRetrievedAction(rankingData));
    } catch (e) {
      print(e);
    }
  }

  void trainingAction(
      Store<AppState> store, TrainingAction action, NextDispatcher next) async {
    next(action);
    store.dispatch(NavigatePushAction(AppRoutes.trainingFilter));
  }

  void trainingFilterAction(Store<AppState> store,
      FilterTrainingQuestions action, NextDispatcher next) async {
    next(action);
    if (store.state.route.last != AppRoutes.training) {
      store.dispatch(NavigatePushAction(AppRoutes.training));
    }
    try {
      final questions = await getQuestionsUseCase.run(1, [action.domain]);
      final futures = questions.map((question) async {
        final videos = await videosUseCase.run(question.id);
        return ENEMQuestionData(
          question.id,
          question.imageURL,
          question.correctAnswer,
          videos,
          question.width,
          question.height,
          -1,
        );
      }).toList();
      final questionsData = await Future.wait(futures);
      store.dispatch(TrainingQuestionsRetrievedAction(questionsData));
    } catch (e) {
      print(e);
    }
  }

  void submitTournament(Store<AppState> store,
      SubmitTournamentGameAction action, NextDispatcher next) async {
    next(action);
    try {
      store.dispatch(NavigateReplaceAction(AppRoutes.tournamentReview));
      final timeSpent = DateTime.now()
          .difference(store.state.enemState.tournamentStartTime)
          .inSeconds;
      final answers =
          store.state.enemState.tournamentQuestions.content.map((question) {
        return ENEMAnswer(
          question.id,
          question.answer,
          question.selectedAnswer,
        );
      });
      await submitGameUseCase.run(answers, timeSpent);
    } catch (e) {
      print(e);
    }
  }

  void tournament(Store<AppState> store, TournamentAction action,
      NextDispatcher next) async {
    next(action);
    if (store.state.route.last != AppRoutes.tournament) {
      store.dispatch(NavigatePushAction(AppRoutes.tournament));
    }
    try {
      final questions = await getQuestionsUseCase.run(10);
      final futures = questions.map((question) async {
        final videos = await videosUseCase.run(question.id);
        return ENEMQuestionData(
          question.id,
          question.imageURL,
          question.correctAnswer,
          videos,
          question.width,
          question.height,
          -1,
        );
      }).toList();
      final questionsData = await Future.wait(futures);
      store.dispatch(TournamentQuestionsRetrievedAction(questionsData));
    } catch (e) {
      print(e);
    }
  }

  return [
    TypedMiddleware<AppState, FetchRankingAction>(fetchRanking),
    TypedMiddleware<AppState, TrainingAction>(trainingAction),
    TypedMiddleware<AppState, FilterTrainingQuestions>(trainingFilterAction),
    TypedMiddleware<AppState, SubmitTournamentGameAction>(
      submitTournament,
    ),
    TypedMiddleware<AppState, TournamentAction>(
      tournament,
    ),
  ];
}
