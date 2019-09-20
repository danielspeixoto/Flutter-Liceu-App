import 'package:app/domain/boundary/ChallengeBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';
import 'package:app/presentation/state/actions/ChallengeActions.dart';
import 'package:app/presentation/state/actions/UserActions.dart';
import 'package:app/presentation/state/aggregates/ChallengeData.dart';
import 'package:app/presentation/state/aggregates/TriviaData.dart';
import 'package:app/presentation/state/navigator/NavigatorActions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:redux/redux.dart';

import '../../app.dart';
import '../app_state.dart';

final analytics = FirebaseAnalytics();

List<Middleware<AppState>> challengeMiddleware(
  IGetChallengeUseCase getChallengeUseCase,
  IGetUserByIdUseCase getUserByIdUseCase,
  ISubmitChallengeAnswersUseCase submitChallengeAnswersUseCase,
) {
  void getRandomChallenge(Store<AppState> store, GetChallengeAction action,
      NextDispatcher next) async {
    next(action);
    try {
      store.dispatch(NavigatePushAction(AppRoutes.challenge));
      final challenge = await getChallengeUseCase.run();
      final futures = challenge.questions.map((trivia) async {
        return TriviaData(
          await getUserByIdUseCase.run(trivia.authorId),
          trivia.question,
          trivia.correctAnswer,
          trivia.wrongAnswer,
        );
      });
      final trivias = await Future.wait(futures);
      final challengeData = ChallengeData(challenge.id, trivias);
      store.dispatch(StartChallengeAction(challengeData));
    } catch (e) {
      print(e);
    }
  }

  void onAnswer(Store<AppState> store, AnswerTriviaAction action,
      NextDispatcher next) async {
    next(action);
    final challengeState = store.state.challengeState;
    try {
      if (challengeState.answers.length ==
          challengeState.challenge.content.questions.length) {
        store.dispatch(ChallengeFinishedAction());
      } else {
        new Future.delayed(const Duration(seconds: 4), () {
          store.dispatch(NextTriviaAction());
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void nextTriviaAction(Store<AppState> store, NextTriviaAction action,
      NextDispatcher next) async {
    next(action);
    new Future.delayed(const Duration(seconds: 1), () {
      store.dispatch(TriviaTimerDecrementAction());
    });
  }

  void onFinished(Store<AppState> store, ChallengeFinishedAction action,
      NextDispatcher next) async {
    next(action);
    final challengeState = store.state.challengeState;
    try {
      var score = 0;
      for (var i = 0;
          i < challengeState.challenge.content.questions.length;
          i++) {
        if (challengeState.challenge.content.questions[i].correctAnswer ==
            challengeState.answers[i]) {
          score++;
        }
      }
      store.dispatch(NavigatePopAction());
      analytics.logPostScore(score: score);
      await submitChallengeAnswersUseCase.run(
          challengeState.challenge.content.id, challengeState.answers);
      store.dispatch(FetchMyChallengesAction());
    } catch (e) {
      print(e);
    }
  }

  void decrementTime(Store<AppState> store, TriviaTimerDecrementAction action,
      NextDispatcher next) async {
    final challengeState = store.state.challengeState;
    if (challengeState.isTimerRunning) {
      if (challengeState.timeLeft == 0) {
        store.dispatch(AnswerTriviaAction(""));
      } else {
        next(action);
        new Future.delayed(const Duration(seconds: 1), () {
          store.dispatch(TriviaTimerDecrementAction());
        });
      }
    }
  }

  void startChallenge(Store<AppState> store, StartChallengeAction action,
      NextDispatcher next) async {
    next(action);
    new Future.delayed(const Duration(seconds: 1), () {
      store.dispatch(TriviaTimerDecrementAction());
    });
  }

  return [
    TypedMiddleware<AppState, GetChallengeAction>(getRandomChallenge),
    TypedMiddleware<AppState, AnswerTriviaAction>(onAnswer),
    TypedMiddleware<AppState, NextTriviaAction>(nextTriviaAction),
    TypedMiddleware<AppState, ChallengeFinishedAction>(onFinished),
    TypedMiddleware<AppState, TriviaTimerDecrementAction>(decrementTime),
    TypedMiddleware<AppState, StartChallengeAction>(startChallenge),
  ];
}
