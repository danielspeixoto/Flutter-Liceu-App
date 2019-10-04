import 'package:app/domain/aggregates/ENEMGame.dart';
import 'package:app/domain/aggregates/Trivia.dart';
import 'package:app/domain/aggregates/exceptions/CreateTriviaExceptions.dart';
import 'package:app/domain/boundary/UserBoundary.dart';
import 'package:app/presentation/state/actions/ChallengeActions.dart';
import 'package:app/presentation/state/actions/ENEMActions.dart';
import 'package:app/presentation/state/actions/FriendActions.dart';
import 'package:app/presentation/state/actions/LiceuActions.dart';
import 'package:app/presentation/state/actions/LoginActions.dart';
import 'package:app/presentation/state/actions/PageActions.dart';
import 'package:app/presentation/state/actions/PostActions.dart';
import 'package:app/presentation/state/actions/TriviaActions.dart';
import 'package:app/presentation/state/actions/UserActions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:redux/redux.dart';

import '../app_state.dart';

final analytics = FirebaseAnalytics();

List<Middleware<AppState>> analyticsMiddleware(IMyIdUseCase myIdUseCase) {
  void setCurrentScreenPageInit(
      Store<AppState> store, PageInitAction action, NextDispatcher next) async {
    next(action);
    analytics.setCurrentScreen(screenName: action.name);
  }

  void logEventChallengeSomeone(Store<AppState> store,
      ChallengeSomeoneAction action, NextDispatcher next) async {
    next(action);
    analytics.logEvent(name: "challenge_user");
  }

  void logEventPlayRandomChallenge(Store<AppState> store,
      PlayRandomChallengeAction action, NextDispatcher next) async {
    next(action);
    analytics.logEvent(name: "start_random_challenge");
  }

  void logEventAcceptChallenge(Store<AppState> store,
      AcceptChallengeAction action, NextDispatcher next) async {
    next(action);
    analytics.logEvent(name: "accept_challenge");
  }

  void logEventAnswerTrivia(Store<AppState> store, AnswerTriviaAction action,
      NextDispatcher next) async {
    next(action);
    analytics.logEvent(name: "answer_challenge", parameters: {
      "correct": store
              .state
              .challengeState
              .challenge
              .content
              .questions[store.state.challengeState.currentQuestion]
              .correctAnswer ==
          action.answer
    });
  }

  void logEventSubmitChallenge(Store<AppState> store,
      SubmitChallengeAction action, NextDispatcher next) async {
    next(action);
    final score = store.state.challengeState.score();
    analytics.logEvent(name: "submit_challenge", parameters: {
      "score": score,
    });
  }

  void logEventStartTournament(Store<AppState> store,
      StartTournamentAction action, NextDispatcher next) async {
    next(action);
    analytics.logEvent(name: "start_tournament");
  }

  void logEventAnswerTournamentQuestion(Store<AppState> store,
      AnswerTournamentQuestionAction action, NextDispatcher next) async {
    next(action);
    analytics.logEvent(name: "answer_tournament");
  }

  void logEventSubmitTournamentGame(Store<AppState> store,
      SubmitTournamentGameAction action, NextDispatcher next) async {
    next(action);
    analytics.logEvent(name: "submit_tournament", parameters: {
      "time_spent": action.timeSpent,
      "score": ENEMAnswer.score(action.answers)
    });
  }

  void logEventStartTraining(Store<AppState> store, StartTrainingAction action,
      NextDispatcher next) async {
    next(action);
    analytics.logEvent(name: "start_training");
  }

  void logEventAnswerTrainingQuestion(Store<AppState> store,
      AnswerTrainingQuestionAction action, NextDispatcher next) async {
    next(action);
    analytics.logEvent(name: "answer_training");
  }

  void logEventUserClicked(Store<AppState> store, UserClickedAction action,
      NextDispatcher next) async {
    next(action);
    analytics.logEvent(name: "visit_user");
  }

  void logEventInstagramClicked(Store<AppState> store,
      InstagramClickedAction action, NextDispatcher next) async {
    next(action);
    analytics.logEvent(
        name: "visit_social",
        parameters: {"destination": "instagram", "id": action.instagram});
  }

  void logEventLiceuInstagramPageClicked(Store<AppState> store,
      LiceuInstagramPageClickedAction action, NextDispatcher next) async {
    next(action);
    analytics.logEvent(
        name: "visit_liceu_page", parameters: {"destination": "instagram"});
  }

  void logEventLoginSuccess(Store<AppState> store, LoginSuccessAction action,
      NextDispatcher next) async {
    next(action);
    final id = await myIdUseCase.run();
    analytics.setUserProperty(name: "serverUserId", value: id);
  }

  void logEventLogin(
      Store<AppState> store, LoginAction action, NextDispatcher next) async {
    next(action);
    analytics.logLogin(loginMethod: action.method);
  }

  void logEventLogOut(
      Store<AppState> store, LogOutAction action, NextDispatcher next) async {
    next(action);
    analytics.logEvent(name: "logout");
  }

  void logEventSubmitPost(Store<AppState> store, SubmitPostAction action,
      NextDispatcher next) async {
    next(action);
    analytics.logEvent(name: "submit_post");
  }

  void logEventPostShare(Store<AppState> store, PostShareAction action,
      NextDispatcher next) async {
    next(action);
    analytics.logShare(
        contentType: "post", itemId: action.postId, method: "copy");
  }

  void logEventDeletePost(Store<AppState> store, DeletePostAction action,
      NextDispatcher next) async {
    next(action);
    analytics.logEvent(name: "delete_post");
  }

  void logEventSubmitTrivia(Store<AppState> store, SubmitTriviaAction action,
      NextDispatcher next) async {
    next(action);
    analytics.logEvent(name: "submit_trivia", parameters: {
      "domain": domainToString(action.domain),
    });
  }

  return [
    TypedMiddleware<AppState, PageInitAction>(setCurrentScreenPageInit),
    TypedMiddleware<AppState, ChallengeSomeoneAction>(logEventChallengeSomeone),
    TypedMiddleware<AppState, PlayRandomChallengeAction>(
        logEventPlayRandomChallenge),
    TypedMiddleware<AppState, AcceptChallengeAction>(logEventAcceptChallenge),
    TypedMiddleware<AppState, AnswerTriviaAction>(logEventAnswerTrivia),
    TypedMiddleware<AppState, SubmitChallengeAction>(logEventSubmitChallenge),
    TypedMiddleware<AppState, StartTournamentAction>(logEventStartTournament),
    TypedMiddleware<AppState, AnswerTournamentQuestionAction>(
        logEventAnswerTournamentQuestion),
    TypedMiddleware<AppState, SubmitTournamentGameAction>(
        logEventSubmitTournamentGame),
    TypedMiddleware<AppState, StartTrainingAction>(logEventStartTraining),
    TypedMiddleware<AppState, AnswerTrainingQuestionAction>(
        logEventAnswerTrainingQuestion),
    TypedMiddleware<AppState, UserClickedAction>(logEventUserClicked),
    TypedMiddleware<AppState, InstagramClickedAction>(logEventInstagramClicked),
    TypedMiddleware<AppState, LiceuInstagramPageClickedAction>(
        logEventLiceuInstagramPageClicked),
    TypedMiddleware<AppState, LoginSuccessAction>(logEventLoginSuccess),
    TypedMiddleware<AppState, LoginAction>(logEventLogin),
    TypedMiddleware<AppState, LogOutAction>(logEventLogOut),
    TypedMiddleware<AppState, SubmitPostAction>(logEventSubmitPost),
    TypedMiddleware<AppState, PostShareAction>(logEventPostShare),
    TypedMiddleware<AppState, DeletePostAction>(logEventDeletePost),
    TypedMiddleware<AppState, SubmitTriviaAction>(logEventSubmitTrivia),
  ];
}

String domainToString(TriviaDomain domain) {
  switch (domain) {
    case TriviaDomain.LANGUAGES:
      return "linguagens";
    case TriviaDomain.MATHEMATICS:
      return "matemática";
    case TriviaDomain.HUMAN_SCIENCES:
      return "humanas";
    case TriviaDomain.NATURAL_SCIENCES:
      return "naturais";
    default:
      throw Exception("trivia domain does not match options available");
  }
}
