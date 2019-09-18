import 'package:app/domain/boundary/ChallengeBoundary.dart';
import 'package:app/domain/boundary/UserBoundary.dart';
import 'package:app/presentation/state/actions/ChallengeActions.dart';
import 'package:app/presentation/state/aggregates/ChallengeData.dart';
import 'package:app/presentation/state/aggregates/TriviaData.dart';
import 'package:app/presentation/state/navigator/NavigatorActions.dart';
import 'package:redux/redux.dart';

import '../../app.dart';
import '../app_state.dart';

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
      }
    } catch (e) {
      print(e);
    }
  }

  void onFinished(Store<AppState> store, ChallengeFinishedAction action,
      NextDispatcher next) async {
    next(action);
    final challengeState = store.state.challengeState;
    try {
      store.dispatch(NavigatePopAction());
      await submitChallengeAnswersUseCase.run(
          challengeState.challenge.content.id, challengeState.answers);
    } catch (e) {
      print(e);
    }
  }

  return [
    TypedMiddleware<AppState, GetChallengeAction>(getRandomChallenge),
    TypedMiddleware<AppState, AnswerTriviaAction>(onAnswer),
    TypedMiddleware<AppState, ChallengeFinishedAction>(onFinished),
//    TypedMiddleware<AppState, AnswerChallengeAction>(answerChallenge),
  ];
}
