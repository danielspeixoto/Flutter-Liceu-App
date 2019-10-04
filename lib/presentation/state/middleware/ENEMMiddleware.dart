import 'package:app/domain/aggregates/ENEMGame.dart';
import 'package:app/domain/boundary/ENEMBoundary.dart';
import 'package:app/domain/boundary/RankingBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';
import 'package:app/presentation/state/actions/ENEMActions.dart';
import 'package:app/presentation/state/actions/PageActions.dart';
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
      store.dispatch(FetchRankingSuccessAction(rankingData));
    } catch (e) {
      store.dispatch(PageActionErrorAction(action.toString().substring(11)));
    }
  }

  void navigateTrainingAction(Store<AppState> store,
      NavigateTrainingQuestionsAction action, NextDispatcher next) async {
    next(action);
    store.dispatch(NavigatePushAction(AppRoutes.trainingFilter));
  }

  void trainingAction(Store<AppState> store, StartTrainingAction action,
      NextDispatcher next) async {
    next(action);
    store.dispatch(NavigateTrainingQuestionsAction());
  }

  void trainingFilterAction(Store<AppState> store,
      NavigateTrainingQuestionsFilterAction action, NextDispatcher next) async {
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
      store.dispatch(FetchTrainingQuestionsSuccessAction(questionsData));
    } catch (e) {
      store.dispatch(PageActionErrorAction(action.toString().substring(11)));
    }
  }

  void endTournament(Store<AppState> store, EndTournamentGameAction action,
      NextDispatcher next) async {
    next(action);
    try {
      final timeSpent = DateTime.now()
          .difference(store.state.enemState.tournamentStartTime)
          .inSeconds;
      int score = 0;
          store.state.enemState.tournamentQuestions.content.map((question) async {
        if (question.answer == question.selectedAnswer) {
          score++;
        }
      });
      //final answers = await Future.wait(futures);
     // store.dispatch(SubmitTournamentGameAction(answers, timeSpent));
      store.dispatch(NavigateTournamentReviewAction(score, timeSpent));
    } catch (e) {
      store.dispatch(PageActionErrorAction(action.toString().substring(11)));
    }
  }

  void submitTournament(Store<AppState> store,
      SubmitTournamentGameAction action, NextDispatcher next) async {
    try {
      await submitGameUseCase.run(action.answers, action.timeSpent);
    } catch (e) {
      store.dispatch(PageActionErrorAction(action.toString().substring(11)));
    }
  }

  void reviewTournament(Store<AppState> store,
      NavigateTournamentReviewAction action, NextDispatcher next) {
    next(action);
    store.dispatch(NavigateReplaceAction(AppRoutes.tournamentReview));
  }

  void tournament(Store<AppState> store, NavigateTournamentAction action,
      NextDispatcher next) async {
    next(action);
    if (store.state.route.last != AppRoutes.tournament) {
      store.dispatch(NavigatePushAction(AppRoutes.tournament));
    }
    try {
      final questions = await getQuestionsUseCase.run(5);
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
      store.dispatch(FetchTournamentQuestionsSuccessAction(questionsData));
    } catch (e) {
      store.dispatch(PageActionErrorAction(action.toString().substring(11)));
    }
  }

  void startTournament(Store<AppState> store, StartTournamentAction action,
      NextDispatcher next) {
    next(action);
    store.dispatch(NavigateTournamentAction());
  }

  return [
    TypedMiddleware<AppState, FetchRankingAction>(fetchRanking),
    TypedMiddleware<AppState, NavigateTrainingQuestionsAction>(
        navigateTrainingAction),
    TypedMiddleware<AppState, StartTrainingAction>(trainingAction),
    TypedMiddleware<AppState, NavigateTrainingQuestionsFilterAction>(
        trainingFilterAction),
    TypedMiddleware<AppState, EndTournamentGameAction>(
      endTournament,
    ),
    TypedMiddleware<AppState, SubmitTournamentGameAction>(
      submitTournament,
    ),
    TypedMiddleware<AppState, NavigateTournamentReviewAction>(
      reviewTournament,
    ),
    TypedMiddleware<AppState, NavigateTournamentAction>(
      tournament,
    ),
    TypedMiddleware<AppState, StartTournamentAction>(startTournament),
  ];
}
