import 'package:app/domain/aggregates/ENEMGame.dart';
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
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:redux/redux.dart';

import '../app_state.dart';

class AnalyticsMiddleware extends MiddlewareClass<AppState> {
  final analytics = FirebaseAnalytics();
  final IMyIdUseCase myIdUseCase;

  AnalyticsMiddleware(
    this.myIdUseCase,
  );

  @override
  Future call(
      Store<AppState> store, dynamic action, NextDispatcher next) async {
    if (action is PageInitAction) {
      analytics.setCurrentScreen(screenName: action.name);
    } else if (action is ChallengeSomeoneAction) {
      analytics.logEvent(name: "challenge_user");
    } else if (action is PlayRandomChallengeAction) {
      analytics.logEvent(name: "start_random_challenge");
    } else if (action is AcceptChallengeAction) {
      analytics.logEvent(name: "accept_challenge");
    } else if (action is AnswerTriviaAction) {
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
    } else if (action is SubmitChallengeAction) {
      final score = store.state.challengeState.score();
      analytics.logEvent(name: "submit_challenge", parameters: {
        "score": score,
      });
    } else if (action is StartTournamentAction) {
      analytics.logEvent(name: "start_tournament");
    } else if (action is AnswerTournamentQuestionAction) {
      analytics.logEvent(name: "answer_tournament");
    } else if (action is SubmitTournamentGameAction) {
      analytics.logEvent(name: "submit_tournament", parameters: {
        "time_spent": action.timeSpent,
        "score": ENEMAnswer.score(action.answers)
      });
    } else if (action is StartTrainingAction) {
      analytics.logEvent(name: "start_training");
    } else if (action is AnswerTrainingQuestionAction) {
      analytics.logEvent(name: "answer_training");
    } else if (action is UserClickedAction) {
      analytics.logEvent(name: "visit_user");
    } else if (action is InstagramClickedAction) {
      analytics.logEvent(
          name: "visit_social",
          parameters: {"destination": "instagram", "id": action.instagram});
    } else if (action is LiceuInstagramPageClicked) {
      analytics.logEvent(
          name: "visit_liceu_page", parameters: {"destination": "instagram"});
    } else if (action is LoginSuccessAction) {
      final id = await myIdUseCase.run();
      analytics.setUserId(id);
    } else if (action is LoginAction) {
      analytics.logLogin(loginMethod: action.method);
    } else if (action is LogOutAction) {
      analytics.logEvent(name: "logout");
    } else if (action is SubmitPostAction) {
      analytics.logEvent(name: "submit_post");
    } else if (action is PostShareAction) {
      analytics.logShare(
          contentType: "post", itemId: action.postId, method: "copy");
    } else if (action is DeletePostAction) {
      analytics.logEvent(name: "delete_post");
    } else if (action is SubmitTriviaAction) {
      analytics.logEvent(name: "submit_trivia", parameters: {
        "domain": domainToString(action.domain),
      });
    }
    next(action);
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
}
