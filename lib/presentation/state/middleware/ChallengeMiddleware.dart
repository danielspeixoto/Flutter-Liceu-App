import 'package:app/domain/aggregates/Challenge.dart';
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
  IChallengeSomeoneUseCase challengeSomeoneUseCase,
  IGetUserByIdUseCase getUserByIdUseCase,
  ISubmitChallengeAnswersUseCase submitChallengeAnswersUseCase,
) {
  void dispatchChallenge(
      Store<AppState> store, Challenge challenge, NextDispatcher next) async {
    try {
      final futures = challenge.questions.map((trivia) async {
        return TriviaData(
          await getUserByIdUseCase.run(trivia.authorId),
          trivia.question,
          trivia.correctAnswer,
          trivia.wrongAnswer,
        );
      });
      final trivias = await Future.wait(futures);
      final challenger = await getUserByIdUseCase.run(challenge.challenger);
      final challenged = challenge.challenged != null
          ? await getUserByIdUseCase.run(challenge.challenged)
          : null;
      final challengeData =
          ChallengeData(challenge.id, trivias, challenger, challenged);
      store.dispatch(SetChallengeAction(challengeData));
    } catch (e) {
      print(e);
    }
  }

  void getRandomChallenge(Store<AppState> store, NavigateChallengeAction action,
      NextDispatcher next) async {
    next(action);
    try {
      store.dispatch(NavigatePushAction(AppRoutes.challenge));

      final challenge = await getChallengeUseCase.run();
      dispatchChallenge(store, challenge, next);
    } catch (e) {
      print(e);
    }
  }

  void challengeSomeone(Store<AppState> store, NavigateChallengeSomeoneAction action,
      NextDispatcher next) async {
    next(action);
    try {
      store.dispatch(NavigatePushAction(AppRoutes.challenge));

      final challenge = await challengeSomeoneUseCase.run(action.challengedId);
      dispatchChallenge(store, challenge, next);
    } catch (e) {
      print(e);
    }
  }

  void onAnswer(Store<AppState> store, SetAnswerTriviaAction action,
      NextDispatcher next) async {
    next(action);
    final challengeState = store.state.challengeState;
    try {
      if (challengeState.answers.length ==
          challengeState.challenge.content.questions.length) {
        new Future.delayed(const Duration(seconds: 3), () {
          store.dispatch(SubmitChallengeAction());
        });
      } else {
        new Future.delayed(const Duration(seconds: 2), () {
          store.dispatch(SetNextTriviaAction());
        });
      }
    } catch (e) {
      print(e);
    }
  }

  void nextTriviaAction(Store<AppState> store, SetNextTriviaAction action,
      NextDispatcher next) async {
    next(action);
    new Future.delayed(const Duration(seconds: 1), () {
      store.dispatch(SetTriviaTimerDecrementAction());
    });
  }

  void onFinished(Store<AppState> store, SubmitChallengeAction action,
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
      new Future.delayed(const Duration(seconds: 3), () {
        store.dispatch(FetchUserChallengesAction());
      });
    } catch (e) {
      print(e);
    }
  }

  void decrementTime(Store<AppState> store, SetTriviaTimerDecrementAction action,
      NextDispatcher next) async {
    final challengeState = store.state.challengeState;
    if (challengeState.isTimerRunning) {
      if (challengeState.timeLeft == 0) {
        store.dispatch(SetAnswerTriviaAction(""));
      } else {
        next(action);
        new Future.delayed(const Duration(seconds: 1), () {
          store.dispatch(SetTriviaTimerDecrementAction());
        });
      }
    }
  }

  void startChallenge(Store<AppState> store, SetChallengeAction action,
      NextDispatcher next) async {
    next(action);
    new Future.delayed(const Duration(seconds: 1), () {
      store.dispatch(SetTriviaTimerDecrementAction());
    });
  }

  return [
    TypedMiddleware<AppState, NavigateChallengeAction>(getRandomChallenge),
    TypedMiddleware<AppState, NavigateChallengeSomeoneAction>(challengeSomeone),
    TypedMiddleware<AppState, SetAnswerTriviaAction>(onAnswer),
    TypedMiddleware<AppState, SetNextTriviaAction>(nextTriviaAction),
    TypedMiddleware<AppState, SubmitChallengeAction>(onFinished),
    TypedMiddleware<AppState, SetTriviaTimerDecrementAction>(decrementTime),
    TypedMiddleware<AppState, SetChallengeAction>(startChallenge),
  ];
}
