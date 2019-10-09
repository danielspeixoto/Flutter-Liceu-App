import 'package:app/domain/aggregates/ENEMGame.dart';
import 'package:app/domain/aggregates/Post.dart';
import 'package:app/domain/aggregates/Trivia.dart';
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
import 'package:app/presentation/util/analytics.dart';
import 'package:redux/redux.dart';

import '../app_state.dart';

List<Middleware<AppState>> analyticsMiddleware(IMyIdUseCase myIdUseCase) {
  void setCurrentScreenPageInit(
      Store<AppState> store, PageInitAction action, NextDispatcher next) async {
    next(action);
    LiceuAnalytics.setCurrentScreen(action.name);
  }

  void logEventChallengeSomeone(Store<AppState> store,
      ChallengeSomeoneAction action, NextDispatcher next) async {
    next(action);
    LiceuAnalytics.logEvent("challenge_user");
  }

  void logEventPlayRandomChallenge(Store<AppState> store,
      PlayRandomChallengeAction action, NextDispatcher next) async {
    next(action);
    LiceuAnalytics.logEvent("start_random_challenge");
  }

  void logEventAcceptChallenge(Store<AppState> store,
      AcceptChallengeAction action, NextDispatcher next) async {
    next(action);
    LiceuAnalytics.logEvent("accept_challenge");
  }

  void logEventAnswerTrivia(Store<AppState> store, AnswerTriviaAction action,
      NextDispatcher next) async {
    next(action);
    LiceuAnalytics.logEvent("answer_challenge", {
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
    LiceuAnalytics.logEvent("submit_challenge", {
      "score": score,
    });
  }

  void logEventStartTournament(Store<AppState> store,
      StartTournamentAction action, NextDispatcher next) async {
    next(action);
    LiceuAnalytics.logEvent("start_tournament");
  }

  void logEventAnswerTournamentQuestion(Store<AppState> store,
      AnswerTournamentQuestionAction action, NextDispatcher next) async {
    next(action);
    LiceuAnalytics.logEvent("answer_tournament");
  }

  void logEventSubmitTournamentGame(Store<AppState> store,
      SubmitTournamentGameAction action, NextDispatcher next) async {
    next(action);
    LiceuAnalytics.logEvent("submit_tournament", {
      "time_spent": action.timeSpent,
      "score": ENEMAnswer.score(action.answers)
    });
  }

  void logEventStartTraining(Store<AppState> store, StartTrainingAction action,
      NextDispatcher next) async {
    next(action);
    LiceuAnalytics.logEvent("start_training");
  }

  void logEventAnswerTrainingQuestion(Store<AppState> store,
      AnswerTrainingQuestionAction action, NextDispatcher next) async {
    next(action);
    LiceuAnalytics.logEvent("answer_training");
  }

  void logEventUserClicked(Store<AppState> store, UserClickedAction action,
      NextDispatcher next) async {
    next(action);
    LiceuAnalytics.logEvent("visit_user", {"id": action.user.id});
  }

  void logEventInstagramClicked(Store<AppState> store,
      InstagramClickedAction action, NextDispatcher next) async {
    next(action);
    LiceuAnalytics.logEvent(
        "visit_social", {"destination": "instagram", "id": action.instagram});
  }

  void logEventLiceuInstagramPageClicked(Store<AppState> store,
      LiceuInstagramPageClickedAction action, NextDispatcher next) async {
    next(action);
    LiceuAnalytics.logEvent("visit_liceu_page", {"destination": "instagram"});
  }

  void logEventLoginSuccess(Store<AppState> store, LoginSuccessAction action,
      NextDispatcher next) async {
    next(action);
    final id = await myIdUseCase.run();
    LiceuAnalytics.setUserProperty("serverUserId", id);
  }

  void logEventLogin(
      Store<AppState> store, LoginAction action, NextDispatcher next) async {
    next(action);
    LiceuAnalytics.logLogin(loginMethod: action.method);
  }

  void logEventLogOut(
      Store<AppState> store, LogOutAction action, NextDispatcher next) async {
    next(action);
    LiceuAnalytics.logEvent("logout");
  }

  void logEventSubmitTextPost(Store<AppState> store,
      SubmitTextPostAction action, NextDispatcher next) async {
    next(action);
    LiceuAnalytics.logEvent("submit_post");
  }

  void logEventSubmitImagePost(Store<AppState> store,
      SubmitImagePostAction action, NextDispatcher next) {
    next(action);
    LiceuAnalytics.logEvent("submit_image_post");
  }

  void logEventPostShare(Store<AppState> store, PostShareAction action,
      NextDispatcher next) async {
    next(action);
    LiceuAnalytics.logShare(
        contentType: postTypeToString(action.type),
        itemId: action.postId,
        method: "copy");
  }

  void logEventDeletePost(Store<AppState> store, DeletePostAction action,
      NextDispatcher next) async {
    next(action);
    LiceuAnalytics.logEvent("delete_post");
  }

  void logEventSubmitTrivia(Store<AppState> store, SubmitTriviaAction action,
      NextDispatcher next) async {
    next(action);
    LiceuAnalytics.logEvent("submit_trivia", {
      "domain": domainToString(action.domain),
    });
  }

  void logChallengeMe(
      Store<AppState> store, ChallengeMeAction action, NextDispatcher next) {
    next(action);
    LiceuAnalytics.logEvent("share_challenge");
  }

  void logUserProfileShare(Store<AppState> store, UserProfileShareAction action,
      NextDispatcher next) {
    next(action);
    LiceuAnalytics.logEvent("share_profile");
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
    TypedMiddleware<AppState, SubmitTextPostAction>(logEventSubmitTextPost),
    TypedMiddleware<AppState, SubmitImagePostAction>(logEventSubmitImagePost),
    TypedMiddleware<AppState, PostShareAction>(logEventPostShare),
    TypedMiddleware<AppState, DeletePostAction>(logEventDeletePost),
    TypedMiddleware<AppState, SubmitTriviaAction>(logEventSubmitTrivia),
    TypedMiddleware<AppState, ChallengeMeAction>(logChallengeMe),
    TypedMiddleware<AppState, UserProfileShareAction>(logUserProfileShare),
  ];
}

String postTypeToString(PostType domain) {
  switch (domain) {
    case PostType.IMAGE:
      return "image";
    case PostType.TEXT:
      return "text";
    default:
      throw Exception("post type does not match options available");
  }
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
