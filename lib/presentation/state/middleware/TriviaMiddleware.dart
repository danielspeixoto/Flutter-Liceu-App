import 'package:app/domain/boundary/TriviaBoundary.dart';
import 'package:app/presentation/state/actions/TriviaActions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:redux/redux.dart';
import '../app_state.dart';

final analytics = FirebaseAnalytics();

List<Middleware<AppState>> triviaMiddleware(
    ICreateTriviaUseCase createTriviaUseCase) {
  void createTrivia(Store<AppState> store, CreateTriviaAction action,
      NextDispatcher next) async {
    try {
      await createTriviaUseCase.run(
          action.trivia.question,
          action.trivia.correctAnswer,
          action.trivia.wrongAnswer,
          action.trivia.domain);
    } catch (e) {
      print(e);
    }
  }

  return [
    TypedMiddleware<AppState, CreateTriviaAction>(createTrivia)
  ];
}
